function createPagination(cPage, totalPages, fn){
	const pageSize=5;
	const $ul = $("<ul>").addClass('pagination');

	//이전페이지 넘버, 시작페이지 넘버, 끝페이지 넘버, 다음페이지 넘버 계산
	const prevPage = Math.max(1, Math.floor((cPage - 1) / pageSize) * pageSize + 1 - pageSize);
	const startPage = Math.floor((cPage - 1) / pageSize) * pageSize + 1;
	const endPage = Math.min(startPage + pageSize - 1, totalPages);
	const nextPage = Math.min(totalPages, startPage + pageSize);

	//이전 버튼 만들기
	const $prevLi=$('<li>').addClass(`paginate_button page-item ${cPage==1?'disabled':'previous'}`);
	const $prevA=$('<button>').addClass(`page-link `).attr('tabindex', '0')
	.attr('onclick', `${cPage==1?'':`${fn}(${prevPage})`}`).text('이전');

	$prevLi.append($prevA);
	$ul.append($prevLi);

	//페이지넘버링
	for(let i=startPage;i<=endPage;i++){
		const $pageLi=$('<li>').addClass(`paginate_button page-item ${cPage==i?'active':''}`);
		if(`${cPage}`==i){
			const $pageSpan=$('<span>').addClass('page-link').text(i);
			$pageLi.append($pageSpan);
		}else{
			const $pageA=$('<button>').addClass('page-link').attr('onclick', `${fn}(${i})`).attr('tabindex', '0').text(i);
			$pageLi.append($pageA);
		}
		$ul.append($pageLi);
	}

	//다음 버튼 만들기
	const $nextLi=$('<li>').addClass(`paginate_button page-item ${cPage==totalPages?'disabled':'next'}`);
	const $nextA=$('<button>').addClass(`page-link `).attr('tabindex', '0')
	.attr('onclick', `${endPage>=totalPages?'':`${fn}(${nextPage})`}`).text('다음');

	$nextLi.append($nextA);
	$ul.append($nextLi);

	return $ul;
}



//페이지 불러오는 함수
	function getProjectList(cPage) {
		$('#project-list-table>tbody').html('');

		fetch('/project/projectupdateajaxajax?cPage=' + cPage)
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

//프로젝트 리스트 생성
	function makeProjectList(projects) {

		projects.forEach(p => {
			//tr
			const $projectList = $('<tr>').addClass('project-choice');
			//td
			const $projectStartDate = $('<td>').text(p.projectStartDate);
			const $projectNo = $('<td>').text(p.projectNo);
			const $employeeName = $('<td>').text(p.employeeCode.employeeName);
			const $projectTitle = $('<td>').text(p.projectTitle);

			//td 진행률
			const $projectProgress = $('<td>');
			const $graphContainer = $('<div>', { class: 'graph-container' });
			const $bar = $('<div>', { class: 'bar', 'data-percentage': p.projectProgress });
			const $percentageText = $('<div>', { css: { marginTop: '5px', marginLeft: '5px' }, text: p.projectProgress + '%' });

			//td 삭제 버튼
			const $deleteButtonCell = $('<td>');
			const $deleteButton = $('<button>', { class: 'btn btn-sm btn-danger', 'data-bs-toggle': 'modal', 'data-bs-target': '#projectDeleteModal', text: '삭제' });

			//td 진행률
			$graphContainer.append($bar).append($percentageText);
			$projectProgress.append($graphContainer);
			//td삭제 버튼
			$deleteButtonCell.append($deleteButton);

			$projectList.append($projectStartDate).append($projectNo).append($employeeName)
				.append($projectTitle).append($projectProgress).append($deleteButtonCell).appendTo($('#work-list-table>tbody'));

		})
	}
	$(document).ready(function() {
		getProjectList(1);
	});

