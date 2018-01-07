$(document).ready(function() {

    //обрабатываем json ответ ajax
    $("body").on("ajax:success", ".pull-right", function (xhr, data) {
        //находим элемент и закрываем
        $('#conversations-list').find("[data-conversation-id='" + data.conversation.id + "']").parent().remove();
    }).on("ajax:error", function (xhr, data) {
        //как то можно обработать ошибку
    });

});