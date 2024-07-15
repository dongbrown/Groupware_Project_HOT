		getWorkList(1);
//페이지 불러오는 함수
		function getWorkList(cPage) {
			$('#work-list-table>tbody').html('');

			fetch(path + '/work/workupdateajax?cPage=' + cPage+'&employeeNo='+empNo)
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
				const $workList = $('<tr>').addClass('work-choice');
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

				//td 삭제 버튼
				const $deleteButtonCell = $('<td>');
				const $deleteButton = $('<button>', { class: 'btn btn-sm btn-danger', 'data-bs-toggle': 'modal', 'data-bs-target': '#workDeleteModal', text: '삭제' });

				//td 진행률
				$graphContainer.append($bar).append($percentageText);
				$workProgress.append($graphContainer);
				//td삭제 버튼
				$deleteButtonCell.append($deleteButton);

				$workList.append($EmployeeNo).append($workStartDate).append($workNo)
					.append($workTitle).append($workProgress).append($deleteButtonCell).appendTo($('#work-list-table>tbody'));

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

//작업 선택 시 작업 수정 할 페이지 이동
		$(document).on('click', '.work-choice', function() {
			const workNo = $(this).closest('.work-choice').children().eq(2).text();
			location.assign('/work/workupdatedetail.do?workNo='+workNo);
	})