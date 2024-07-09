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


//통화 표시
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
//페이지 불러온느 함수
		function getProjectList(cPage) {
			$('#project-list-table>tbody').html('');

			fetch(path + '/project/projectupdateajax?cPage=' + cPage)
				.then(response => response.json())
				.then(data => {
					console.log(data);
					makeProjectList(data.projects);

					const $pagebar = createPagination(cPage, data.totalPage, 'getProjectList');
					$('.pagebar-div').html('').append($pagebar);
				})
				.catch(error => {
					console.error('요청 실패:', error); // 요청 실패 시 에러 처리
				});
		};

		function makeProjectList(projects){

			projects.forEach(p=>{
				//tr
				const $projectList=$('<tr>').addClass('project-choice');
				//td
				const $projectStartDate=$('<td>').text(p.projectStartDate);
				const $projectNo=$('<td>').text(p.projectNo);
				const $employeeName=$('<td>').text(p.employeeCode.employeeName);
				const $projectTitle=$('<td>').text(p.projectTitle);

				//td 진행률
				const $projectProgress = $('<td>');
				const $graphContainer = $('<div>', { class: 'graph-container' });
				const $bar = $('<div>', { class: 'bar', 'data-percentage': p.projectProgress });
				const $percentageText = $('<div>', { css: { marginTop: '5px', marginLeft: '5px' }, text: p.projectProgress + '%'});

				//td 삭제 버튼
				const $deleteButtonCell = $('<td>');
				const $deleteButton = $('<button>', { class: 'btn btn-sm btn-danger', 'data-bs-toggle': 'modal', 'data-bs-target': '#projectDeleteModal', text: '삭제'});

				//td 진행률
				$graphContainer.append($bar).append($percentageText);
				$projectProgress.append($graphContainer);
				//td삭제 버튼
				$deleteButtonCell.append($deleteButton);

				$projectList.append($projectStartDate).append($projectNo).append($employeeName)
				.append($projectTitle).append($projectProgress).append($deleteButtonCell).appendTo($('#project-list-table>tbody'));

			})
		}

//프로젝트 리스트 테이블 만드는 함수


//총 인원 추가될때 총인원 값 변환
	$(document).ready(function() {
		getProjectList(1);

		const savedItems = $('.saved-item');
		let checkedTotalCount = 1;
		savedItems.each(function() {
			if ($(this).text().includes('사번')) {
				checkedTotalCount++;
			}
		});
		$("#totalMember").val(checkedTotalCount);

//프로젝트 생성 시 부서 선택하면 우측 상단에 해당 부서 사원  출력 로직
	$('#select-dept').on('change', function() {
		const selectedText = $("#select-dept option:selected").val();
		const inputMember = $("#input-member");
//선택하세요 선택시 맴버 비워주기
		if (selectedText === '선택하세요.') {
			inputMember.text('');
		} else {
			inputMember.empty();
//ajax로 해당 사원 값 가져오기
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
				console.log(emp);
				const inputDept = $('<div>', { id: 'input-member-title' });
				const inputMemberList = $('<div>', { id: 'input-member-list' });
				let deptTitle1 = '';
				emp.forEach((e, i) => {
					deptTitle1 = `${e.departmentCode.departmentTitle}`;
				});
				const inputMemberTitle = $('<div>', { text: deptTitle1, class: 'input-group-text', id: 'input-group-text' });
				const memberSaveBtn = $('<button>', { id: 'member-save-btn', class: 'btn btn-primary', text: "저장" })

				inputDept.append(inputMemberTitle);
				inputMember.append(inputDept);
				inputMember.append(inputMemberList);
				inputMember.append(memberSaveBtn);
//반복문으로 사원 출력
				emp.forEach((e, i) => {
					let empName = `${e.employeeName}`;
					let deptTitle = `${e.departmentCode.departmentTitle}`;
					let empNo = `${e.employeeNo}`;

					const checkboxId = 'flexCheckDefault' + i;
					const inputMemberWrab = $('<div style="display:flex;">');
					const inputMemberDetail = $('<input>', { class: 'form-check-input', type: 'checkbox', id: checkboxId });
					const inputMemberDetailText = $('<label>',
						{ class: 'form-check-label', for: checkboxId, text: deptTitle + ': ' + empName + ' 사번 / ' + empNo });

// 이미 선택된 항목인지 확인
					if ($('#saved-members').find('#checked-member-wrab:contains("' + e.employeeNo + '")').length > 0) {
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
						savedItem.append(checkedMembersDel).appendTo(savedMembers);
					});
				});
			}
		};


		});
