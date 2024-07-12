/*
	메인페이지 js~
*/

$(document).ready(()=>{
	checkAttStatus();
	
});

function workTime(){
	const currHour=new Date().getHours();
	if(currHour<8||currHour>=15){
		//8시 전 출근 버튼 비활성화
		$('.btn-go-work').prop('disabled', true);
	}
}

function checkAttStatus(){
	//오늘 출근 했는지 체크해서 출근 버튼 활성화 여부 판단
	fetch(path+'/api/attendanceStatus')
	.then(response=>response.json())
	.then(data=>{
		if(data.status){
			//출근한 상태 - 출근버튼 비활성화, 퇴근버튼 활성화
			$('.btn-go-work').prop('disabled', true);
			$('.btn-leave-work').prop('disabled', false);
		}else{
			//출근 안 한 상태 - 출근버튼 활성화, 퇴근버튼 비활성화
			$('.btn-go-work').prop('disabled', false);
			$('.btn-leave-work').prop('disabled', true);
		}
		workTime();
	})
	.catch(error=>{
		console.log(error.message);
	})
}

function goWork(){
	//출근 버튼 눌러 출근~
	fetch(path+'/api/goWork')
	.then(response=>response.text())
	.then(data=>{
		console.log(data);
	})
	.catch(error=>{
		console.log(error.message);
	})
}

function leaveWork(){
	//퇴근 버튼을 눌러 퇴근
	fetch(path+'/api/leaveWork')
	.then(response=>response.text())
	.then(data=>{
		console.log(data);
	})
	.catch(error=>{
		console.log(error.message);
	})
}