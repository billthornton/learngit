import os
import sys
import json
import subprocess
from cgi import escape
from collections import namedtuple


"""
create_javascript.py

Creates a javascript file containing all the commands and responses for a lesson.

A lesson is specified in a series of bash scripts:
    * setup.sh - Commands required to get to the starting point of the lesson (e.g. cloning a git repo)
    * lesson.sh - The commands the user must enter to go through the lesson
    * teardown.sh - Commands to bring us back to a clean state

# Comment - may span multiple lines
; Hidden command (is executed before the next command, but the output is not logged)

__repo__ = folder representing the git repository created for the project. It is replace with the name 
of the lesson when being shown to the user

"""

BASE_DIR = os.path.dirname(os.path.realpath(__file__))

# Note: if you add a command here, consider adding it to the help in the front-end
GLOBAL_COMMANDS = [
    'ls', 'ls -l', 'll', 'ls -h', 'ls -halF', 'pwd',
    'git status', 'git log', 'git diff'
]

GLOBAL_REPLACES = {
    # TODO: Make dynamic
    '/root/code/learngit/site/lessons/' : '/home/learngit/'
}

class Command(object):
    """ Runs the specified command, and records the output """
    def __init__(self, command, hidden_commands, scenario, comments, base_dir, lesson_name):
        self.comments = comments
        self.scenario = scenario
        self.lesson_name = lesson_name

        self.hidden_commands = hidden_commands
        self.base_dir = base_dir
        self.command = command
        self.global_responses = {}
        # Run all global commands at this point
        #if not command.startswith('git clone '):
        self.global_responses = self.run_global_commands()
        # Run the main command and get a response
        self.response = self.run()

    def run_global_commands(self):
        global_responses = {}
        for cmd in GLOBAL_COMMANDS:
            resp = self.run_command(cmd)
            global_responses[cmd] = resp
        return global_responses

    def remap_command(self, command):
        # TODO: Find a better way to do this
        if command.startswith('git clone'):
            path = os.path.realpath(os.path.join(self.base_dir, '../__repo__'))
            command = 'git clone ' + path

        return command

    def run_command(self, command):
        command = self.remap_command(command)
        # Only prefix if we aren't cd'ing into out workspace 
        if not command.startswith('cd __repo__'):
            prefix = 'cd {base_dir}; '.format(base_dir=self.base_dir)
            command = prefix + command
        print ' >>  ' + command
        r = subprocess.Popen(command, shell=True, stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
        response = r.stdout.read()
        for repl_for, repl_with in GLOBAL_REPLACES.iteritems():
            response = response.replace(repl_for, repl_with)
        response = response.replace('__repo__', self.lesson_name)
        return response

    def run(self):
        # Run any hidden commands
        for cmd in self.hidden_commands:
            cmd = self.remap_command(cmd)
            # Do nothing with the output
            self.run_command(cmd)
        command = self.remap_command(self.command)
        return self.run_command(command)


class Lesson(object):
    """ Executes the bash scripts making up an individual lesson """
    def __init__(self, lesson_dir, lesson_name):
        self.lesson_dir = lesson_dir
        self.lesson_name = lesson_name

    def teardown(self):
        """ Delete files created during the lesson (or left during a failed run) """
        print "Running teardown..."
        os.system(os.path.join(self.lesson_dir, 'teardown.sh'))
        print "Completed teardown..."

    def __enter__(self):
        """ Run the setup and parse all the commands in the bash script """
        # Make sure the directory is clean
        self.teardown()
        # Run setup instructions
        print "Running setup..."
        os.system(os.path.join(self.lesson_dir, 'setup.sh'))
        print "Completed setup"
        self.parse_commands()
        self.current_command = 0
        return self

    def __exit__(self, type, value, traceback):
        # Delete our temporary workspace folders
        self.teardown()

    def run(self):
        """ Run each of the commands for a lesson """
        c = []
        for command in self.commands:
            display_command = command.command
            for repl_for, repl_with in GLOBAL_REPLACES.iteritems():
                display_command = display_command.replace(repl_for, repl_with)
            display_command = display_command.replace('__repo__', self.lesson_name)
            global_responses = {}
            for cmd, resp in command.global_responses.iteritems():
                global_responses[cmd] = escape(resp.strip()).replace('\n', '<br />')
            response = escape(command.response.strip()).replace('\n', '<br />')
            e = {
                'command': display_command,
                'response': response,
                'global_responses': global_responses,
                'comments': [escape(comment) for comment in command.comments],
                'scenario': [escape(scenario) for scenario in command.scenario]
            }
            c.append(e)
        filepath = os.path.join(BASE_DIR, '../static/js/lessons/%s.js' % self.lesson_name.replace('_', '-'))
        print "!!! Saving to file %s !!!" % os.path.basename(filepath)
        with open(filepath, 'wb') as f:
            f.write('var commands = ')
            json.dump(c, f, indent=4)



        '''
        # Testing through the terminal
        for command in self.commands:
            while True:
                print "\n".join(command.comments)
                cmd = raw_input('>> ').strip()
                if cmd != command.command and cmd in GLOBAL_COMMANDS:
                    print command.global_responses[cmd]
                    continue
                if cmd != command.command:
                    print "Invalid command, next command is: " + command.command
                    continue
                print command.response
                break
        '''


    def next_command(self):
        # TODO: exceptions
        self.current_command += 1
        return self.commands[self.current_command]

    def parse_commands(self):
        # TODO: Allow lesson files in the format lesson_XXXX.sh
        lesson_path = os.path.join(self.lesson_dir, 'lesson.sh')
        workspace = os.path.join(self.lesson_dir, 'workspace')
        with open(lesson_path, 'r') as f:
            lines = f.readlines()

        scenario = []
        comments = []
        hidden_commands = []
        commands = []

        for line in lines:
            line = line.strip()
            # Skip empty lines
            if not line:
                continue

            if line.startswith('##'):
                scenario.append(line.strip('# '))
            elif line.startswith('#'):
                comments.append(line.strip('# '))
            elif line.startswith(';'):
                hidden_commands.append(line.strip('; '))
            else:
                command = line.strip()
                # TODO: Re-code this section
                if command.startswith('cd '):
                    # TODO: Need better handling for remapping 'cd' calls
                    workspace = os.path.join(workspace, '__repo__')
                c = Command(command, hidden_commands, scenario, comments, workspace, self.lesson_name)
                commands.append(c)
                # Reset the the scenario, comments and hidden commands
                scenario = []
                comments = []
                hidden_commands = []

        self.commands = commands


def main():
    print '!!! WARNING - This script executes a number of shell scripts which may perform harmful operations if misconfigured.'
    resp = raw_input('Are you sure you wish to run this script? (y/N)')
    if resp.lower() not in ['y', 'yes']:
        sys.exit(0)
    lessons_path = os.path.join(BASE_DIR, '../lessons')
    for directory in os.listdir(lessons_path):
        lesson_dir = os.path.join(lessons_path, directory)
        with Lesson(lesson_dir, directory) as lesson:
            lesson.run()

if __name__ == '__main__':
    main()
