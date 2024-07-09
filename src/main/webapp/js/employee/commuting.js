/*
	출퇴근 페이지용 js~
*/

$(document).ready(()=>{
	const month=new Date().getMonth()+1;
	makeMonthOption(month);
	commutingList(1, no, month);
});

// 출퇴근 정보 가져오기
function commutingList(cPage, no, month){
	const url=path+'/api/commutingList?cPage='+cPage+'&employeeNo=' + no + '&month=' + month;
	fetch(url)
	.then(response=>response.json())
	.then(data=>{
		console.log(data);
		makeCommutingPage(data.commutings);
		const $pagebar=createPagination(cPage, data.totalPage, 'commutingList');
		$('.pagebar-div').append($pagebar);
	})
	.catch(error => {
		console.error('요청 실패:', error); // 요청 실패 시 에러 처리
	})
}

// 출퇴근 페이지 화면 구성
function makeCommutingPage(commutings){
	let workDays;
	let totalWorkTime;
}

// 출퇴근 테이블 월 선택 셀렉트태그 옵션 만들기
function makeMonthOption(month){
	for(let i=1;i<=month;i++){
		const $option=$('<option>').val(i).text(i+'월');
		$('.month-select').append($option);
		if(i==month) $('.month-select').val(i);
	}
}