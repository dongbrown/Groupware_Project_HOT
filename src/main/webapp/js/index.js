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
		if(data=='go'||(currHour<8||currHour>=15)){
			//출근한 상태, 퇴근은 안함 - 출근버튼 비활성화, 퇴근버튼 활성화
			$('.btn-go-work').prop('disabled', true);
			$('.btn-leave-work').prop('disabled', false);
		}else if(data=='leave'){
			//퇴근 한 상태 - 출근버튼 비활성화, 퇴근버튼 비활성화
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