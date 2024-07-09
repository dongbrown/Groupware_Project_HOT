$(document).ready(function() {
    // 메인 캘린더 초기화
    var calendar = $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        selectable: true,
        selectHelper: true,
        editable: true,
        eventLimit: true,
        events: '/schedule/schedule',
        select: function(start, end) {
            openAddScheduleModal(start, end);
        },
        eventClick: function(event) {
            openViewScheduleModal(event);
        },
        eventDrop: function(event) {
            updateSchedule(event);
        },
        eventResize: function(event) {
            updateSchedule(event);
        }
    });

    // 작은 캘린더 초기화 (월 선택용)
    var calendar2 = $('#calendar2').fullCalendar({
        header: {
            left: 'prev',
            center: 'title',
            right: 'next'
        },
        defaultView: 'month',
        height: 'auto',
        selectable: false,
        selectHelper: false,
        editable: false,
        eventLimit: false,
        events: [], // 빈 배열로 설정하여 일정을 표시하지 않음
        dayClick: function(date) {
            // 메인 캘린더의 날짜를 클릭한 날짜로 이동
            $('#calendar').fullCalendar('gotoDate', date);
        },
        viewRender: function(view, element) {
            // 헤더 타이틀 형식 변경  @@@ 안됨!
            var title = moment(view.start).format('YYYY MM');
            element.find('.fc-center h2').text(title);
        }
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
        $('#scheduleModal').css('display', 'block');
        $('#scheduleDate').val(start.format('YYYY-MM-DD'));
        $('#scheduleEnd').val(end.format('YYYY-MM-DD'));
        $('.color-option[data-color="#0000FF"]').click();
        loadDepartments();
        $('#participantSelection').hide();
    }

    // 일정 조회/수정 모달 열기
    function openViewScheduleModal(event) {
        $('#viewScheduleModal').css('display', 'block');
        $('#viewScheduleId').val(event.id);
        $('#viewScheduleTitle').val(event.title);
        $('#viewSchedulePlace').val(event.location);
        $('#viewScheduleContent').val(event.description);
        $('#viewScheduleStart').val(event.start.format('YYYY-MM-DD'));
        $('#viewScheduleEnd').val(event.end ? event.end.format('YYYY-MM-DD') : '');
        $('#viewScheduleAllDay').prop('checked', event.allDay);
        var color = event.color || '#0000FF';
        $('#viewScheduleColor').val(color);
        $(`.color-option[data-color="${color}"]`).click();
        $(`input[name=viewScheduleType][value=${event.type}]`).prop('checked', true);
        loadDepartments('view');
        if (event.participants) {
            loadParticipants(event.participants, 'view');
        }
        if (event.type === 'share') {
            $('#viewParticipantSelection').show();
        } else {
            $('#viewParticipantSelection').hide();
        }
    }

    // 모달 닫기 함수
    function closeModal(modalElement) {
        $(modalElement).css('display', 'none');
    }

    // 모달 닫기 버튼 클릭 이벤트
    $('.close').click(function() {
        closeModal($(this).closest('.modal'));
    });

    // 모달 외부 클릭 시 닫기
    $(window).click(function(event) {
        if ($(event.target).hasClass('modal')) {
            closeModal(event.target);
        }
    });

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
            url: '/schedule/addSchedule',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(newSchedule),
            success: function(response) {
                $('#calendar').fullCalendar('renderEvent', newSchedule);
                closeModal('#scheduleModal');
                $('#addScheduleForm')[0].reset();
            },
            error: function(xhr, status, error) {
                alert('일정 추가 중 오류가 발생했습니다: ' + error);
            }
        });
    });
    function getSelectedParticipants() {
    	return $('#selectedEmployeeList li').map(function() {
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
            participants: getSelectedParticipants('view')
        };

        $.ajax({
            url: '/schedule/updateSchedule',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(updatedSchedule),
            success: function(response) {
                $('#calendar').fullCalendar('updateEvent', updatedSchedule);
                closeModal('#viewScheduleModal');
            },
            error: function(xhr, status, error) {
                alert('일정 수정 중 오류가 발생했습니다: ' + error);
            }
        });
    });

    // 일정 삭제 버튼 클릭 이벤트
    $('#deleteScheduleBtn').click(function() {
        if (confirm('정말로 이 일정을 삭제하시겠습니까?')) {
            var scheduleId = $('#viewScheduleId').val();
            $.ajax({
                url: '/schedule/deleteSchedule',
                type: 'DELETE',
                data: { id: scheduleId },
                success: function(response) {
                    $('#calendar').fullCalendar('removeEvents', scheduleId);
                    closeModal('#viewScheduleModal');
                    alert('일정이 성공적으로 삭제되었습니다.');
                },
                error: function(xhr, status, error) {
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
            url: '/api/departmentList',
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
            url: '/schedule/selectEmpByDept',
            type: 'GET',
            data: { deptCode: deptCode },
            dataType: 'json',
            success: function(employees) {
                const employeeList = $(`#${prefix}employeeList`);
                employeeList.empty();
                if (Array.isArray(employees)) {
                    $.each(employees, function(index, emp) {
                        employeeList.append(`<li data-emp-no="${emp.employeeNo}">${emp.employeeName} (${emp.position})</li>`);
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

    // 선택된 참석자 목록 가져오기
    function getSelectedParticipants(prefix = '') {
        return $(`#${prefix}selectedEmployeeList li`).map(function() {
            return $(this).data('emp-no');
        }).get();
    }

    // 참석자 목록 로드 (일정 수정 시)
    function loadParticipants(participants, prefix = '') {
        $(`#${prefix}selectedEmployeeList`).empty();
        $.each(participants, function(index, participant) {
            $(`#${prefix}selectedEmployeeList`).append(`<li data-emp-no="${participant.employeeNo}">${participant.employeeName} <span class="remove-employee">&times;</span></li>`);
        });
    }

    // 일정 드래그 또는 리사이즈 후 업데이트
    function updateSchedule(event) {
        $.ajax({
            url: '/schedule/updateSchedule',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify({
                id: event.id,
                start: event.start.format(),
                end: event.end ? event.end.format() : null,
                allDay: event.allDay
            }),
            error: function(xhr, status, error) {
                alert('일정 수정 중 오류가 발생했습니다: ' + error);
                $('#calendar').fullCalendar('refetchEvents');
            }
        });
    }
});