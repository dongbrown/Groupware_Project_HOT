/**
 *  주소록 페이지 용 js ~
 */

$(document).ready(() => {
	if(searchName == ""){
		getEmployeeList(1);
	}else{
		$('.search-name').val(searchName);
		searchEmployee(1);
	}
	getDepartmentList();

	$('.search-name').on('keydown', function(event) {
		if (event.key === 'Enter') {
			event.preventDefault(); // 폼 제출 방지
			$('.search-btn').click(); // 버튼 클릭
		}
	});
});



//해당 페이지에 필요한 사원 데이터 가져와서 페이지구성
function getEmployeeList(cPage) {
	$('.card-div').html('');
	showLoadingSpinner($('.card-div'));
	fetch(path + '/api/employee/employeeList?cPage=' + cPage)
		.then(response => response.json())
		.then(data => {
			makeAddressCard(data.employees);
			const $pagebar = createPagination(cPage, data.totalPage, 'getEmployeeList');
			$('.pagebar-div').html('').append($pagebar);
		})
		.catch(error => {
			console.error('요청 실패:', error); // 요청 실패 시 에러 처리
		})
		.finally(() => {
            hideLoadingSpinner();
        });
}

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

//사원 주소 카드 태그 만드는 함수
function makeAddressCard(employees){

	employees.forEach(e=>{
		const $addressCard=$('<div>').addClass('border-left-primary address-card');

		//이미지
		const $leftDiv=$('<div>').addClass('card-left-div');
		const $imgDiv=$('<div>').addClass('img-div');
		const $img=$('<img>').addClass('employee-img')
		.attr('src',`${e.employeePhoto==null?`${path}/images/undraw_profile.svg`:`${path}/upload/employee/${e.employeePhoto}`}`);
		$imgDiv.append($img);
		$leftDiv.append($imgDiv);
		$addressCard.append($leftDiv);

		//사원 정보
		const $infoDiv=$('<div>').addClass('employee-info-div');
		const $span1=$('<span>').text(`${e.employeeName} ${e.positionCode.positionTitle}`);
		const $span2=$('<span>').text(`${e.departmentCode.departmentTitle}`);
		const $span3=$('<span>').text(`${e.employeeId}@hot.com`);
		const $span4=$('<span>').text(`${e.employeePhone}`);
		$infoDiv.append($span1).append($span2).append($span3).append($span4);
		$addressCard.append($infoDiv);

		$('.card-div').append($addressCard);
	})
}

//부서 드롭다운 메뉴 선택 시 드롭다운 text내용 바꾸는 함수
function changeTitle(e){
	let title=$(e.target).text();
	if(title[0] == '-') title=title.substring(2);
	$('.department-menu-title').text(title);
}

//검색 처리 함수
function searchEmployee(cPage){
	const name=$('.search-name').val().trim();
	let title=$('.department-menu-title').text().trim();
	if(title == '부서선택' || title == '부서전체') title='';
	$('.card-div').html('');
	showLoadingSpinner($('.card-div'));
	fetch(`${path}/api/employee/employeeList?cPage=${cPage}&name=${name}&title=${title}`)
	.then(response=>response.json())
	.then(data=>{
		console.log(data);
		makeAddressCard(data.employees);
		const $pagebar = createPagination(cPage, data.totalPage, 'searchEmployee');
		$('.pagebar-div').html('').append($pagebar);
	})
	.finally(() => {
    	hideLoadingSpinner();
    });
}
