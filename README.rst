LearnGit
========

Interactive Git tutorials through a web interface. Mimics a linux terminal for a more example based approach to learning, and help beginners get familiar with the command line. 

*This is currently a work in progress so may change significantly*

Web UI
------

The web ui is created using Flask. A debug server can be run with the following command::
    
    python web.py


Scripts
-------

create_javascript.py

Creates a javascript file containing all the commands and responses for a lesson. Must be run from the scripts folder.

A lesson is specified in a series of bash scripts:
    * setup.sh - Commands required to get to the starting point of the lesson (e.g. cloning a git repo)
    * lesson.sh - The commands the user must enter to go through the lesson
    * teardown.sh - Commands to bring us back to a clean state

::
    # Comment - may span multiple lines
    ; Hidden command (is executed before the next command, but the output is not logged)

    __repo__ = folder representing the git repository created for the project. It is replace with the name 
    of the lesson when being shown to the user
