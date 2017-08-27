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

        function edit_teamEvent(event) {
            $.ajax({
                url: '/projects/' + project_id + '/edit_teamEvent/' + selectedTeamEvent.other.id,
                type: 'post',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(event),
                dataType: "json",
                success: function () {
                }
            });
        }


        var teamcal = $('#teamCalendar_month');
        teamcal.pagescalendar({
            //Loading Dummy EVENTS for demo Purposes, you can feed the events attribute from
            //Web Service
            events: [],
            view: "month",
            onViewRenderComplete: function () {
                //You can Do a Simple AJAX here and update
            },
            onEventClick: function (event) {
                //Open Pages Custom Quick View
                if (!$('#teamcalendar-event').hasClass('open'))
                    $('#teamcalendar-event').addClass('open');


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
                        $('#teameventname').val(e.title);
                        $('#teameventdesc').val(e.content);
                    }
                });

                setTeamEventDetailsToForm(selectedTeamEvent);
            },
            onEventDragComplete: function (event) {
                selectedTeamEvent = event;
                edit_teamEvent(selectedTeamEvent);
                setTeamEventDetailsToForm(selectedTeamEvent);
            },
            onTimeSlotDblClick: function (timeSlot) {
                $('#teamcalendar-event').removeClass('open');
                //Adding a new Event on Slot Double Click
                var newteamEvent = {
                    title: 'my new event',
                    class: 'bg-success-lighter',
                    start: timeSlot.date,
                    end: moment(timeSlot.date).add(1, 'hour').format(),
                    allDay: false,
                    other: {
                        desc: '',
                        //You can have your custom list of attributes here
                    }
                };
                selectedTeamEvent = newteamEvent;

                //초기 이벤트 생성시 저장
                $.ajax({
                    url: '/projects/' + project_id + '/create_teamEvent',
                    type: 'post',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(selectedTeamEvent),
                    dataType: "json",
                    success: function (data) {
                        $.ajax({
                            url: '/projects/' + project_id + '/new_load_teamEvent',
                            type: 'post',
                            success: function (data) {
                                var e = {};
                                e.other = { id: data.id, desc: data.content};
                                e.title = data.title;
                                e.class = 'bg-success-lighter';
                                e.start = data.start_date;
                                e.end = data.end_date;
                                teamcal.pagescalendar('addEvent', e);
                            }
                        });
                    }
                });


                setTeamEventDetailsToForm(selectedTeamEvent);
            }
        });

        // Some Other Public Methods That can be Use are below \
        //console.log($('body').pagescalendar('getEvents'))
        //get the value of a property
        //console.log($('body').pagescalendar('getDate','MMMM'));

        function setTeamEventDetailsToForm(event) {
            $('#teameventIndex').val();
            $('#teamEventName').val();
            $('#teamEventDesc').val();
            //Show Event date
            $('#teamEvent-date').html(moment(event.start).format('MMM, D dddd'));

            $('#teamlblfromTime').html(moment(event.start).format('h:mm A'));
            $('#teamlbltoTime').html(moment(event.end).format('h:mm A'));

            //Load Event Data To Text Field
            $('#teameventIndex').val(event.index);
            $('#teamEventName').val(event.title);
            $('#teamEventDesc').val(event.other.desc);

            $('#teamEventStartDate').val(moment(event.start).format('YYYY-MM-DDThh:mm'));
            $('#teamEventEndDate').val(moment(event.end).format('YYYY-MM-DDThh:mm'));
        }

        $('#eventExit').click(function () {
            $('#teamcalendar-event').removeClass('open');
        });

        $('#teameventSave').on('click', function () {
            selectedTeamEvent.title = $('#teamEventName').val();

            //You can add Any thing inside "other" object and it will get save inside the plugin.
            //Refer it back using the same name other.your_custom_attribute

            selectedTeamEvent.other.desc = $('#teamEventDesc').val();

            selectedTeamEvent.start = $('#teamEventStartDate').val();
            selectedTeamEvent.end = $('#teamEventEndDate').val();

            teamcal.pagescalendar('updateEvent', selectedTeamEvent);

            edit_teamEvent(selectedTeamEvent);

            $('#teamcalendar-event').removeClass('open');
        });

        $('#teameventDelete').on('click', function () {
            teamcal.pagescalendar('removeEvent', $('#teameventIndex').val());

            //삭제
            $.ajax({
                url: '/projects/'+ project_id +'/delete_teamEvent/' + selectedTeamEvent.other.id,
                type: 'delete',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(selectedTeamEvent),
                dataType: "json",
                success: function () {
                }
            });
            $('#teamcalendar-event').removeClass('open');
        });

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
                    teamcal.pagescalendar('addEvent', e);
                }
            }
        });

    });
})(window.jQuery);