// x 버튼 클릭 시 해당 사원 삭제
		$(document).on('click', '.btn-close', function() {
			$(this).closest('.saved-item').remove();
// 총 인원수 차감 출력
			checkedTotalCount--;
			$("#totalMember").val(checkedTotalCount);
// 삭제된 항목의 체크박스 해제
			const removedText = $(this).parent().text();
			$('#input-member-list input:checkbox').each(function() {
				if ($(this).next('label').text() == removedText) {
					$(this).prop('checked', false);
					}
				});
			});
		});

/*프로젝트 목록 자바스크릡트 */
	$(document).ready(function() {
		//$("#project-update-window").css('display', 'none');
// 진행도 애니메이션
		const bars = document.querySelectorAll('.bar');
		bars.forEach(bar => {
			const percentage = bar.getAttribute('data-percentage');
			setTimeout(() => {
				bar.style.width = `${percentage}%`;
			}, 300);// 속도 조절
		});
	});
/*------------------------------------------*/

/*프로젝트 목록중 하나 클릭시 해당 프로젝트 정보와 수정가능한 테이블 표시*/
 	$(".project-choice").click(e=>{
		const projectNo = Number(e.target.parentElement.children[1].textContent);
	    location.assign("/project/selectProjectByNo.do?projectNo="+projectNo);

	  /*  const projectNo = Number(e.target.parentElement.children[1].textContent);
	    console.log(projectNo);
	    $.ajax({
			url: '/project/selectProjectByNo.do',
			type: 'GET',
			data: { projectNo: projectNo },
			dataType: 'json',
			success: function(p) {
//선택 프로젝트의 원본 내용 출력
				 $("#project-title").val(p.projectTitle);
				 if (p && p.employeeCode && p.employeeCode.employeeName) {
					    $("#project-emp").val(p.employeeCode.employeeName);
					} else {
					    console.error('employeeName이 존재하지 않습니다.');
					}
				 $('#project-rank').val(p.projectRank);
				 $('#floatingTextarea').text(p.projectContent);
				 $('#project-budget').val(p.projectBudget);
				 $('#project-end-date').val(p.projectEndDate);

//선택된 프로젝트가 없습니다 이미지 안보이게
			    $("#noneProjectImg").css('display','none');
			    $("#project-list").css('display','none');
			    $("#project-update-window").css('display','flex');

//참여 사원 정보 ajax로 가져오기
				$.ajax({
					url:'/project/selectEmployeetByProjectNo.do',
					type: 'GET',
					data: { projectNo: projectNo },
					dataType: 'json',
					success: function(pe) {
						console.log(pe);
//반복문 사용 -- 프로젝트 기존 참여 인원 출력
					pe.forEach((pi) => {
					const empWrapDiv=$('<div>',{id:'checked-member-wrab', class:'saved-item',
													text:"안녕"});
					const empWrapDivDelete=$('<button>',{class:'btn-close', type:'button'})
					const empInfo = pi.employee.departmentCode.departmentTitle;
					//개발3팀: 홍길동 사번 / 212341234
					empWrapDiv.append(empWrapDivDelete).appendTo($('#saved-members'));
					})


					}
				});
			},
//에러 발생시 알림 창
			error: function() {
				alert("로그인 후 이용할 수 있습니다.")
				location.assign("/project/projectupdate.do");
			}
		})*/
    });

//프로젝트 삭제 버튼
	const delectProjectBtn=()=>{
		const projectNo = Number(e.target.parentElement.children[1].textContent);
		$.ajax({
			url:"/project/deleteProject.do",
			type:"GET",
			data: { projectNo: projectNo },
			dataType: 'json',
			success: function() {
				alert("삭제되었습니다.");
			},
			error: function(){
				alert("삭제 실패");
			}

		})
	}

	/*$("#projectUpdateCancle").click(e=>{
	    const projectNo = e.target.parentElement.children[1].textContent;
	    console.log(projectNo); // 프로젝트 고유번호 넘겨서 프로젝트 수정페이지로 이동
//선택된 프로젝트가 없습니다 이미지 안보이게

	    $("#input-member").css('display','none');
	    $("#noneProjectImg").css('display','block');
	    $("#project-list").css('display','block');
	    $("#project-update-window").css('display','none');//ajax 받아온 값 지워주기
    });*/

