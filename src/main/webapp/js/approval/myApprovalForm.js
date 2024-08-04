/*
	문서함 용 js~
*/

//임시저장문서 삭제 함수
function deleteApproval(approvalNo){
	
	fetch(path+'/api/approval/deleteApproval',{
		method:'POST',
		body:approvalNo
	})
	.then(response=>response.text())
	.then(data=>{
		alert(data);
		location.reload();
	})
	.catch(error=>{
		console.log('deleteApproval 오류:'+error);
	})
}