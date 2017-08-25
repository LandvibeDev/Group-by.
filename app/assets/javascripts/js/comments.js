
(function ($) {

    $(document).ready(function() {

        $(".comments-input").on('keydown', function (key) {

            //키가 13이면 실행 (엔터는 13)
            if(key.keyCode == 13)
            {

                var id = (key.target.id).split("//");
                var value = $(this).val();
                var modal_footer = '#modal-footer-' + id[0];

                if ( $(this).val().trim() ) {
                    $.ajax({
                        url: '/groups/comments_create/' + id[0] + '/' + id[1],
                        type: "POST",
                        data: $(this).serialize(),
                        success: function (data) {

                            $('input[type="text"],textarea').val('');

                            $(modal_footer).append(
                                "<div id='comment-div' class='p-b-10 p-t-10' style='float: left;width: 100%;text-align: left;'>" +
                                "<div class='user-pic p-r-15' style='float: left'>" +
                                "<img src='"+id[4]+"' style ='width: 50px;border-radius: 100%;' )>" +
                                "</div>" +
                                "<span class='semi-bold'>" + id[2] + "</span>" +
                                "<h4 style='line-height: 10px;'>" + value + "</h4>" +
                                "</div>" +
                                "</div>" +
                                "</div>"
                            );

                            return false;
                        },
                        error: function (e) {
                            alert(e);
                        }
                    });
                }
                else
                    alert("빈 코멘트입니다");

            }
        });

        $(".comments-enter").on('click', function (key) {

            var id = $(this).siblings('input').attr('id').split("//");
            var value = $(this).siblings('input').val();
            var modal_footer = '#modal-footer-' + id[0];

            if ( value.trim() ) {
                $.ajax({
                    url: '/groups/comments_create/' + id[0] + '/' + id[1],
                    type: "POST",
                    data: $(this).siblings('input').serialize(),
                    success: function (data) {

                        $('input[type="text"],textarea').val('');

                        $(modal_footer).append(
                            "<div id='comment-div' class='p-b-10 p-t-10' style='float: left;width: 100%;text-align: left;'>" +
                            "<div class='user-pic p-r-15' style='float: left'>" +
                            "<img src='"+id[4]+"' style ='width: 50px;border-radius: 100%;' )>" +
                            "</div>" +
                            "<span class='semi-bold'>" + id[2] + "</span>" +
                            "<h4 style='line-height: 10px;'>" + value + "</h4>" +
                            "</div>" +
                            "</div>" +
                            "</div>"
                        );

                        return false;
                    },
                    error: function (e) {
                        alert(e);
                    }
                });
            }
            else
                alert("빈 코멘트입니다");


        });




        document.getElementById("status-q1").readOnly = true;

    $('#startDatepicker').datepicker({
        minDate: 0
    });
    $('#startDatepicker').datepicker("option", "maxDate", $("#endDatepicker").val());
    $('#startDatepicker').datepicker("option", "onClose", function ( selectedDate ) {
        $("#endDatepicker").datepicker( "option", "minDate", selectedDate );
    });

    $('#endDatepicker').datepicker();
    $('#endDatepicker').datepicker("option", "minDate", $("#startDatepicker").val());
    $('#endDatepicker').datepicker("option", "onClose", function ( selectedDate ) {
        $("#startDatepicker").datepicker( "option", "maxDate", selectedDate );
    });
});
})(window.jQuery);