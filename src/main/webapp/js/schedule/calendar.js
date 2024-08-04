document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth'
        },
        initialView: 'dayGridMonth',
        titleFormat: { month: 'long' },
        selectable: true,
        editable: false,
        timeZone: 'Asia/Seoul',
        locale: 'ko',
        dayCellContent: function(info) {
            return info.date.getDate();
        },
        events: function(fetchInfo, successCallback, failureCallback) {
            fetchAllSchedules(successCallback, failureCallback);
        },
        eventContent: function(arg) {
            return {
                html: '<div class="fc-event-title">' + arg.event.title + '</div>'
            };
        },
        eventTimeFormat: {
            hour: undefined,
            minute: undefined,
            meridiem: undefined
        }
    });

    calendar.render();

    function fetchAllSchedules(successCallback, failureCallback) {
        $.ajax({
            url: path + '/schedule/all',
            type: 'GET',
            dataType: 'json',
            success: function(events) {
                var formattedEvents = events.map(function(event) {
                    return {
                        id: event.id,
                        title: event.title,
                        start: event.start,
                        end: event.end,
                        allDay: true,
                        color: event.color
                    };
                });
                successCallback(formattedEvents);
                updateTodaySchedules(events);
            },
            error: function(xhr, status, error) {
                console.error('일정을 가져오는 중 오류가 발생했습니다:', error);
                failureCallback(error);
            }
        });
    }

    function isToday(dateString) {
        var today = new Date();
        var eventDate = new Date(dateString);
        return today.getDate() === eventDate.getDate() &&
               today.getMonth() === eventDate.getMonth() &&
               today.getFullYear() === eventDate.getFullYear();
    }

     function updateTodaySchedules(allSchedules) {
        var todolistEl = document.getElementById('todolist');
        todolistEl.innerHTML = ''; // 기존 내용을 지웁니다.

        var todaySchedules = allSchedules.filter(function(schedule) {
            return isToday(schedule.start);
        });

        if (todaySchedules.length === 0) {
            todolistEl.innerHTML = '<p>오늘의 일정이 없습니다.</p>';
        } else {
            todaySchedules.forEach(function(schedule, index) {
                var isChecked = localStorage.getItem('schedule_' + schedule.id) === 'true';
                var scheduleHtml = `
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="${schedule.id}"
                               id="flexCheck${index}" ${isChecked ? 'checked' : ''}>
                        <label class="form-check-label" for="flexCheck${index}">
                            ${schedule.title}
                        </label>
                    </div>
                `;
                todolistEl.innerHTML += scheduleHtml;
            });

            // 체크박스 이벤트 리스너 추가
            todolistEl.querySelectorAll('.form-check-input').forEach(function(checkbox) {
                checkbox.addEventListener('change', function(e) {
                    localStorage.setItem('schedule_' + e.target.value, e.target.checked);
                });
            });
        }
    }

    // 초기 로드 시 일정을 가져옵니다.
    fetchAllSchedules(function(){}, function(){});

    // 매일 자정에 체크박스 상태 초기화
    function scheduleReset() {
        var now = new Date();
        var night = new Date(
            now.getFullYear(),
            now.getMonth(),
            now.getDate() + 1, // 다음날
            0, 0, 0 // 자정
        );
        var msToMidnight = night.getTime() - now.getTime();

        setTimeout(function() {
            // 로컬 스토리지에서 'schedule_' 로 시작하는 모든 항목 삭제
            for (var i = 0; i < localStorage.length; i++) {
                var key = localStorage.key(i);
                if (key.startsWith('schedule_')) {
                    localStorage.removeItem(key);
                }
            }
            // 체크박스 상태 초기화 후 일정 다시 불러오기
            fetchAllSchedules(function(){}, function(){});
            // 다음 날을 위해 다시 타이머 설정
            scheduleReset();
        }, msToMidnight);
    }

    // 초기 타이머 설정
    scheduleReset();
});