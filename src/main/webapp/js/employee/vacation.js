/*
	개인 휴가 페이지용 js~
*/

$(document).ready(()=>{
	const month=new Date().getMonth()+1;
	makeMonthOption(month);
	vacationList(1);
});

$('.month-select').change(e=>{
	vacationList(1);
});

function vacationList(cPage){
	const month=$('.month-select').val();
	const no=$('#header-empNo').data('employee-no');
	fetch(path+'/api/employee/selectVacationList/'+no+'?cPage='+cPage+'&month='+month)
	.then(response=>response.json())
	.then(data=>{
		$('.vacation-table tbody').html('');
		makeVacationTable(data.vacations);
		makeVacationCard(data.totalVacationDay, data.employeeTotalVacation);
		const $pagebar=createPagination(cPage, data.totalPage, 'vacationList');
		$('.pagebar-div').html('').append($pagebar);
	})
	.catch(error=>{
		console.log(error);
	})
};

//휴가 내역 테이블 만들기
function makeVacationTable(vacations){
	const $tbody=$('.vacation-table tbody');
	vacations.forEach(v=>{
		const $tr=$('<tr>');
		const $appDate=$('<td>').text(v.approvalDate);
		const $type=$('<td>').text(v.vacationForm.vacationType);
		const $start=$('<td>').text(v.vacationForm.vacationStart);
		const $end=$('<td>').text(v.vacationForm.vacationEnd);
		const $day=$('<td>').text(v.vacationForm.vacationDay);
		$tr.append($appDate).append($type).append($start).append($end).append($day);
		$tbody.append($tr);
	});
};

//휴가 카드 만들기
function makeVacationCard(totalVacationDay, empTotal){
	$('.totalVacation').text(empTotal);
	$('.usedVacation').text(totalVacationDay);
	$('.unusedVacation').text(empTotal-totalVacationDay);
}
// 월 선택 셀렉트태그 옵션 만들기
function makeMonthOption(month){
	for(let i=1;i<=month;i++){
		const $option=$('<option>').val(i).text(i+'월');
		$('.month-select').append($option);
		if(i==month) $('.month-select').val(i);
	}
};