/*
	전체결재 페이지용 js~
*/

$(document).ready(()=>{
	//문서 종류별 개수 가져오기
	getApprovalsCount();
});

function getApprovalsCountAndList(){
	const no=data(employee-no);

	fetch(path+'/api/approval/getApprovalsCountAndList?no='+no)
	.then(response=>response.json())
	.then(data=>{
		console.log(data);
	})
	.catch(error=>{
		console.log(error);
	});
};