$(document).ready(function() {

    //обрабатываем json ответ ajax
    $("body").on("ajax:success", ".panel-body li", function (xhr, data) {

        var conversations = $('#conversations-list');
        var conversation = conversations.find("[data-conversation-id='" + data.conversation.id + "']");

        if (conversation.length !== 1) {
            conversations.append(
                "<li>"+
                "<div class='panel panel-default' data-conversation-id='"+data.conversation.id+"'>"+
                "<div class='panel-heading'>"+
                "<a class='toggle-window' href=''>"+data.opposed_user.user_name+"</a>"+
                "<a class='btn btn-default btn-xs pull-right' data-remote='true' rel='nofollow' data-method='post' href='/chat/conversations/"+data.conversation.id+"/close'>x</a>"+
                "</div>"+
                "<div class='panel-body' style=''>"+
                "<div class='messages-list'>"+
                "<ul>");

            conversations = $('#conversations-list');
            conversation = conversations.find("[data-conversation-id='" + data.conversation.id + "']");

            var box = conversation.find('.messages-list ul');
            $.each(data.messages, function(key, value){

                //var message_div = '';
                //var user_div = '';

                if(data.user.id == value.user_id ){
                    //message_div = 'div message-sent';
                    //user_div = 'user-sent';

                    box.append(
                        "<li>"+
                        "<div class='row'>"+
                        "<div class='user-sent'>Вы:</div>"+
                        "<div class='message-sent'>"+value.body+"</div>"+
                        "</div>"+
                        "</li>"
                    );
                }
                else{
                    //message_div = 'div message-received';
                    //user_div = 'user-received';

                    box.append(
                        "<li>"+
                        "<div class='row'>"+
                        "<div class='user-received'>"+data.opposed_user.user_name+":</div>"+
                        "<div class='message-received'>"+value.body+"</div>"+
                        "</div>"+
                        "</li>"
                    );
                }
            });

            box = conversation.find('.messages-list');
            box.append(
                "</ul>"+
                "</div>"+
                "<form class='new_message'>"+
                "<input name='conversation_id' type='hidden' value='"+data.conversation.id+"'>"+
                "<input name='user_id' type='hidden' value='"+data.user.id+"'>"+
                "<textarea class='form-control' name='body'></textarea>"+
                "<input class='btn btn-success' type='submit' value='Отправить'>"+
                "</form>"+
                "</div>"+
                "</div>"+
                "</li>"
            );

            conversation = conversations.find("[data-conversation-id='" + data.conversation.id + "']");
        }

        conversation.find('.panel-body').show();

        var messages_list = conversation.find('.messages-list');

        var height = messages_list[0].scrollHeight;
        messages_list.scrollTop(height);

    }).on("ajax:error", function (xhr, data) {
        //как то можно обработать ошибку
    });

});