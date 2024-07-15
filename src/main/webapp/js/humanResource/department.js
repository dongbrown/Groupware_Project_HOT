/*
	부서관리 페이지용 js~
*/

$(document).ready(() => {

	makeDepartmentMenu();
	getDepartmentList(1);
});

function updateDepartment(departmentCode){
	fetch(path+'/api/hr/updateDepartment',{
		method:'POST',
		headers:{
			'Content-Type':'application/json'
		},
		body:JSON.stringify(RequestDepartment)
	})
	.then(response=>response.text())
	.then(data => {
		alert(data);
		location.reload();
	})
	.catch(error => {
		console.error('요청 실패:', error); // 요청 실패 시 에러 처리
	});
}

function deleteDepartment(deptCode){
	const RequestDepartment={
		deptCode:deptCode
	};
	fetch(path+'/api/hr/deleteDepartment',{
		method:'POST',
		headers:{
			'Content-Type':'application/json'
		},
		body:JSON.stringify(RequestDepartment)
	})
	.then(response=>response.text())
	.then(data => {
		alert(data);
		location.reload();
	})
	.catch(error => {
		console.error('요청 실패:', error); // 요청 실패 시 에러 처리
	});
}

//부서 등록 모달창 부서이름 중복확인 이벤트
$('#newTitle').keyup(e=>{
	const newTitle=$(e.target).val();
	fetch(path+'/api/employee/departmentList')
		.then(response => response.json())
		.then(data => {
			const check=data.some(d=>d.departmentTitle==newTitle);
				//부서 이름 중복 확인
				if(check){
					$(e.target).next().next().text('중복된 부서 이름입니다.').css('color','red');
				}else{
					$(e.target).next().next().text('');
				}
		})
		.catch(error => {
			console.error('요청 실패:', error); // 요청 실패 시 에러 처리
		});
});

//부서 등록 함수
function insertDepartment(){
	const newTitle=$('#newTitle').val(); //새로 생성할 부서 이름
	const highCode=$('.modal-dept-select').val(); //새로 생성할 부서의 상위부서 코드
	const RequestDepartment={
		newTitle:newTitle,
		highCode:highCode
	};
	fetch(path+'/api/hr/insertDepartment',{
			method:'POST',
			headers:{
				'Content-Type':'application/json'
			},
			body:JSON.stringify(RequestDepartment)
		})
		.then(response=>response.text())
		.then(data => {
			alert(data);
			location.reload();
		})
		.catch(error => {
			console.error('요청 실패:', error); // 요청 실패 시 에러 처리
		});
}

//부서 데이터 가져오는 함수
function getDepartmentList(cPage) {
	const title=$('.department-menu-title').eq(0).text().trim();
	fetch(path + '/api/hr/departmentList?cPage='+cPage+'&departmentTitle='+title)
		.then(response => response.json())
		.then(data => {
			console.log(data);
			makeDepartmentTable(data.departments);
			const $pagebar = createPagination(cPage, data.totalPage, 'getDepartmentList');
			$('.pagebar-div').html('').append($pagebar);
		})
		.catch(error => {
			console.error('요청 실패:', error); // 요청 실패 시 에러 처리
		});
}

//부서 테이블 만드는 함수
function makeDepartmentTable(departments){
	$('.dept-table tbody').html('');
	departments.forEach(d=>{
		const $tr=$('<tr>');
		const $highTitle=$('<td>').text(d.departmentHighTitle);
		const $title=$('<td>').text(d.departmentTitle);
		const $headName=$('<td>').text(d.departmentHeadName);
		const $count=$('<td>').text(d.totalDepartmentCount);
		const $btnTd=$('<td>');		
		const $updateBtn=$('<button>').addClass('btn btn-primary').attr('data-bs-toggle', 'modal').attr('data-bs-target', '#update-modal').text('수정');
		const $deleteBtn=$('<button>').addClass('btn btn-danger').attr('onclick', `deleteDepartment(${d.departmentCode})`).text('삭제');
		$btnTd.append($updateBtn).append($deleteBtn);
		$tr.append($highTitle).append($title).append($headName).append($count).append($btnTd);
		$('.dept-table tbody').append($tr);
	});
};

//부서 드롭다운 메뉴 선택 시 해당 부서 내용 가져오기
function searchDepartment(e){
	//부서 드롭다운 메튜 이름 바꾸기
	let title=$(e.target).text();
	if(title[0] == '-') title=title.substring(2);
	$('.department-menu-title').text(title);

	//부서 테이블 바꾸기
	getDepartmentList(1);
}

//부서 드롭다운 메뉴 만들기
function makeDepartmentMenu(){

	fetch(path + '/api/employee/departmentList')
		.then(response => response.json())
		.then(data => {
			const $target=$('.department-menu');
			$target.append($('<span>').addClass('dropdown-item').text('부서전체').click(searchDepartment));
			data.forEach(d=>{
				//부서 드롭다운 메뉴 만들기
				if(d.departmentHighCode <= 1){
					const $departmentTitle=$('<span>').addClass('dropdown-item')
						.text(d.departmentTitle)
						.click(searchDepartment);
					$target.append($departmentTitle);
				}
				
				//부서 생성 모달창 상위 부서 select태그 만들기
				if(d.departmentHighCode==0||d.departmentHighCode==1){
					const $option=$('<option>').val(d.departmentCode).text(d.departmentTitle);
					$('.modal-dept-select').append($option);
				}
			});
		})
		.catch(error => {
			console.error('요청 실패:', error); // 요청 실패 시 에러 처리
		});
}