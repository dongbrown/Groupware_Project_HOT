$(document).ready(function() {
    // 체크박스 이벤트 바인딩
    rebindCheckboxEvents();

    // 메인 캘린더 초기화
    var calendar = $('#calendar').fullCalendar({
        googleCalendarApiKey: "AIzaSyDSnYZPXQu0qUmI0h4YBe7djb7tP9IMDqE",
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,listMonth'
        },
        titleFormat: 'MMMM YYYY',
        initialDate: 'default',
        selectable: true,
        selectHelper: true,
        editable: true,
        eventLimit: true,
        eventLimitClick: 'popover',
        eventLimitText: '더보기',
        timeZone: 'Asia/Seoul',
        locale: 'ko',
        eventSources: [
            {
                events: function(start, end, timezone, callback) {
                    $.ajax({
                        url: path + '/schedule/all',
                        type: 'GET',
                        dataType: 'json',
                        success: function(events) {
                            var filteredEvents = events.filter(function(event) {
                                return $('.schedule-checkbox[data-id="' + event.id + '"]').is(':checked');
                            });
                            companySchedules.forEach(function(schedule) {
                                if ($('.schedule-checkbox[data-id="' + schedule.id + '"][data-type="company"]').is(':checked')) {
                                    filteredEvents.push({
                                        id: schedule.id,
                                        title: schedule.title,
                                        start: schedule.start,
                                        end: schedule.end,
                                        allDay: schedule.allDay,
                                        color: schedule.color,
                                        type: 'company'
                                    });
                                }
                            });
                            callback(filteredEvents);
                        }
                    });
                }
            },
            {
                googleCalendarId: 'ko.south_korea@holiday.calendar.google.com',
                className: 'gcal-event',
                color: '#FF0000',
                textColor: '#FFFFFF',
                editable: false,
                timezone: 'local'
            },
        ],
        views: {
            month: {
                eventLimit: 4
            }
        },
        eventRender: function(event, element) {
            if (event.source.googleCalendarId) {
                console.log('Rendering Google Calendar event:', event);
                element.attr('title', event.title);
                return true;
            } else {
                element.find('.fc-time').remove();
                var title = event.title;
                if (title.length <= 5) {
                    element.addClass('short');
                } else if (title.length <= 15) {
                    element.addClass('medium');
                } else {
                    element.addClass('long');
                }
                element.attr('title', event.title);
            }
        },
        select: function(start, end) {
            openAddScheduleModal(start, end);
        },
        eventClick: function(event) {
            openViewScheduleModal(event);
        },
        eventDrop: function(event) {
            updateSchedule(event, true);
        },
        eventResize: function(event) {
            updateSchedule(event, true);
        },
        loading: function(isLoading, view) {
            if (!isLoading) {
                console.log('All events (including Google Calendar) loaded');
            }
        },
        eventAfterAllRender: function(view) {
            console.log('All events rendered');
            var allEvents = $('#calendar').fullCalendar('clientEvents');
            console.log('Total events:', allEvents.length);
            var googleEvents = allEvents.filter(function(event) {
                return event.source.googleCalendarId;
            });
            console.log('Google Calendar events:', googleEvents.length);
            console.log('Google Calendar events details:', googleEvents);
        },
        eventSourceSuccess: function(content, xhr) {
            console.log('Events loaded successfully');
            console.log(content);
        },
        eventSourceFailure: function(errorObj) {
            console.error('Error loading events', errorObj);
        }
    });

    $('#calendar').fullCalendar('addEventSource', {
        googleCalendarId: 'ko.south_korea@holiday.calendar.google.com',
        className: 'gcal-event',
        color: '#FF0000',
        textColor: '#FFFFFF',
        editable: false
    });

    $('#scheduleDate, #viewScheduleStart').on('change', function() {
        const startDate = $(this).val();
        const endDateInput = $(this).attr('id') === 'scheduleDate' ? '#scheduleEnd' : '#viewScheduleEnd';
        $(endDateInput).attr('min', startDate);
        if ($(endDateInput).val() < startDate) {
            $(endDateInput).val(startDate);
        }
    });

    $('#scheduleEnd, #viewScheduleEnd').on('change', function() {
        const endDate = $(this).val();
        const startDateInput = $(this).attr('id') === 'scheduleEnd' ? '#scheduleDate' : '#viewScheduleStart';
        const startDate = $(startDateInput).val();
        if (endDate < startDate) {
            alert('종료 날짜는 시작 날짜 이후여야 합니다.');
            $(this).val(startDate);
        }
    });

    $('#calendar').fullCalendar('option', {
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    });

    // 섹션 체크박스 이벤트 바인딩
    $('.section-checkbox').on('change', function() {
        var isChecked = $(this).prop('checked');
        var section = $(this).data('section');
        $(`.schedule-checkbox[data-type="${section}"]`).prop('checked', isChecked).trigger('change');
    });

    // 체크박스 변경 -> 캘린더 이벤트 다시 불러오기
    $(document).on('change', '.schedule-checkbox', function() {
        var scheduleId = $(this).data('id');
        var isChecked = $(this).prop('checked');
        var scheduleType = $(this).data('type');
        localStorage.setItem('schedule_' + scheduleId, isChecked);
        updateSectionCheckbox(scheduleType);
        $('#calendar').fullCalendar('refetchEvents');
    });

    // 캘린더 < 토글 기능
    $('.toggle-header').click(function() {
        $(this).toggleClass('active');
        $(this).next('.legend-items').toggleClass('show');
    });

    // 색상 선택 기능
    $('.color-option').click(function() {
        $(this).siblings().removeClass('selected');
        $(this).addClass('selected');
        var color = $(this).data('color');
        $(this).closest('.form-group').find('input[type="hidden"]').val(color);
    });

  // 일정 추가 모달 열기
    function openAddScheduleModal(start, end) {
        $('#scheduleModal').modal('show');
        $('#scheduleDate').val(start.format('YYYY-MM-DD'));
        $('#scheduleEnd').val(end.format('YYYY-MM-DD'));
        $('#scheduleEnd').attr('min', start.format('YYYY-MM-DD'));
        $('.color-option[data-color="#0000FF"]').click();
        loadDepartments();
        $('#participantSelection').hide();
    }

    // 일정 조회/수정 모달 열기
    function openViewScheduleModal(event) {
        $('#viewScheduleModal').modal('show');
        $('#viewScheduleId').val(event.id);
        $('#viewScheduleTitle').val(event.title);
        $('#viewSchedulePlace').val(event.location);
        $('#viewScheduleContent').val(event.description);
        $('#viewScheduleStart').val(moment(event.start).format('YYYY-MM-DD'));
        $('#viewScheduleEnd').val(event.end ? moment(event.end).format('YYYY-MM-DD') : '');
        $('#viewScheduleEnd').attr('min', moment(event.start).format('YYYY-MM-DD'));
        $('#viewScheduleAllDay').prop('checked', event.allDay);

        var color = event.color || '#0000FF';
        $('#viewScheduleColor').val(color);
        $(`.color-option[data-color="${color}"]`).click();

        if (event.type === 'my') {
            $('#viewScheduleTypeMy').prop('checked', true);
        } else if (event.type === 'share') {
            $('#viewScheduleTypeShare').prop('checked', true);
        } else if (event.type === 'company') {
            $('#viewScheduleTypeCompany').prop('checked', true);
        }

        loadDepartments('view');
        if (event.participants) {
            loadParticipants(event.participants, 'view');
        }

        if (event.type === 'share') {
            $('#viewParticipantSelection').show();
        } else {
            $('#viewParticipantSelection').hide();
        }

        if (event.type === 'company') {
            if (isCeo) {
                $('#deleteScheduleBtn').show();
            } else {
                $('#deleteScheduleBtn').hide();
            }
        } else {
            $('#deleteScheduleBtn').show();
        }

        if (event.type === 'company' && !isCeo) {
            $('#viewScheduleTitle, #viewSchedulePlace, #viewScheduleContent, #viewScheduleStart, #viewScheduleEnd, #viewScheduleAllDay').prop('disabled', true);
            $('.color-option').css('pointer-events', 'none');
            $('button[type="submit"]').hide();
        } else {
            $('#viewScheduleTitle, #viewSchedulePlace, #viewScheduleContent, #viewScheduleStart, #viewScheduleEnd, #viewScheduleAllDay').prop('disabled', false);
            $('.color-option').css('pointer-events', 'auto');
            $('button[type="submit"]').show();
        }
    }

    // 일정 추가 폼 제출
    $('#addScheduleForm').submit(function(e) {
        e.preventDefault();
        var newSchedule = {
            title: $('#scheduleTitle').val(),
            location: $('#schedulePlace').val(),
            description: $('#scheduleContent').val(),
            start: $('#scheduleDate').val(),
            end: $('#scheduleEnd').val(),
            allDay: $('#scheduleAllDay').is(':checked'),
            color: $('#scheduleColor').val(),
            type: $('input[name=scheduleType]:checked').val(),
            participants: getSelectedParticipants()
        };

        $.ajax({
            url: path + '/schedule/addSchedule',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(newSchedule),
            success: function(response) {
                refreshCalendarAndSidebar();
                $('#scheduleModal').modal('hide');
                $('#addScheduleForm')[0].reset();
                alert('일정이 성공적으로 추가되었습니다.');
            },
            error: function(xhr, status, error) {
                alert('일정 추가 중 오류가 발생했습니다: ' + error);
            }
        });
    });

    // 체크박스 이벤트 다시 바인딩 함수
    function rebindCheckboxEvents() {
        $('.schedule-checkbox').off('change').on('change', function() {
            var scheduleId = $(this).data('id');
            var isChecked = $(this).prop('checked');
            var scheduleType = $(this).data('type');
            localStorage.setItem('schedule_' + scheduleId, isChecked);
            updateSectionCheckbox(scheduleType);

            if (isChecked) {
                var event = getEventById(scheduleId);
                if (event) {
                    $('#calendar').fullCalendar('renderEvent', event, true);
                }
            } else {
                $('#calendar').fullCalendar('removeEvents', scheduleId);
            }
        });
    }

    // 섹션 체크박스 상태 업데이트 함수
    function updateSectionCheckbox(scheduleType) {
        var allChecked = $(`.schedule-checkbox[data-type="${scheduleType}"]`).length ===
                         $(`.schedule-checkbox[data-type="${scheduleType}"]:checked`).length;
        $(`.section-checkbox[data-section="${scheduleType}"]`).prop('checked', allChecked);
    }

    function getSelectedParticipants(prefix = '') {
        return $(`#${prefix}selectedEmployeeList li`).map(function() {
            return $(this).data('emp-no');
        }).get();
    }

    // 일정 수정 폼 제출
    $('#updateScheduleForm').submit(function(e) {
        e.preventDefault();
        var updatedSchedule = {
            id: $('#viewScheduleId').val(),
            title: $('#viewScheduleTitle').val(),
            location: $('#viewSchedulePlace').val(),
            description: $('#viewScheduleContent').val(),
            start: $('#viewScheduleStart').val(),
            end: $('#viewScheduleEnd').val(),
            allDay: $('#viewScheduleAllDay').is(':checked'),
            color: $('#viewScheduleColor').val(),
            type: $('input[name=viewScheduleType]:checked').val(),
            participants: getSelectedParticipants('view'),
            updatedByDrag: false
        };

        updateSchedule(updatedSchedule, false);
    });

    // 일정 삭제 버튼 클릭 이벤트
    $('#deleteScheduleBtn').click(function() {
        var scheduleId = $('#viewScheduleId').val();

        if (!scheduleId || scheduleId === '0') {
            console.error('Invalid schedule ID for deletion');
            alert('유효하지 않은 일정 ID입니다. 페이지를 새로고침한 후 다시 시도해주세요.');
            return;
        }

        if (confirm('정말로 이 일정을 삭제하시겠습니까?')) {
            $.ajax({
                url: path + '/schedule/deleteSchedule',
                type: 'DELETE',
                data: { id: scheduleId },
                success: function(response) {
                    refreshCalendarAndSidebar();
                    $('#viewScheduleModal').modal('hide');
                    alert('일정이 성공적으로 삭제되었습니다.');
                },
                error: function(xhr, status, error) {
                    console.error('에러 :', xhr.responseText);
                    alert('일정 삭제 중 오류가 발생했습니다: ' + error);
                }
            });
        }
    });

    // 일정 타입 변경 시 참석자 선택 영역 표시/숨김
    $('input[name="scheduleType"], input[name="viewScheduleType"]').on('change', function() {
        var prefix = $(this).attr('name') === 'scheduleType' ? '' : 'view';
        if ($(this).val() === 'share') {
            $(`#${prefix}participantSelection`).show();
        } else {
            $(`#${prefix}participantSelection`).hide();
        }
    });

    // 부서 목록 로드
    function loadDepartments(prefix = '') {
        $.ajax({
            url: path + '/api/employee/departmentList',
            type: 'GET',
            dataType: 'json',
            success: function(departments) {
                const departmentList = $(`#${prefix}departmentList`);
                departmentList.empty();
                $.each(departments, function(index, dept) {
                    departmentList.append(`<li data-dept-code="${dept.departmentCode}">${dept.departmentTitle}</li>`);
                });
            },
            error: function(xhr, status, error) {
                console.error("Error fetching departments:", error);
            }
        });
    }

    // 부서 선택 시 사원 목록 로드
    $(document).on('click', '#departmentList li, #viewDepartmentList li', function() {
        const deptCode = $(this).data('dept-code');
        const prefix = $(this).closest('#viewDepartmentList').length ? 'view' : '';
        loadEmployees(deptCode, prefix);
    });

    // 사원 목록 로드
    function loadEmployees(deptCode, prefix = '') {
        $.ajax({
            url: path + '/schedule/selectEmpByDept',
            type: 'GET',
            data: { deptCode: deptCode },
            dataType: 'json',
            success: function(employees) {
                const employeeList = $(`#${prefix}employeeList`);
                employeeList.empty();
                if (Array.isArray(employees)) {
                    $.each(employees, function(index, emp) {
                        employeeList.append(`<li data-emp-no="${emp.employeeNo}">${emp.employeeName} </li>`);
                    });
                } else {
                    console.error('Employees data is not an array:', employees);
                }
            },
            error: function(xhr, status, error) {
                console.error("Error fetching employees:", error);
            }
        });
    }

    // 사원 선택 시 참석자 목록에 추가
    $(document).on('click', '#employeeList li, #viewEmployeeList li', function() {
        const empNo = $(this).data('emp-no');
        const empName = $(this).text();
        const prefix = $(this).closest('#viewEmployeeList').length ? 'view' : '';
        if (!$(`#${prefix}selectedEmployeeList li[data-emp-no="${empNo}"]`).length) {
            $(`#${prefix}selectedEmployeeList`).append(`<li data-emp-no="${empNo}">${empName} <span class="remove-employee">&times;</span></li>`);
        }
    });

    // 참석자 제거
    $(document).on('click', '.remove-employee', function() {
        $(this).parent().remove();
    });

    // 참석자 목록 로드 (일정 수정 시)
    function loadParticipants(participants, prefix = '') {
        $(`#${prefix}selectedEmployeeList`).empty();
        $.each(participants, function(index, participant) {
            $(`#${prefix}selectedEmployeeList`).append(`<li data-emp-no="${participant.employeeNo}">${participant.employeeName} <span class="remove-employee">&times;</span></li>`);
        });
    }

    // 일정 수정 (드래그 + 모달)
    function updateSchedule(event, isDragUpdate) {
        var updatedSchedule = {
            id: event.id,
            title: event.title,
            start: event.start.format ? event.start.format() : event.start,
            end: event.end ? (event.end.format ? event.end.format() : event.end) : null,
            allDay: event.allDay,
            updatedByDrag: isDragUpdate
        };

        if (!updatedSchedule.id || updatedSchedule.id === 0) {
            console.error('Invalid schedule ID');
            alert('유효하지 않은 일정 ID입니다. 페이지를 새로고침한 후 다시 시도해주세요.');
            return;
        }

        if (!updatedSchedule.title || !updatedSchedule.start) {
            console.error('Missing required fields');
            alert('제목과 시작 날짜는 필수 입력 항목입니다.');
            return;
        }

        if (!isDragUpdate) {
            updatedSchedule.location = $('#viewSchedulePlace').val();
            updatedSchedule.description = $('#viewScheduleContent').val();
            updatedSchedule.color = $('#viewScheduleColor').val();
            updatedSchedule.type = $('input[name=viewScheduleType]:checked').val();
            updatedSchedule.participants = getSelectedParticipants('view');
        }

        $.ajax({
            url: path + '/schedule/updateSchedule',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(updatedSchedule),
            success: function(response) {
                $('#calendar').fullCalendar('refetchEvents');
                if (!isDragUpdate) {
                    $('#viewScheduleModal').modal('hide');
                }
                alert('일정이 성공적으로 수정되었습니다.');
            },
            error: function(xhr, status, error) {
                console.error('Schedule update error:', xhr.responseText);
                alert('일정 수정 중 오류가 발생했습니다: ' + (xhr.responseJSON ? xhr.responseJSON.message : error));
                $('#calendar').fullCalendar('refetchEvents');
            }
        });
    }

    // 캘린더와 사이드바 새로고침
    function refreshCalendarAndSidebar() {
        $('#calendar').fullCalendar('refetchEvents');
        $.ajax({
            url: path + '/schedule/',
            type: 'GET',
            success: function(response) {
                var $html = $(response);
                $('.calendar-legend').html($html.find('.calendar-legend').html());
                rebindToggleHeaders();
                restoreCheckboxStates();
            },
            error: function(xhr, status, error) {
                console.error("Error refreshing sidebar:", error);
            }
        });
    }

function restoreCheckboxStates() {
        $('.schedule-checkbox').each(function() {
            var scheduleId = $(this).data('id');
            var isChecked = localStorage.getItem('schedule_' + scheduleId) !== 'false';
            $(this).prop('checked', isChecked);
        });

        // 각 섹션의 체크박스 상태 업데이트
        updateSectionCheckbox('my');
        updateSectionCheckbox('share');
        updateSectionCheckbox('company');
    }

    // 토글 헤더 다시 바인딩
    function rebindToggleHeaders() {
        $('.toggle-header').off('click').on('click', function() {
            $(this).toggleClass('active');
            $(this).next('.legend-items').toggleClass('show');
        });
    }

    // ID로 이벤트 찾기
    function getEventById(id) {
        var event = null;
        $('#calendar').fullCalendar('clientEvents', function(evt) {
            if (evt.id == id) {
                event = evt;
                return true;
            }
            return false;
        });
        return event;
    }

    // 전사일정 등록 버튼 클릭 이벤트
    $("#addCompanyScheduleBtn").click(function() {
        $("#companyScheduleModal").modal('show');
        $('.company-color-option').first().click();
    });

    // 전사일정 폼 제출
    $("#addCompanyScheduleForm").submit(function(e) {
        e.preventDefault();
        var formData = {
            title: $("#companyScheduleTitle").val(),
            description: $("#companyScheduleContent").val(),
            location: $("#companySchedulePlace").val(),
            start: $("#companyScheduleDate").val(),
            end: $("#companyScheduleEnd").val(),
            allDay: $("#companyScheduleAllDay").is(":checked"),
            color: $("#companyScheduleColor").val(),
            type: "company"
        };

        $.ajax({
            url: path + '/schedule/addCompanySchedule',
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function(response) {
                alert("전사일정이 성공적으로 추가되었습니다.");
                $("#companyScheduleModal").modal('hide');
                refreshCalendarAndSidebar();
            },
            error: function(xhr, status, error) {
                alert("전사일정 추가 중 오류가 발생했습니다: " + error);
            }
        });
    });

    // 전사일정 모달의 색상 선택기
    $('.company-color-option').click(function() {
        $(this).siblings().removeClass('selected');
        $(this).addClass('selected');
        var color = $(this).data('color');
        $('#companyScheduleColor').val(color);
    });

    // 전사일정 모달의 날짜 입력 유효성 검사
    $('#companyScheduleDate, #companyScheduleEnd').on('change', function() {
        var startDate = $('#companyScheduleDate').val();
        var endDate = $('#companyScheduleEnd').val();

        if (startDate && endDate && endDate < startDate) {
            alert('종료 날짜는 시작 날짜 이후여야 합니다.');
            $('#companyScheduleEnd').val(startDate);
        }
    });

    // 페이지 로드 시 체크박스 상태 복원
    restoreCheckboxStates();
});