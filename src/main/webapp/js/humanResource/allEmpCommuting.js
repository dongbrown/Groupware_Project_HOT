/*
	전 사원 관리 페이지용 js~
*/

$(document).ready(()=>{

	$('input[name=searchDate]').val(new Date().toISOString().substring(0,10));
	getDepartmentList();
	searchEmpCommuting(1);
});

//수정 함수
function updateCommuting(){
	const commutingNo=$('#modalCommutingNo').val();
	const comDate=$('#modalComDate').text().trim();
	const status=$('#modalStatus').val();
	const goTime=$('#modalGoTime').val(); //시간 값
	const goTimeDate=new Date(comDate); //Date객체로 만들기
	goTimeDate.setHours(parseInt(goTime.split(':')[0]));
	goTimeDate.setMinutes(parseInt(goTime.split(':')[0]));
	const leaveTime=$('#modalLeaveTime').val(); //시간 값
	const leaveTimeDate=new Date(comDate); //Date객체로 만들기
	leaveTimeDate.setHours(parseInt(leaveTime.split(':')[0]));
	leaveTimeDate.setMinutes(parseInt(leaveTime.split(':')[0]));

	const requestCommuting={
		commutingNo:commutingNo,
		status:status,
		goTime:goTimeDate,
		leaveTime:leaveTimeDate
	}

	fetch(path+'/api/hr/updateCommuting',{
		method:'POST',
		headers:{
			'Content-Type':'application/json'
		},
		body:JSON.stringify(requestCommuting)
	})
	.then(response=>response.text())
	.then(data=>{
		alert(data);
		searchEmpCommuting(1);
	})
	.catch(error=>{
		console.log(error);
	})
}

//모달창에 데이터 띄우기
$(document).on('click', '#updateModal', e=>{
	const commutingNo=$(e.target).data('com-no');
	const date=$(e.target).parent().siblings().eq(0).text();
	const empNo=$(e.target).parent().siblings().eq(1).text();
	const dept=$(e.target).parent().siblings().eq(2).text();
	const position=$(e.target).parent().siblings().eq(3).text();
	const empName=$(e.target).parent().siblings().eq(4).text();
	const goTime=$(e.target).parent().siblings().eq(5).text().split(" ")[1];
	const leaveTime=$(e.target).parent().siblings().eq(6).text().split(" ")[1];
	const status=$(e.target).parent().siblings().eq(9).text();

	$('#modalCommutingNo').val(commutingNo);
	$('#modalEmpNo').html('').text(empNo);
	$('#modalEmpDept').html('').text(dept);
	$('#modalEmpName').html('').text(empName);
	$('#modalEmpPosition').html('').text(position);
	$('#modalComDate').html('').text(date);
	$('#modalGoTime').val(goTime);
	$('#modalLeaveTime').val(leaveTime);
	$('#modalStatus').val(status);
});

//삭제 함수
function deleteCommuting(no){

	fetch(path+'/api/hr/deleteCommuting',{
		method:'POST',
		headers:{
			'Content-Type':'application/json'
		},
		body:JSON.stringify(no)
	})
	.then(response=>response.text())
	.then(data=>{
		alert(data);
		searchEmpCommuting(1);
	})
	.catch(error=>{
		console.log(error);
	})
}

//검색 함수
function searchEmpCommuting(cPage){
	const $form=$('#searchForm').get(0);

	const fd=new FormData($form);

	//쿼리스트링 만들기
	const query=new URLSearchParams();
	query.append("cPage", cPage);
	for(const pair of fd.entries()){
		if(pair[1]!=null&&pair[1]!=''){
			query.append(pair[0], pair[1]);
		}
	}

	fetch(path+`/api/hr/selectAllEmpCommuting?${query.toString()}`)
	.then(response=>response.json())
	.then(data=>{
		console.log(data);
		makeCommutingTable(data.commutings);

		const $pageBar=createPagination(cPage, data.totalPage, 'searchEmpCommuting');
		$('.pagebar-div').html('').append($pageBar);
	})
	.catch(error=>{
		console.log(error);
	})
}

//테이블 만드는 함수
function makeCommutingTable(commutings){
	const option={ hour: '2-digit', minute: '2-digit', hours12: false}; //시간 포맷 옵션
	$('.com-table tbody').html('');
	commutings.forEach(e=>{
		const $tr=$('<tr>');
		const $comDate=$('<td>').text(e.commutingDate);
		const $empNo=$('<td>').text(e.employeeNo);
		const $dept=$('<td>').text(e.departmentTitle);
		const $position=$('<td>').text(e.positionTitle);
		const $empName=$('<td>').text(e.employeeName);
		const $goTime=$('<td>').text(e.commutingGoWorkTime==null?'-':new Date(e.commutingGoWorkTime).toLocaleTimeString('ko-kr',option));
		const $leaveTime=$('<td>').text(e.commutingLeaveWorkTime==null?'-':new Date(e.commutingLeaveWorkTime).toLocaleTimeString('ko-kr',option));
		const $exTime=$('<td>').text(e.totalExWorkTime==null?'':e.totalExWorkTime);
		const $totalTime=$('<td>').text(e.totalWorkTime==null?'':e.totalWorkTime);
		const $status=$('<td>').text(e.commutingStatus);
		const $updateBtn=$('<button>').text('수정').addClass('btn btn-primary mr-1')
							.attr('data-bs-toggle', 'modal').attr('data-bs-target', '#update-modal').attr('data-com-no', e.commutingNo)
							.attr('id', 'updateModal');
		const $deleteBtn=$('<button>').text('삭제').addClass('btn btn-danger').attr('onclick', `deleteCommuting(${e.commutingNo})`);
		const $btnTd=$('<td>').append($updateBtn).append($deleteBtn);

		$tr.append($comDate).append($empNo).append($dept).append($position).append($empName).append($goTime).append($leaveTime)
			.append($exTime).append($totalTime).append($status).append($btnTd);
		$('.com-table tbody').append($tr);
	});
};

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