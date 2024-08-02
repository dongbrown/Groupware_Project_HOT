$(document).ready(function() {
    // 오늘 날짜 가져오기
    var today = moment().startOf('day');

    // 캘린더 초기화
    var calendar = $('#todayCalendar').fullCalendar({
        defaultDate: today,
        defaultView: 'agendaDay',
        editable: false,
        header: {
            left: 'title',
            center: '',
            right: 'today'
        },
        height: 'auto',
        allDaySlot: true,
        slotDuration: '00:30:00',
        slotLabelInterval: '01:00',
        scrollTime: '08:00:00',
        timeFormat: 'HH:mm',
        eventLimit: true,
        eventColor: '#378006',
        events: function(start, end, timezone, callback) {
            $.ajax({
                url: 'http://14.36.141.71:15555/GDJ_79_HOT_final/schedule/getTodaySchedule',
                type: 'GET',
                data: {
                    employeeNo: currentEmployeeNo // 현재 로그인한 직원의 번호
                },
                success: function(response) {
                    var events = [];
                    response.forEach(function(event) {
                        events.push({
                            id: event.SCHEDULE_NO,
                            title: event.SCHEDULE_TITLE,
                            start: event.SCHEDULE_START_DATE,
                            end: event.SCHEDULE_END_DATE,
                            description: event.SCHEDULE_CONTENT,
                            location: event.SCHEDULE_PLACE,
                            allDay: moment(event.SCHEDULE_START_DATE).isSame(event.SCHEDULE_END_DATE, 'day'),
                            color: getColorByLabel(event.SCHEDULE_LABEL),
                            type: event.SCHEDULE_TYPE
                        });
                    });
                    callback(events);
                },
                error: function(xhr, status, error) {
                    console.error('일정을 불러오는 중 오류가 발생했습니다:', error);
                    callback([]);
                }
            });
        },
        eventRender: function(event, element) {
            if (event.description) {
                element.find('.fc-title').after($('<span class="fc-description">').text(' - ' + event.description));
            }
            if (event.location) {
                element.find('.fc-title').after($('<span class="fc-location">').text(' @ ' + event.location));
            }
            element.attr('data-type', event.type);
        },
        eventClick: function(event) {
            showEventDetails(event);
        }
    });

    // 일정 상세 정보 표시 함수
    function showEventDetails(event) {
        $('#eventTitle').text(event.title);
        $('#eventDescription').text(event.description || '설명 없음');
        $('#eventLocation').text(event.location || '위치 정보 없음');
        $('#eventStart').text(moment(event.start).format('YYYY-MM-DD HH:mm'));
        $('#eventEnd').text(moment(event.end).format('YYYY-MM-DD HH:mm'));
        $('#eventType').text(getEventTypeText(event.type));
        $('#eventDetailsModal').modal('show');
    }

    // 일정 라벨에 따른 색상 반환 함수
    function getColorByLabel(label) {
        // 라벨에 따른 색상 매핑
        var colorMap = {
            '중요': '#FF0000',
            '일반': '#378006',
            '개인': '#3788D8'
            // 필요에 따라 더 많은 라벨과 색상을 추가할 수 있습니다.
        };
        return colorMap[label] || '#378006'; // 기본 색상
    }

    // 일정 타입에 따른 텍스트 반환 함수
    function getEventTypeText(type) {
        var typeMap = {
            'COMPANY': '전사 일정',
            'DEPARTMENT': '부서 일정',
            'PERSONAL': '개인 일정'
            // 필요에 따라 더 많은 타입을 추가할 수 있습니다.
        };
        return typeMap[type] || '기타 일정';
    }

    // 오늘 버튼 클릭 이벤트
    $('.fc-today-button').click(function() {
        calendar.fullCalendar('gotoDate', today);
    });
});