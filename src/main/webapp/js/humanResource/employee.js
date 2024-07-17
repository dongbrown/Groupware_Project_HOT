/*
	사원 관리 페이지용 js~
*/

$(document).ready(()=>{

	getDepartmentList();
})

//부서 데이터 가져오는 함수
function getDepartmentList() {
	fetch(path + '/api/employee/departmentList')
		.then(response => response.json())
		.then(data => {
			const $target=$('.department-menu');
			$target.append($('<span>').addClass('dropdown-item').text('부서전체').click(changeTitle));
			data.forEach(d=>{
				const $departmentTitle=$('<span>').addClass('dropdown-item')
				.text(d.departmentHighCode<=1?d.departmentTitle:`--${d.departmentTitle}`)
				.click(changeTitle);
				$target.append($departmentTitle);
			});
		})
		.catch(error => {
			console.error('요청 실패:', error); // 요청 실패 시 에러 처리
		});
}

//부서 드롭다운 메뉴 선택 시 드롭다운 text내용 바꾸는 함수
function changeTitle(e){
	let title=$(e.target).text();
	if(title[0] == '-') title=title.substring(2);
	$('.department-menu-title').text(title);
}