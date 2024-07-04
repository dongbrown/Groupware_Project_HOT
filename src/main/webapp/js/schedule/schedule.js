jQuery(document).ready(function($) {
    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today addEventButton',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        customButtons: {
            addEventButton: {
                text: '일정 추가',
                click: function() {
                    $('#scheduleModal').css('display', 'block');
                }
            }
        },
        defaultView: 'month',
        timezone: 'local',
        editable: true,
        eventDurationEditable: true,
        events: function(start, end, timezone, callback) {
            $.ajax({
                url: '/schedule/schedule',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    var events = [];
                    $.each(response, function(i, item) {
                        events.push({
                            id: item.id,
                            title: item.title,
                            start: item.start,
                            end: item.end,
                            allDay: item.allDay,
                            color: item.color,
                            description: item.description,
                            location: item.location,
                            type: item.type
                        });
                    });
                    callback(events);
                },
                error: function(xhr, status, error) {
                    console.error("일정을 가져오는 중 오류 발생:", error);
                    alert("일정을 가져오는 데 실패했습니다.");
                }
            });
        },
        eventDrop: function(event, delta, revertFunc) {
            if (!confirm("이 변경 사항을 저장하시겠습니까?")) {
                revertFunc();
            } else {
                $.ajax({
                    url: '/schedule/updateSchedule',
                    data: JSON.stringify({
                        id: event.id,
                        title: event.title,
                        start: event.start.format('YYYY-MM-DD HH:mm:ss'),
                        end: event.end ? event.end.format('YYYY-MM-DD HH:mm:ss') : null,
                        allDay: event.allDay,
                        color: event.color,
                        type: event.type,
                        description: event.description,
                        location: event.location
                    }),
                    contentType: 'application/json',
                    type: 'POST',
                    success: function(response) {
                        alert('일정이 성공적으로 업데이트되었습니다.');
                    },
                    error: function(xhr, status, error) {
                        console.error("일정 업데이트 중 오류 발생:", error);
                        alert('일정 업데이트 중 오류가 발생했습니다.');
                        revertFunc();
                    }
                });
            }
        },
        eventRender: function(event, element) {
            element.css('background-color', event.color);
        },
        dayClick: function(date, jsEvent, view) {
            $('#scheduleModal').css('display', 'block');
            $('#scheduleDate').val(date.format('YYYY-MM-DD'));
        },
        eventClick: function(calEvent, jsEvent, view) {
            $('#viewScheduleModal').css('display', 'block');
            $('#viewScheduleId').val(calEvent.id);
            $('#viewScheduleTitle').val(calEvent.title);
            $('#viewSchedulePlace').val(calEvent.location);
            $('#viewScheduleContent').val(calEvent.description);
            $('#viewScheduleStart').val(moment(calEvent.start).format('YYYY-MM-DD'));
            $('#viewScheduleEnd').val(calEvent.end ? moment(calEvent.end).format('YYYY-MM-DD') : '');
            $('#viewScheduleAllDay').prop('checked', calEvent.allDay);
            $('#viewScheduleColor').val(calEvent.color);
            $('input[name="viewScheduleType"][value="' + calEvent.type + '"]').prop('checked', true);
        }
    });

    $('.close').click(function() {
        $(this).closest('.modal').css('display', 'none');
    });

    $(window).click(function(event) {
        if ($(event.target).hasClass('modal')) {
            $('.modal').css('display', 'none');
        }
    });

    $('#addScheduleForm').on('submit', function(e) {
        e.preventDefault();
        var formData = {
            title: $('#scheduleTitle').val(),
            start: $('#scheduleDate').val(),
            end: $('#scheduleEnd').val() || null,
            allDay: $('#scheduleAllDay').is(':checked'),
            color: $('#scheduleColor').val(),
            type: $('input[name="scheduleType"]:checked').val(),
            description: $('#scheduleContent').val(),
            location: $('#schedulePlace').val()
        };

        $.ajax({
            url: '/schedule/addSchedule',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                alert('일정이 성공적으로 추가되었습니다.');
                $('#scheduleModal').css('display', 'none');
                $('#calendar').fullCalendar('refetchEvents');
            },
            error: function(xhr, status, error) {
                alert('일정 추가 중 오류가 발생했습니다.');
                console.error("Error details:", error);
            }
        });
    });

    $('#updateScheduleForm').on('submit', function(e) {
        e.preventDefault();
        var formData = {
            id: $('#viewScheduleId').val(),
            title: $('#viewScheduleTitle').val(),
            location: $('#viewSchedulePlace').val(),
            description: $('#viewScheduleContent').val(),
            start: $('#viewScheduleStart').val(),
            end: $('#viewScheduleEnd').val() || null,
            allDay: $('#viewScheduleAllDay').is(':checked'),
            color: $('#viewScheduleColor').val(),
            type: $('input[name="viewScheduleType"]:checked').val()
        };

        $.ajax({
            url: '/schedule/updateSchedule',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                alert('일정이 성공적으로 수정되었습니다.');
                $('#viewScheduleModal').css('display', 'none');
                $('#calendar').fullCalendar('refetchEvents');
            },
            error: function(xhr, status, error) {
                alert('일정 수정 중 오류가 발생했습니다.');
                console.error("Error details:", error);
            }
        });
    });

    $(document).on('click', '#deleteScheduleBtn', function(){
        if(!confirm("정말로 이 일정을 삭제하시겠습니까?")) {
            return;
        }
        var scheduleId = $('#viewScheduleId').val();

        $.ajax({
            url: '/schedule/deleteSchedule',
            type: 'POST',
            data: {id: scheduleId},
            success: function(response){
                alert('일정이 삭제되었습니다.');
                $('#viewScheduleModal').css('display', 'none');
                $('#calendar').fullCalendar('refetchEvents');
            },
            error: function(xhr, status, error){
                alert('일정 삭제 중 오류가 발생했습니다.');
                console.error("Error details:", error);
            }
        });
    });
});