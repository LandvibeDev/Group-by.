/* ============================================================
 * Calendar
 * This is a Demo App that was created using Pages Calendar Plugin
 * We have demonstrated a few function that are useful in creating
 * a custom calendar. Please refer docs for more information
 * ============================================================ */

(function ($) {
    $(document).ready(function () {
        var project_id = $('#project_id').val();

        var selectedTeamEvent;

        var show_team_cal = $('#show_team_calendar_month');
        show_team_cal.pagescalendar({
            //Loading Dummy EVENTS for demo Purposes, you can feed the events attribute from
            //Web Service
            view: "month",
            onEventClick: function (event) {
                //Open Pages Custom Quick View
                if (!$('#show_team_calendar-event').hasClass('open'))
                    $('#show_team_calendar-event').addClass('open');

                selectedTeamEvent = event;

                $.ajax({
                    url: '/projects/' + project_id + '/current_load_teamEvent/' + selectedTeamEvent.other.id,
                    type: 'post',
                    success: function (data) {
                        var e = {};
                        e.other = { id: data.id, desc: data.content};
                        e.title = data.title;
                        e.content = data.content;
                        e.class = 'bg-success-lighter';
                        e.start = data.start_date;
                        e.end = data.end_date;
                        e.image = data.image;
                        $('#eventTitle').text(e.title);
                        $('#eventContent').text(e.content);
                        $('#eventStart').text(moment(e.start).format('YYYY-MM-DD hh:mm'));
                        $('#eventEndTime').text(moment(e.end).format('YYYY-MM-DD hh:mm'));
                        $('#eventImage').empty().append(' <label>Imgae</label> ');
                    }
                });
            },
        });

        if ($('#show_team_calendar-event').hasClass('open')) {
            $('#show_team_calendar_month').click(function () {
                $('#show_team_calendar-event').removeClass('open');
            });
        }
        //처음 이벤트 로드 데이터 불러오기 -> pagescalender에 저장
        $.ajax({
            url: '/projects/' + project_id + '/load_teamEvent',
            type: 'post',
            success: function (data) {
                for (var idx in data) {
                    var e = {};
                    e.other = {id: data[idx].id, desc: data[idx].content};
                    e.title = data[idx].title;
                    e.class = 'bg-success-lighter';
                    e.start = data[idx].start_date;
                    e.end = data[idx].end_date;
                    show_team_cal.pagescalendar('addEvent', e);
                }
            }
        });

        $('#eventExit').click(function () {
            $('#show_team_calendar-event').removeClass('open');
        });

    });
})(window.jQuery);

