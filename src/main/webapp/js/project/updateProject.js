		getProjectList(1);
//페이지 불러오는 함수
		function getProjectList(cPage) {
			$('#project-list-table>tbody').html('');
			fetch(path + '/project/projectupdatelistajax?cPage=' + cPage+'&employeeNo='+empNo)
				.then(response => response.json())
				.then(data => {
					makeProjectList(data.projects);

					const $pagebar = createPagination(cPage, data.totalPage, 'getProjectList');
					$('.pagebar-div').html('').append($pagebar);
				})
				.catch(error => {
					console.error('요청 실패:', error); // 요청 실패 시 에러 처리
				});
		};
		function makeProjectList(projects) {
			projects.forEach(p => {
				//tr
				const $projectList = $('<tr>').addClass('project-choice');
				//td
				const $EmployeeNo = $('<td>', { id: 'projectEmpNo', text: p.employeeCode.employeeNo, css: { display: 'none' } });
				const $projectStartDate = $('<td>').text(p.projectStartDate);
				const $projectNo = $('<td>').text(p.projectNo);
				const $employeeName = $('<td>').text(p.employeeCode.employeeName);
				const $projectTitle = $('<td>').text(p.projectTitle);

				//td 진행률
				const $projectProgress = $('<td>');
				const $graphContainer = $('<div>', { class: 'graph-container' });
				const $bar = $('<div>', { class: 'bar', 'data-percentage': p.projectProgress });
				const $percentageText = $('<div>', { css: { marginTop: '5px', marginLeft: '5px'}, text: p.projectProgress + '%' });

				//td 삭제 버튼
				const $deleteButtonCell = $('<td>');
				const $deleteButton = $('<button>', { id: 'deleteProjectBtn',class: 'btn btn-sm btn-danger', 'data-bs-toggle': 'modal', 'data-bs-target': '#projectDeleteModal', text: '삭제' });

				//td 진행률
				$graphContainer.append($bar).append($percentageText);
				$projectProgress.append($graphContainer);
				//td삭제 버튼
				$deleteButtonCell.append($deleteButton);

				$projectList.append($EmployeeNo).append($projectStartDate).append($projectNo).append($employeeName)
					.append($projectTitle).append($projectProgress).append($deleteButtonCell).appendTo($('#project-list-table>tbody'));

			});
// 진행도 애니메이션
			const bars = document.querySelectorAll('.bar');
			bars.forEach(bar => {
				const percentage = bar.getAttribute('data-percentage');
				setTimeout(() => {
					bar.style.width = `${percentage}%`;
				}, 300);// 속도 조절
			});
		};

/*------------------------------------------*/

/*프로젝트 목록중 하나 클릭시 해당 프로젝트 정보와 수정가능한 테이블 표시*/
	$(document).on('click', '.project-choice', function(e) {
		const projectNo = Number(e.target.parentElement.children[2].textContent);
	    location.assign(path+"/project/selectProjectByNo.do?projectNo="+projectNo+"&empNo="+empNo);

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
	$(document).on('click', '#deleteProjectBtn', function(e) {
		const projectNo = Number($(this).closest('tr').children().eq(2).text());
		$(document).on('click', '#delectProjectFinalBtn', function(e) {
			fetch(path+"/project/deleteProject.do",{
				method:'POST',
				headers: {
			        'Content-Type': 'application/json'
			    },
			     body: JSON.stringify({
		            projectNo: projectNo,
		            empNo: empNo
        		}),
			})
			.then(response => {
		        if (!response.ok) {
		            throw new Error('서버 응답이 실패했습니다.');
		        }
		        return response.text();
			})
			.then(data=>{
				alert("삭제 완료");
				location.reload();
			})
			.catch(error=>{
				alert("프로젝트 삭제 실패");
				console.log(error);
			})
		});
	});
