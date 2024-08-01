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
		console.log(data);
	})
	.catch(error=>{
		console.log(error);
	})
}

// 월 선택 셀렉트태그 옵션 만들기
function makeMonthOption(month){
	for(let i=1;i<=month;i++){
		const $option=$('<option>').val(i).text(i+'월');
		$('.month-select').append($option);
		if(i==month) $('.month-select').val(i);
	}
};