
$('.event-user-add').on('click', function () {
    var event_id = $( this ).attr('value');
    var user_name = $('.add-user-event-username').attr('value');
    var user_profile = $('.add-user-event-userprofile').attr('value');

    var class_name = '.add-event-user-pic' + event_id;
    var card_share = '#card-share' + event_id;
    var plus_name = '#event-user-add' + event_id;
    var circle_name = 'circle' + event_id;

    $.ajax({
        url: '/projects/' + event_id + '/user_event_add',
        type: 'post',
        success : function () {
            $('.tooltip').remove();
            $(class_name).append('<div style="float: left;padding-left: 5px;" data-toggle="tooltip" data-container="body"' +
                'data-original-title="' + user_name + '">' + '<span class="thumbnail-wrapper d32 circular inline m-t-5"><img src="' +
                user_profile + '"></span></div>');
            $(plus_name).remove();
            $(card_share).append(
                '<div class="circle event-user-notcomplete" id="event-user-notcomplete<%= events.id %>" style="border: 1px solid #ffffff; background: rgba(255, 255, 255, 0);">' +
                '<i class="fa fa-circle-thin" id="' + circle_name + '"></i>' +
                '</div>');
            var complete_users = $('#complete-user-size').val();
            var users = $('#user-size').val();
            if( users == complete_users) {
                $(timeline_point).remove();
                $(time_line_block).append('<div class="timeline-point" id="timeline-point' + event_id + '" style="background-color: red;"></div>');
            }
        }
    });
});

$('.event-user-notcomplete').on('click', function () {
    var event_id = $( this ).attr('value');

    var complete_name = '#event-user-notcomplete' + event_id;
    var card_share = '#card-share' + event_id;
    var check_name = 'check' + event_id;

    var time_line_block = '#timeline-block' + event_id;
    var timeline_point = '#timeline-point' + event_id;
    $.ajax({
        url: '/projects/' + event_id + '/user_event_complete',
        type: 'put',
        success : function () {
            $( complete_name ).fadeOut( 1500, function() {
                $( complete_name ).remove();
                $(card_share).append(
                    '<div class="circle event-user-notcomplete" id="event-user-notcomplete' + event_id + '" style="border: 1px solid #ffffff; background: rgba(255, 255, 255, 0);">' +
                    '<i class="fa fa-check" id="' + check_name + '"></i>' +
                    '</div>');
                var complete_users = $('#complete-user-size').val();
                var users = $('#user-size').val();
                if( users == complete_users) {
                    $(timeline_point).remove();
                    $(time_line_block).append('<div class="timeline-point" id="timeline-point' + event_id + '" style="background-color: lawngreen;"></div>');
                }
            });
            $('.tooltip').remove();
        }
    });
});

$('#project-delete').keypress(function () {
    var project_title = $('#project-name').attr('value');
    var delete_title = $('#project-delete').val();

    if(project_title === delete_title) {
        $('#project-delete-btn1').attr('hidden', 'hidden')
        $('#project-delete-btn2').removeAttr('hidden');
    }
});