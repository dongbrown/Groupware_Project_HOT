/*
	출퇴근 페이지용 js~
*/

$(document).ready(()=>{
	const month=new Date().getMonth()+1;
	makeMonthOption(month);
	commutingList(1);
});

$('.month-select').change(e=>{
	commutingList(1);
})

// 출퇴근 정보 가져오기
function commutingList(cPage){
	const month=$('.month-select').val();
	const url=path+'/api/employee/commuting/'+no+'?cPage='+cPage+'&month=' + month;
	fetch(url)
	.then(response=>response.json())
	.then(data=>{
		console.log(data);
		makeCommutingTable(data.commutings);
		makeCommutingCard(data.responseCommuting);
		const $pagebar=createPagination(cPage, data.totalPage, 'commutingList');
		$('.pagebar-div').html('').append($pagebar);
	})
	.catch(error => {
		console.error('요청 실패:', error); // 요청 실패 시 에러 처리
	})
}

// 출퇴근 페이지 테이블 생성
function makeCommutingTable(commutings){
	const option={ hour: '2-digit', minute: '2-digit', hours12: false};
	$('#commuting-table tbody').html('');
	commutings.forEach(e=>{
		if(new Date(e.commutingDate).getMonth()+1 == $('.month-select').val()){
			const $tr=$('<tr>');
			const $day=$('<td>').text(e.commutingDate.split("T")[0]).attr('scope','col');
			let $goWork=$('<td>');
			if(e.commutingGoWorkTime == null){
				$goWork=$('<td>').text('-');
			}else{
				$goWork=$('<td>').text(new Date(e.commutingGoWorkTime).toLocaleTimeString('ko-kr',option));
			}
			let $leaveWork=$('<td>');
			if(e.commutingLeaveWorkTime == null){
				$leaveWork=$('<td>').text('-');
			}else{
				$leaveWork=$('<td>').text(new Date(e.commutingLeaveWorkTime).toLocaleTimeString('ko-kr',option));
			}
			const $status=$('<td>').text(e.commutingStatus);
			$tr.append($day).append($goWork).append($leaveWork).append($status);
			$('#commuting-table tbody').append($tr);
		}
	})
}

// 출퇴근 페이지 상단 카드 생성
function makeCommutingCard(commuting){
	const option={ hour: '2-digit', minute: '2-digit', hours12: false};
	const month=$('.month-select').val();
	$('.work-title').text(month+'월 근무 현황');
	$('.att-title').text(month+'월 근태 현황');

	//출근 시간
	let goWork='';
	if(commuting.todayGoWorkTime == null){
		goWork='-';
	}else{
		goWork=new Date(commuting.todayGoWorkTime).toLocaleTimeString('ko-kr', option);
	}
	const $goWorkTime=$('<span>').text(goWork);

	//퇴근 시간
	let leaveWork='';
	if(commuting.todayLeaveWorkTime == null){
		leaveWork='-';
	}else{
		leaveWork=new Date(commuting.todayLeaveWorkTime).toLocaleTimeString('ko-kr', option);
	}
	const $leaveWork=$('<span>').text(leaveWork);
	$('.work-time').html('').append($goWorkTime).append($leaveWork);

	//근무 일수
	const $totalWorkDay=$('<span>').text(commuting.totalWorkDay+'시간');
	//연장 근무 시간
	const $totalExWorkTime=$('<span>').text(commuting.totalExWorkTime+'시간');
	//총 근무 시간
	const $totalWorkTime=$('<span>').text(commuting.totalWorkTime+'시간');
	$('.total-work').html('').append($totalWorkDay).append($totalExWorkTime).append($totalWorkTime);

	//지각 횟수
	const $tardy=$('<span>').text(commuting.tardy+'회');
	//결근 횟수
	const $absence=$('<span>').text(commuting.absence+'회');
	//연차 횟수
	const $annual=$('<span>').text(commuting.annual+'회');
	$('.att-count').html('').append($tardy).append($absence).append($annual);
}

// 출퇴근 테이블 월 선택 셀렉트태그 옵션 만들기
function makeMonthOption(month){
	for(let i=1;i<=month;i++){
		const $option=$('<option>').val(i).text(i+'월');
		$('.month-select').append($option);
		if(i==month) $('.month-select').val(i);
	}
}