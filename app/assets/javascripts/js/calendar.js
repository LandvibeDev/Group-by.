/* ============================================================
 * Calendar
 * This is a Demo App that was created using Pages Calendar Plugin
 * We have demonstrated a few function that are useful in creating
 * a custom calendar. Please refer docs for more information
 * ============================================================ */

(function ($) {

    'use strict';

    $(document).ready(function () {

        //처음 이벤트 로드
        $.ajax({
            url: '/home/load_event',
            type: 'post',
            success: function (data) {
                for (var idx in data) {
                    var e = {};
                    e.id = data[idx].id;
                    e.title = data[idx].title;
                    e.class = 'bg-success-lighter';
                    e.start = data[idx].start;
                    e.end = data[idx].end;
                    e.other = {};
                    mycal.pagescalendar('addEvent', e);
                    console.log(e);
                }
            }
        });

        function edit_event() {
            $.ajax({
                url: '/home/edit_event',
                type: 'post',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(selectedEvent),
                dataType: "json",
                success: function () {
                    console.log("success edit");
                }
            });
        }


        var selectedEvent;
        var mycal = $('#myCalendar');
        mycal.pagescalendar({
            //Loading Dummy EVENTS for demo Purposes, you can feed the events attribute from
            //Web Service
            events: [],
            view: "month",
            onViewRenderComplete: function () {
                //You can Do a Simple AJAX here and update
            },
            onEventClick: function (event) {
                //Open Pages Custom Quick View
                if (!$('#calendar-event').hasClass('open'))
                    $('#calendar-event').addClass('open');


                selectedEvent = event;
                setEventDetailsToForm(selectedEvent);
            },
            onEventDragComplete: function (event) {
                selectedEvent = event;
                edit_event();
                setEventDetailsToForm(selectedEvent);
            },
            onEventResizeComplete: function (event) {
                selectedEvent = event;
                edit_event();
                setEventDetailsToForm(selectedEvent);
            },
            onTimeSlotDblClick: function (timeSlot) {
                $('#calendar-event').removeClass('open');
                //Adding a new Event on Slot Double Click
                var newEvent = {
                    title: 'my new event',
                    class: 'bg-success-lighter',
                    start: timeSlot.date,
                    end: moment(timeSlot.date).add(1, 'hour').format(),
                    allDay: false,
                    other: {
                        //You can have your custom list of attributes here
                        note: 'test'
                    }
                };
                selectedEvent = newEvent;
                mycal.pagescalendar('addEvent', newEvent);

                //초기 이벤트 생성시 저장
                $.ajax({
                    url: '/home/create_event',
                    type: 'post',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(newEvent),
                    dataType: "json",
                    success: function () {
                        console.log("success create");
                    }
                });

                setEventDetailsToForm(selectedEvent);

                // 아래코드 사용하면 수정시 title이 없다고 나옴
                // if (!$('#calendar-event').hasClass('open'))
                //     $('#calendar-event').addClass('open');

            }
        });

        // Some Other Public Methods That can be Use are below \
        //console.log($('body').pagescalendar('getEvents'))
        //get the value of a property
        //console.log($('body').pagescalendar('getDate','MMMM'));

        function setEventDetailsToForm(event) {
            $('#eventIndex').val();
            $('#txtEventName').val();
            $('#txtEventCode').val();
            $('#txtEventLocation').val();
            //Show Event date
            $('#event-date').html(moment(event.start).format('MMM, D dddd'));

            $('#lblfromTime').html(moment(event.start).format('h:mm A'));
            $('#lbltoTime').html(moment(event.end).format('H:mm A'));

            //Load Event Data To Text Field
            $('#eventIndex').val(event.index);
            $('#txtEventName').val(event.title);
            $('#txtEventCode').val(event.other.code);
            $('#txtEventLocation').val(event.other.location);
        }

        $('#eventSave').on('click', function () {
            console.log(selectedEvent);
            selectedEvent.title = $('#txtEventName').val();

            //You can add Any thing inside "other" object and it will get save inside the plugin.
            //Refer it back using the same name other.your_custom_attribute

            selectedEvent.other.code = $('#txtEventCode').val();
            selectedEvent.other.location = $('#txtEventLocation').val();

            mycal.pagescalendar('updateEvent', selectedEvent);

            //초기 이벤트 수정 -> id를 이용하여 수정할 event를 찾는것이 잘 안됨
            edit_event();

            $('#calendar-event').removeClass('open');
        });

        $('#eventDelete').on('click', function () {
            mycal.pagescalendar('removeEvent', $('#eventIndex').val());

            //삭제
            $.ajax({
                url: '/home/delete_event',
                type: 'post',
                success: function () {
                    console.log("delete success");
                }
            });
            $('#calendar-event').removeClass('open');
        });

        //calendar view 전환
        $('#change_week').on('click', function () {
            if (mycal.pagescalendar('getView') != "week") {
                mycal.pagescalendar('view', "week");
            }
        });

        $('#change_month').on('click', function () {
            if (mycal.pagescalendar('getView') != "month") {
                mycal.pagescalendar('view', "month");
            }
        });

    });


})(window.jQuery);