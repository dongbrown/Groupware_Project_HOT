/*
	전 사원 휴가내역 페이지용 css~
*/

$(document).ready(()=>{

	getDepartmentList(); //부서 가져와서 select태그에 option태그 생성
	getEmpVacation(1);
})

//사원 휴가 내역 가져오기
function getEmpVacation(cPage){

	const $form=$('#searchForm').get(0);
	const fd=new FormData($form);
	const queryString=new URLSearchParams();

	for(let pair of fd.entries()){
		if(pair[1] != '' && pair[1] != null){
			queryString.append(pair[0], pair[1]);
		}
	}
	queryString.append('cPage', cPage);
	fetch(path+`/api/hr/selectAllEmpVacation?${queryString.toString()}`)
	.then(response=>response.json())
	.then(data=>{
		console.log(data);
		makeVacationTable(data.vacations);
		const $pagebar=createPagination(cPage, data.totalPage, 'getEmpVacation');
		$('.pagebar-div').html('').append($pagebar);
	})
	.catch(error=>{
		console.log(error);
	})
}

//휴가 테이블 만드는 함수
function makeVacationTable(vacations){
	$('.v-table tbody').html('');
	vacations.forEach(e=>{
		const $tr=$('<tr>');
		const $no=$('<td>').text(e.employeeNo.employeeNo);
		const $name=$('<td>').text(e.employeeNo.employeeName);
		const $pos=$('<td>').text(e.employeeNo.positionCode.positionTitle);
		const $dept=$('<td>').text(e.employeeNo.departmentCode.departmentTitle);
		const $date=$('<td>').text(e.approvalDate);
		const $type=$('<td>').text(e.vacationForm.vacationType);
		const $start=$('<td>').text(e.vacationForm.vacationStart);
		const $end=$('<td>').text(e.vacationForm.vacationEnd);
		const $day=$('<td>').text(e.vacationForm.vacationDay);
		$tr.append($no).append($name).append($pos).append($dept).append($date).append($type).append($start).append($end).append($day);
		$('.v-table tbody').append($tr);
	})
}


//부서 데이터 가져오는 함수
function getDepartmentList() {
	fetch(path + '/api/employee/departmentList')
		.then(response => response.json())
		.then(data => {
			data.forEach(d=>{
				//사원 수정 모달창의 부서 select태그에 option태그 생성
				const $deptOp=$('<option>').attr('value', d.departmentCode)
								.text(d.departmentHighCode<=1?`---${d.departmentTitle}---`:d.departmentTitle)
								.attr('disabled', d.departmentHighCode<=1);
				$('#department').append($deptOp);
			});
		})
		.catch(error => {
			console.error('요청 실패: ', error); // 요청 실패 시 에러 처리
		});
}