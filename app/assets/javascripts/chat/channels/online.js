App.chat_online = App.cable.subscriptions.create("Chat::OnlineChannel", {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {

        var user_online = $('.user_online');
        user_online.find('ul').empty();
        user_online.find('ul').append(data['users']);

    }
});