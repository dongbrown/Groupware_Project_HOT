/*
	페이지바 만들기 js~
*/

function createPagination(cPage, totalPages, url){
	const pageSize=5;
	const $ul = $("<ul>").addClass('pagination');

	//이전페이지 넘버, 시작페이지 넘버, 끝페이지 넘버, 다음페이지 넘버 계산
	const prevPage = Math.max(1, Math.floor((cPage - 1) / pageSize) * pageSize);
	const startPage = Math.floor((cPage - 1) / pageSize) * pageSize + 1;
	const endPage = Math.min(startPage + pageSize - 1, totalPages);
	const nextPage = Math.min(totalPages, startPage + pageSize);

	//이전 버튼 만들기
	const $prevLi=$('<li>').addClass(`paginate_button page-item ${cPage==1?'disabled':'previous'}`);
	const $prevA=$('<a>').addClass(`page-link `).attr('tabindex', '0')
	.attr('href', `${cPage==1?'#':`${url}?cPage=${prevPage}`}`).text('이전');

	$prevLi.append($prevA);
	$ul.append($prevLi);

	//페이지넘버링
	for(let i=startPage;i<=endPage;i++){
		const $pageLi=$('<li>').addClass(`paginate_button page-item ${cPage==i?'active':''}`);
		const $pageA=$('<a>').addClass('page-link').attr('href', `${url}?cPage=${i}`).attr('tabindex', '0').text(i);
		$pageLi.append($pageA);
		$ul.append($pageLi);
	}

	//다음 버튼 만들기
	const $nextLi=$('<li>').addClass(`paginate_button page-item ${cPage==totalPages?'disabled':'next'}`);
	const $nextA=$('<a>').addClass(`page-link `).attr('tabindex', '0')
	.attr('href', `${endPage>=totalPages?'#':`${url}?cPage=${nextPage}`}`).text('다음');

	$nextLi.append($nextA);
	$ul.append($nextLi);

	return $ul;
}