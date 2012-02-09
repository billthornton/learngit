
(function($) {

    var methods = {
        init: function(options) {
            var settings = $.extend({}, options);
            $.data(document.body, 'command_index', 0);
            add_comment(commands[0].comments);
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
            // TODO: Keep a command history, so pressing up loads in the previous command
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
        run_command: function(e) {
            if (e.which != 13) return; // 13 == Enter key
            var command_index = $.data(document.body, 'command_index');
            var current_command = commands[command_index];
            var cmd = $(this).val();
            $(this).val('');
            $('#term-input-hidden').val('');
            var response = current_command.response;
            var normal_command = true;
            // TODO: Add support for Global commands (move this out into it's own method)
            if (cmd == "commands") {
                normal_command = false;
                response = "Commands: <br />";
                // TODO: Sort commands by name
                $.each(current_command.global_responses, function(i, c) {
                    response += '&nbsp;&nbsp;' + i + '<br />'
                });
            } else if (cmd != current_command.command) {
                if (current_command.global_responses[cmd] !== undefined) {
                    response = current_command.global_responses[cmd];
                    normal_command = false;
                } else {
                    console.log(current_command);
                    alert("Unrecognized command. Only a selection of commands may be run, type 'commands' to see the full list");
                    return;
                }
            }

            var contents = $('.term-contents');

            // This is horrible, replace in backbone.js rewrite
            escaped_cmd = document.createTextNode(cmd).data;
            contents.append('<li class="command">&gt;&gt; ' + escaped_cmd + '</li>');
            contents.append('<li class="response">' + response + '</li>');

            // Do not progress the pointer for random commands
            if (normal_command) {
                command_index++;
                if (command_index < commands.length) {
                    $.data(document.body, 'command_index', command_index);
                    // Adds the next comment
                    add_comment(commands[command_index].comments);
                } else {
                    console.log("Finished!");
                }
            }
            $('.term-contents-container').scrollTop(contents.height())
            
        }
    }


    function add_comment(comment_list) {
        var comments = '<li class="comment">';
        $.each(comment_list, function(index, el) {
            comments += el + '<br />';
        });
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
