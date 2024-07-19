/*
	부서관리 페이지용 js~
*/

$(document).ready(() => {

	makeDepartmentMenu();
	getDepartmentList(1);
	$('#newTitle').keyup(checkDepartmentName);
	$('#updateTitle').keyup(checkDepartmentName);
});

//부서 수정 함수
function updateDepartment(departmentCode){
	if($('#updateTitle').next().next().text()==''){
		const deptCode=$('#deptCode').val(); //수정할 부서 코드
		const newTitle=$('#updateTitle').val(); //수정할 부서 이름
		const highCode=$('#updateHighTitle').val(); //수정할 부서의 상위부서 코드
		const RequestDepartment={
			deptCode:deptCode,
			newTitle:newTitle,
			highCode:highCode
		};

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
			getDepartmentList(1);
		})
		.catch(error => {
			console.error('요청 실패:', error); // 요청 실패 시 에러 처리
		});
	}else{
		alert('중복된 부서 이름입니다. 다른 이름을 사용해주세요!')
	}
}

//부서 수정버튼 누를 시 모달창에 해당 부서 코드, 현재이름, 상위부서 데이터 띄워놓는 함수
$(document).on('click', '#updateModal', e=>{
	const deptCode=$(e.target).data('dept-code');
	const thisTitle=$(e.target).parent().siblings().eq(1).text();
	const thisHighTitle=$(e.target).parent().siblings().eq(0).text();

	$('#updateTitle').val(thisTitle);

	$('#updateHighTitle option').filter(function(){
		return $(this).text()==thisHighTitle
	}).prop('selected', true);

	$('#deptCode').val(deptCode);
	$('#deptTitle').val(thisTitle);
})

//부서 삭제 함수
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
		getDepartmentList(1);
	})
	.catch(error => {
		console.error('요청 실패:', error); // 요청 실패 시 에러 처리
	});
}

//부서 등록,수정 모달창 부서이름 중복확인 이벤트
function checkDepartmentName(e){
	const newTitle=$(e.target).val();

	if($(e.target).is($('#updateTitle'))){
		//부서 수정일때
		//현재 부서 이름은 중복 체크 안함
		const cTitle=$('#deptTitle').val();
		if(newTitle==cTitle){
			return;
		}
	}

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
}


//부서 등록 함수
function insertDepartment(){
	if($('#newTitle').next().next().text()==''){
		const newTitle=$('#newTitle').val(); //새로 생성할 부서 이름
		const highCode=$('#insertHighTitle').val(); //새로 생성할 부서의 상위부서 코드
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
				getDepartmentList(1);
			})
			.catch(error => {
				console.error('요청 실패:', error); // 요청 실패 시 에러 처리
			});
	}else{
		alert('중복된 부서 이름입니다. 다른 이름을 사용해주세요!');
	}
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
		const $updateBtn=$('<button>').addClass('btn btn-primary mr-1').attr('data-bs-toggle', 'modal')
							.attr('data-bs-target', '#update-modal').attr('id','updateModal')
							.attr('data-dept-code', d.departmentCode).text('수정');
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