/*
	전체결재 페이지용 js~
*/

$(document).ready(()=>{
	//문서 종류별 개수 가져오기
	getApprovalCountAndList(1);
});

function getApprovalCountAndList(cPage){
	const no=$('#header-empNo').data('employeeNo');

	fetch(path+'/api/approval/getApprovalsCountAndList?no='+no)
	.then(response=>response.json())
	.then(data=>{
		console.log(data);
		//결재 카운트들 태그에 값 넣기
		makeCountText(data.rac);
	})
	.catch(error=>{
		console.log(error);
	});
};

//결재 카운트들 태그 만들기~
function makeCountText(rac){
	$('.approvalStatusTable span').eq(0).text(rac.waitCount);
	$('.approvalStatusTable span').eq(1).text(rac.processCount);
	$('.approvalStatusTable span').eq(2).text(rac.pendingCount);
	$('.approvalStatusTable span').eq(3).text(rac.completeCount);
}