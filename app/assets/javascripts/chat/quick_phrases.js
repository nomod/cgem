$(document).ready(function() {

    //вызываем панель с группами быстрых ответов
    $("body").on("ajax:success", ".quick_phrases a", function (xhr, data) {

        var body = $('#select-quick-group');
        var box = $('.quick_phrases_body');

        var body_visible = body.is(':visible');

        if (!body_visible) {

            body.empty();
            box.css("display", "block");


            $.each(data.groups, function(key, value){
                var body = $('#select-quick-group');
                body.append(
                    "<li>"+
                        "<a data-remote='true' rel='nofollow' data-method='post' href='/quick_phrases?group_id="+value.id+"'>"+value.quick_group_name+"</a>"+
                    "</li>"+
                     "<div class = 'quick_phrases_list'></div>"
                );
            });

        }
        else{
            box.css("display", "none");
        }

    }).on("ajax:error", function (xhr, data) {
        //как то можно обработать ошибку
    });



    //показываем варианты ответов в группах при клике на группе
    $("body").on("ajax:success", "#select-quick-group a", function (xhr, data) {

        var body = $('.quick_phrases_list');
        var body_visible = body.is(':visible');

        if (!body_visible) {

            body.css("display", "block");

            var next = $(this).parent().next(".quick_phrases_list");

            body.empty();

            $.each(data.phrases, function(key, value){

                next.append(
                    "<div class = 'quick_phrase'>"+
                    "<p>"+ value.phrase+"</p>"+
                    "</div>"
                );
            });
        }
        else{
            body.css("display", "none");
        }

    }).on("ajax:error", function (xhr, data) {
        //как то можно обработать ошибку
    });

});