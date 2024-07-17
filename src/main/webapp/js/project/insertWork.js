getProjectList(1);
//페이지 불러오는 함수
		function getProjectList(cPage) {
			$('#work-list-table>tbody').html('');

			fetch(path + '/work/projectupdateajax?cPage=' + cPage+'&employeeNo='+empNo)
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

//프로젝트 리스트 생성
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

				//td 진행률
				$graphContainer.append($bar).append($percentageText);
				$projectProgress.append($graphContainer);

				$projectList.append($EmployeeNo).append($projectStartDate).append($projectNo).append($employeeName)
					.append($projectTitle).append($projectProgress).appendTo($('#work-list-table>tbody'));

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
		const empNo = Number($("#projectEmpNo").text());
	    location.assign("/work/insertwork.do?projectNo="+projectNo);
	});


