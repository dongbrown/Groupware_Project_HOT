getWorkList(1);
//페이지 불러오는 함수
		function getWorkList(cPage) {
			$('#work-list-table>tbody').html('');

			fetch(path + '/work/workupdateajax?cPage=' + cPage+'&employeeNo=0&projectNo='+projectNo)
				.then(response => response.json())
				.then(data => {
					makeWorkList(data.works);
					const $pagebar = createPagination(cPage, data.totalPage, 'getWorkList');
					$('.pagebar-div').html('').append($pagebar);
				})
				.catch(error => {
					console.error('요청 실패:', error); // 요청 실패 시 에러 처리
				});
		};
		function makeWorkList(works) {
			works.forEach(w => {
				//tr
				const $workList = $('<tr>', { class: 'work-choice',css:{cursor:'pointer'} });
				//td
				const $EmployeeNo = $('<td>', { id: 'workEmpNo', text: w.employeeNo, css: { display: 'none' } });
				const $workStartDate = $('<td>').text(w.projectWorkStartDate);
				const $workNo = $('<td>').text(w.projectWorkNo);
				const $workTitle = $('<td>').text(w.projectWorkTitle);

				//td 진행률
				const $workProgress = $('<td>');
				const $graphContainer = $('<div>', { class: 'graph-container' });
				const $bar = $('<div>', { class: 'bar', 'data-percentage': w.projectWorkProgress });
				const $percentageText = $('<div>', { css: { marginTop: '5px', marginLeft: '5px'}, text: w.projectWorkProgress + '%' });

				//td 진행률
				$graphContainer.append($bar).append($percentageText);
				$workProgress.append($graphContainer);

				$workList.append($EmployeeNo).append($workStartDate).append($workNo)
					.append($workTitle).append($workProgress).appendTo($('#work-list-table>tbody'));

			});
		};

		// 진행도 애니메이션
		$("#selectWorkList").click(e=>{
			const bars = document.querySelectorAll('.bar');
			bars.forEach(bar => {
				const percentage = bar.getAttribute('data-percentage');
				setTimeout(() => {
					bar.style.width = `${percentage}%`;
				}, 300);// 속도 조절
			});
		});

		//프로젝트 - 작업 클릭시 해당 작업 조회 페이지 이동
		$(document).on('click', '.work-choice', function(e) {
			const workNo = $(this).find('td:eq(2)').text();
			location.assign(path+'/work/selectworkdetail.do?workNo='+workNo);
		})