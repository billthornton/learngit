
(function($) {

    var methods = {
        init: function(options) {
            var settings = $.extend({}, options);
            $.data(document.body, 'command_index', 0);
            $.data(document.body, 'command_history', []);
            $.data(document.body, 'command_history_index', -1);
            add_comment(commands[0]);
            $('#term-input').focus();    
            // Focus input box when clicking on the terminal
            $('.term').on('click', function() {
                $('#term-input').focus();    
            });
            // Auto completion prompt
            $('#term-input-hidden').val('');
            $('#term-input').on('keyup', methods.auto_completion_prompt);
            // Auto complete on tab key
            $('#term-input').on('keydown', methods.tab_auto_completion);
            // Run entered command on enter key
            $('#term-input').on('keydown', methods.run_command);
            // Keep a command history, so pressing up loads in the previous command
            $('#term-input').on('keyup', methods.history);
        },

        auto_completion_prompt: function(e) {
            var command_index = $.data(document.body, 'command_index');
            var current_command = commands[command_index].command;
            var text_input = $(this).val();
            if (text_input && current_command.indexOf(text_input) == 0) {
                $('#term-input-hidden').val(current_command);
            } else {
                $('#term-input-hidden').val('');
            }
        },

        tab_auto_completion: function(e) {
            var text_input = $(this).val();
            var command_index = $.data(document.body, 'command_index');
            var current_command = commands[command_index].command;
            // Allow a double space tab to auto complate (for ipad etc.)
            if (e.which == 32) { // 32 == Space bar
                if (text_input && text_input[text_input.length-1] === ' ') {
                    $(this).val(current_command);
                    e.preventDefault();
                    return;
                }
            } else if (e.which == 9) { // 9 = Tab char
                // If the current command starts with the input value, 
                // replace with the current command
                // TODO: Should we allow tab completion on empty text_input?
                if (current_command.indexOf(text_input) == 0) {
                    $(this).val(current_command);
                }
                e.preventDefault();
            }
        },

        history: function(e) {
            // Change the below into a switch statement
            if (e.which != 38 && e.which != 40) { // 38 == up arrow 40 == down arrow
                // Reset the index when a key other than up/down arrow is pressed
                // TODO: Shouldn't be reset on movement keys (left/right/home/end)
                $.data(document.body, 'command_history_index', -1);
                return;
            }

            var command_history = $.data(document.body, 'command_history');
            var command_history_index = $.data(document.body, 'command_history_index');
            // On up arrow, show the next history command
            if (e.which == 38) {
                // Do nothing if we are at the end of the history
                if (!command_history.length || command_history_index >= command_history.length) {
                    return;
                }
                command_history_index++;

            // On down arrow, show the previous command
            } else if (e.which == 40) {
                // Blank the input if we are the start of the history
                if (command_history_index === -1) {
                    $(this).val();
                    $('#term-input-hidden').val('');
                } else {
                    command_history_index--;
                }
            }

            // We want to search the history in reverse order (most recent command first)
            // i.e. the first item we want is command_history[-1]
            var pointer = command_history.length - command_history_index - 1;
            $(this).val(command_history[pointer]);
            $('#term-input-hidden').val('');
            $.data(document.body, 'command_history', command_history);
            $.data(document.body, 'command_history_index', command_history_index);
        },

        run_command: function(e) {
            if (e.which != 13) return; // 13 == Enter key
            var command_index = $.data(document.body, 'command_index');
            var current_command = commands[command_index];
            var command_to_exec = current_command.command;
            var text_input = $(this).val();
            $(this).val('');
            $('#term-input-hidden').val('');
            var response = current_command.response;
            var normal_command = true;
            // TODO: if the current command matche
            // TODO: Add support for Global commands (move this out into it's own method)
            if (text_input == "commands" || text_input == "help") {
                command_to_exec = text_input;
                normal_command = false;
                response = "Commands: <br />";
                // TODO: Sort commands by name
                $.each(current_command.global_responses, function(i, c) {
                    response += '&nbsp;&nbsp;' + i + '<br />'
                });
            // Else if the entered command does not start with the target command check if it is a global command
            } else if (current_command.command.indexOf(text_input) != 0) {
                if (current_command.global_responses[text_input] !== undefined) {
                    command_to_exec = text_input;
                    response = current_command.global_responses[text_input];
                    normal_command = false;
                } else {
                    alert("Unrecognized command. Only a selection of commands may be run, type 'commands' to see the full list");
                    return;
                }
            }

            var contents = $('.term-contents');

            escaped_cmd = document.createTextNode(command_to_exec).data;
            contents.append('<li class="command">&gt;&gt; ' + escaped_cmd + '</li>');
            contents.append('<li class="response">' + response + '</li>');

            //TODO: Move this somewhere else
            var git_status = current_command.global_responses['git status -s'];
            if (git_status.indexOf('fatal:') != 0) {
                $('.git-status').html(git_status);
            }

            // Keep track of a history of commands
            var command_history = $.data(document.body, 'command_history');
            command_history.push(command_to_exec);
            $.data(document.body, 'command_history', command_history);

            // Do not progress the pointer for random commands
            if (normal_command) {
                command_index++;
                if (command_index < commands.length) {
                    $.data(document.body, 'command_index', command_index);
                    // Adds the next comment
                    add_comment(commands[command_index]);
                } else {
                    console.log("Finished!");
                }
            }
            $('.term-contents-container').scrollTop(contents.height())
            
        }
    }


    function add_comment(command) {
        var comments = '<li class="comment">';
        $.each(command.comments, function(index, el) {
            comments += el + '<br />';
        });
        comments += '<span class="scenario">';
        $.each(command.scenario, function(index, el) {
            comments += el + '<br />';
        });
        comments += '</span>';
        comments += '<div class="next-command">Next Command: ' + document.createTextNode(command.command).data + '</div>';
        $('.term-contents').append(comments + '</li>');
    }

    $.fn.gitTerminal = function( method ) {
        // Method calling logic
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || ! method ) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' +  method + ' does not exist on incident');
        }
    };


})(jQuery);


$(function() {
    $.fn.gitTerminal();
});
