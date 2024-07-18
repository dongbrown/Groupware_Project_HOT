/*
	전 사원 관리 페이지용 js~
*/

$(document).ready(()=>{

	getDepartmentList();
})

//부서 데이터 가져오는 함수
function getDepartmentList() {
	fetch(path + '/api/employee/departmentList')
		.then(response => response.json())
		.then(data => {
			data.forEach(d=>{
				//사원 수정 모달창의 부서 select태그에 option태그 생성
				const $deptOp=$('<option>').attr('value', d.departmentCode)
								.text(d.departmentHighCode<=1?`---${d.departmentTitle}---`:d.departmentTitle);
				$('#department').append($deptOp);
			});
		})
		.catch(error => {
			console.error('요청 실패: ', error); // 요청 실패 시 에러 처리
		});
}