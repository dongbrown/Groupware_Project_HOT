/*
	페이지바 만들기 js~
	현재 페이지, 총 페이지개수, 버튼에 적용시킬 함수를 넘기면
	페이지바 ul태그 반환
*/

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
	const $nextLi=$('<li>').addClass(`paginate_button page-item ${cPage==totalPages||totalPages==0?'disabled':'next'}`);
	const $nextA=$('<button>').addClass(`page-link `).attr('tabindex', '0')
	.attr('onclick', `${endPage>=totalPages?`${fn}(${endPage})`:`${fn}(${nextPage})`}`).text('다음');

	$nextLi.append($nextA);
	$ul.append($nextLi);

	return $ul;
}