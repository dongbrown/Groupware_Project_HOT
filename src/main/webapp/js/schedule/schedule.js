$(document).ready(function() {
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

    // 색상 선택기 기능 추가
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
        // 기본 색상 선택
        $('.color-option[data-color="#0000FF"]').click();
    }

    // 일정 보기/수정 모달 열기
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
    }

    // 모달 닫기 함수
    function closeModal(modalElement) {
        $(modalElement).css('display', 'none');
    }

    // 모달 닫기 버튼 클릭 이벤트
    $('.close').click(function() {
        closeModal($(this).closest('.modal'));
    });

    // 모달 바깥 영역 클릭 시 모달 닫기
    $(window).click(function(event) {
        if ($(event.target).hasClass('modal')) {
            closeModal(event.target);
        }
    });

    // 일정 추가
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
            type: $('input[name=scheduleType]:checked').val()
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

    // 일정 수정
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
            type: $('input[name=viewScheduleType]:checked').val()
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

    // 일정 삭제
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

    const selectDept = $('#select-dept');
    const deptSelectGroup = $('#deptSelectGroup');
    const employeeByDept = $('#employeeByDept');
    const selectEmp = $('#select-emp');
    const selectedEmployee = $('#selectedEmployee');
    const selectedEmployeeName = $('#selectedEmployeeName');

    // 공유 캘린더 선택 시 부서 선택 div 보이도록
    $('input[name="scheduleType"]').on('change', function() {
        if ($(this).val() === 'share') {
            deptSelectGroup.show();
        } else {
            deptSelectGroup.hide();
            employeeByDept.hide();
            selectedEmployee.hide();
        }
    });

    // 부서 목록 가져오기
    $.ajax({
        url: '/api/departmentList',
        type: 'GET',
        dataType: 'json',
        success: function(departments) {
            $.each(departments, function(index, dept) {
                selectDept.append($('<option>', {
                    value: dept.departmentCode,
                    text: dept.departmentTitle
                }));
            });
        },
        error: function(xhr, status, error) {
            console.error("Error fetching departments:", error);
        }
    });

    // 부서 선택 변경 이벤트 처리
    selectDept.on('change', function() {
        const selectedDeptCode = $(this).val();
        if (selectedDeptCode) {
            $.ajax({
                url: '/schedule/selectEmpByDept',
                type: 'GET',
                data: { deptCode: selectedDeptCode },
                dataType: 'json',
                success: function(employees) {
                    selectEmp.empty().append($('<option>', {
                        value: '',
                        text: '선택하세요'
                    }));

                    if (Array.isArray(employees)) {
                        $.each(employees, function(index, emp) {
                            selectEmp.append($('<option>', {
                                value: emp.employeeNo,
                                text: emp.employeeName
                            }));
                        });
                        employeeByDept.show();
                    } else {
                        console.error('Employees data is not an array:', employees);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching employees:", error);
                    console.log("Status:", status);
                    console.log("Response:", xhr.responseText);
                }
            });
        } else {
            employeeByDept.hide();
            selectedEmployee.hide();
        }
    });

    // 사원 선택 변경 이벤트 처리
    selectEmp.on('change', function() {
        const selectedEmpNo = $(this).val();
        const selectedEmpName = $(this).find("option:selected").text();
        if (selectedEmpNo) {
            selectedEmployeeName.text(selectedEmpName);
            selectedEmployee.show();
        } else {
            selectedEmployee.hide();
        }
    });

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