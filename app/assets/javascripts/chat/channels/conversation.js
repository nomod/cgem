App.chat_conversation = App.cable.subscriptions.create("Chat::ConversationChannel", {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {

        var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");

        if (data['window'] !== undefined) {
            var conversation_visible = conversation.is(':visible');

            if (conversation_visible) {
                var messages_visible = (conversation).find('.panel-body').is(':visible');

                if (!messages_visible) {
                    conversation.removeClass('panel-default').addClass('panel-success');
                }
                conversation.find('.messages-list').find('ul').append(data['message']);
            }
            else {
                $('#conversations-list').append(data['window']);
                conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
                conversation.find('.panel-body').toggle();
            }

            ion.sound.play("button_tiny");
        }
        else {
            conversation.find('ul').append(data['message']);
        }

        var messages_list = conversation.find('.messages-list');
        var height = messages_list[0].scrollHeight;
        messages_list.scrollTop(height);



        var user_online = $('.user_online');
        user_online.find('ul').append(data['users']);

    },
    speak: function(message) {
        return this.perform('speak', {
            message: message
        });
    }
});
$(document).on('submit', '.new_message', function(e) {
    e.preventDefault();
    var values = $(this).serializeArray();
    App.chat_conversation.speak(values);
    $(this).trigger('reset');
});