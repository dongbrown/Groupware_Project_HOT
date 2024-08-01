/*
	메인페이지 js~
*/

$(document).ready(()=>{
	checkAttStatus();

});

function checkAttStatus(){
	//오늘 출근 했는지 체크해서 출근 버튼 활성화 여부 판단
	const currHour=new Date().getHours();
	fetch(path+'/api/employee/attendanceStatus')
	.then(response=>response.text())
	.then(data=>{
		if(data=='go'){
			//출근한 상태, 퇴근은 안함 - 출근버튼 비활성화, 퇴근버튼 활성화
			$('.btn-go-work').prop('disabled', true);
			$('.btn-leave-work').prop('disabled', false);
		}else if(data=='leave'){
			//퇴근 한 상태 - 출근버튼 비활성화, 퇴근버튼 비활성화
			$('.btn-go-work').prop('disabled', true);
			$('.btn-leave-work').prop('disabled', true);
		}else if(currHour<=7||currHour>=15){
			//8시 이전, 15시 이후 출근 버튼 비활성화
			$('.btn-go-work').prop('disabled', true);
			$('.btn-leave-work').prop('disabled', true);
		}else{
			//출근, 퇴근 안 한 상태(출근 안함)
			$('.btn-go-work').prop('disabled', false);
			$('.btn-leave-work').prop('disabled', true);
		}
	})
	.catch(error=>{
		console.log(error.message);
	})
}

function goWork(){
	//출근 버튼 눌러 출근~
	fetch(path+'/api/employee/goWork',{
		method:'POST',
		headers:{
			'Content-Type':'application/json'
		},
		body:JSON.stringify({no})
	})
	.then(response=>response.text())
	.then(data=>{
		console.log(data);
		location.reload();
	})
	.catch(error=>{
		console.log(error.message);
	})
}

function leaveWork(){
	//퇴근 버튼을 눌러 퇴근
	fetch(path+'/api/employee/leaveWork',{
		method:'POST',
		headers:{
			'Content-Type':'application/json'
		},
		body:JSON.stringify({no})
	})
	.then(response=>response.text())
	.then(data=>{
		console.log(data);
		location.reload();
	})
	.catch(error=>{
		console.log(error.message);
	})
}

$('.changeBtn').click(e=>{
    $('.card__giratorio-conteudo').toggleClass('is-flipped');
});

/*켈린더 스크립트 문 */
 $(document).ready(function() {
    const weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    let currentDate = new Date();
     let today = new Date();

    function updateCalendar() {
        const year = currentDate.getFullYear();
        const month = currentDate.getMonth();

        $('#current-month').text(new Date(year, month).toLocaleString('default', { month: 'long', year: 'numeric' }));

        const firstDay = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);
        const daysInMonth = lastDay.getDate();
        const startingDay = firstDay.getDay();

        let calendarHTML = '';
        let day = 1;

        for (let i = 0; i < 42; i++) {
            if (i < startingDay || day > daysInMonth) {
                calendarHTML += '<div class="calendar-cell other-month"></div>';
            } else {
				// 오늘 날짜인지 확인
                const isToday = (year === today.getFullYear() && month === today.getMonth() && day === today.getDate());

                // 오늘 날짜에 selected 클래스 추가
                const selectedClass = isToday ? 'selected' : '';

                calendarHTML += `<div class="calendar-cell ${selectedClass}" data-date="${year}-${month+1}-${day}">${day}</div>`;
                day++;
            }
        }

        $('#calendar-body').html(calendarHTML);
        $('#weekdays').html(weekdays.map(day => `<div class="weekday">${day}</div>`).join(''));
    }

    updateCalendar();

    $('#prev-month').click(function() {
        currentDate.setMonth(currentDate.getMonth() - 1);
        updateCalendar();
    });

    $('#next-month').click(function() {
        currentDate.setMonth(currentDate.getMonth() + 1);
        updateCalendar();
    });

    $(document).on('click', '.calendar-cell', function() {
        $('.calendar-cell').removeClass('selected');
        $(this).addClass('selected');
    });
});

//커뮤니티 목록 ajax로 출력
	fetch(path+'/index/communityList.do')
		.then(response=>response.json())
		.then(data=>{
			data.forEach(e=>{
				$wrapTr=$('<tr>');
				$comuNoTh=$('<th>',{scope:'row'}).text(e.communityNo);
				$comuTd=$('<td>').text(e.communityTitle);
				$infoTd=$('<td>').text(e.communityIntroduce);
				$wrapTr.append($comuNoTh).append($comuTd).append($infoTd);
				$wrapTr.appendTo($('#comuList'));
			});

		})
		.catch(error => {
					console.error('요청 실패:', error); // 요청 실패 시 에러 처리
		});


