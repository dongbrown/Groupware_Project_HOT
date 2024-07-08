// 설명  text 크기 카운트
	$('#floatingTextarea-project').on('input', function() {
	    let textLength = $(this).val().length;
	    $('#project-contents-count').text(textLength + '/1000');
	});

//종료 날짜 설정
//오늘 날짜 생성
function getTodayDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const day = String(today.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  // 1년 후 날짜를 가져오는 함수
      function getOneYearLaterDate() {
        const today = new Date();
        const nextYear = new Date(today.setFullYear(today.getFullYear() + 1));
        const year = nextYear.getFullYear();
        const month = String(nextYear.getMonth() + 1).padStart(2, '0');
        const day = String(nextYear.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
      }

// 날짜 입력 필드에 오늘 날짜 설정
  $("#project-end-date").val(getTodayDate());
  $("#project-end-date").attr('min', getTodayDate());
  $("#project-end-date").attr('max', getOneYearLaterDate());

//총 예산 원화 표시
    $('#project-budget').keyup(e=>{
        let value = e.target.value;
        let value1 = value.replace(/,/g,'');
        let result = Number(value1).toLocaleString('ko-KR');
        e.target.value=result;
    });

// 설명  text 크기 카운트
    $('#floatingTextarea').on('input', function() {
        let textLength = $(this).val().length;
        $('#project-contents-count').text(textLength + '/1000');
    });

	$(document).ready(function() {
		let checkedTotalCount = 1;
//프로젝트 생성 시 부서 선택하면 우측 상단에 해당 부서 사원  출력 로직
		$('#select-dept').on('change', function() {
			const selectedText = $("#select-dept option:selected").val();
			const inputMember = $("#input-member");
//선택하세요 선택시 맴버 비워주기
			if (selectedText === '선택하세요.') {
				inputMember.text('');
			} else {
				inputMember.empty();
//ajax 해당 사원 값 가져오기
			$.ajax({
				type: 'GET',
				url: '/project/selectEmpByDept.do',
				data: { dept: selectedText },
				dataType: 'json',
				success: function(emp) {
                	displayEmployees(emp);
            	},
				error: function() {
					alert("조회실패");
				}
			});
//ajax success시 실행되는 함수
			function displayEmployees(emp) {
				const inputDept = $('<div>', { id: 'input-member-title' });
				const inputMemberList = $('<div>', { id: 'input-member-list' });
				let deptTitle1='';
				emp.forEach((e,i)=>{
				deptTitle1 = `${e.departmentCode.departmentTitle}`;
				});
				const inputMemberTitle = $('<div>', { text: deptTitle1, class: 'input-group-text', id: 'input-group-text' });
				const memberSaveBtn = $('<button>', { id: 'member-save-btn', class: 'btn btn-primary', text: "저장" })

				inputDept.append(inputMemberTitle);
				inputMember.append(inputDept);
				inputMember.append(inputMemberList);
				inputMember.append(memberSaveBtn);
//반복문으로 사원 출력
				emp.forEach((e,i)=>{
					let empName = `${e.employeeName}`;
					let deptTitle = `${e.departmentCode.departmentTitle}`;
					let empNo = `${e.employeeNo}`;

					const checkboxId = 'flexCheckDefault' + i;
					const inputMemberWrab = $('<div>');
					const inputMemberDetail = $('<input>', { class: 'form-check-input', type: 'checkbox', id: checkboxId });
					const inputMemberDetailText = $('<label>',
						{ class: 'form-check-label', for: checkboxId, text: deptTitle + ': '+empName+' 사번 / ' + empNo});

// 이미 선택된 항목인지 확인
					if ($('#saved-members').find('.saved-item:contains("' + inputMemberDetailText.text() + '")').length > 0) {
						inputMemberDetail.prop('checked', true);
					}

					inputMemberWrab.append(inputMemberDetail).append(inputMemberDetailText).appendTo(inputMemberList);
					});
// 저장버튼 누르면 체크된 직원들 추가
			$('#member-save-btn').on('click', function() {
				const checkedItems = $('#input-member-list input:checked');
				const savedMembers = $('#saved-members');

				checkedItems.each(function() {
					const label = $(this).next('label').text();
					console.log(label);
					const totalMember = 0;
					checkedTotalCount++;
// 이미 존재하는 항목인지 확인
					if (savedMembers.find('.saved-item:contains("' + label + '")').length > 0) {
						checkedTotalCount--;
						return;
					}
					$("#totalMember").val(checkedTotalCount);


					const checkedMembersDel = $('<button>', { class: 'btn-close', type: 'button' });
					const savedItem = $('<div>', { text: label, id: 'checked-member-wrab', class: 'saved-item' });
					savedItem.append(checkedMembersDel);
					savedMembers.append(savedItem);
				});
			});
				}
			};


		});

// x 버튼 클릭 시 해당 항목 삭제
		$(document).on('click', '.btn-close', function() {
			$(this).closest('.saved-item').remove();
// 총 인원수 차감 출력
			checkedTotalCount--;
			$("#totalMember").val(checkedTotalCount);
// 삭제된 항목의 체크박스 해제
			const removedText = $(this).parent().text();
			$('#input-member-list input:checkbox').each(function() {
				if ($(this).next('label').text() === removedText) {
					$(this).prop('checked', false);

				}
			});
		});
	});

//프로젝트 저장 기능
	$(document).ready(function() {
		$('#insertProjectBtn').click(e => {
//프로젝트 입력 내용 json 저장
			const projectData = {
				projectTitle: $('input[name="projectTitle"]').val(),
				employeeNo: empNo,
				projectRank: $('select[name="importance"]').val(),
				projectContent: $('textarea[name="projectContent"]').val(),
				projectBudget: Number($('#project-budget').val().replace(/,/g, "")),
				projectEndDate: $('#project-end-date').val(),
				employee:[]
			};

//프로젝트 참여 맴버 json 저장
			$('#saved-members .saved-item').each(function() {
				let text = $(this).text().trim();
			    let parts = text.split(':');
			    let nameParts = parts[1].split('사번 /');
			    let empNo = nameParts[1].trim();

			    projectData.employee.push(empNo);
			});

//프로젝트 생성 ajax
			$.ajax({
				url: '/project/insertProject.do',
				type: 'POST',
				contentType: 'application/JSON',
				data: JSON.stringify(projectData),
				success: function(response) {
					alert("프로젝트 등록이 완료되었습니다.")
					console.log(projectData);
					location.assign("/");
				},
				error: function(error) {
					console.log(projectData);
					alert("프로젝트 등록이 실패하였습니다.")
					location.assign("/project/projectinsert.do");
				}
			});
		});
	});


