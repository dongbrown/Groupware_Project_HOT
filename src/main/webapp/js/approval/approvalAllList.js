/*
	전체결재 페이지용 js~
*/

$(document).ready(()=>{
	//문서 종류별 개수 가져오기
	getApprovalCountAndList(1);
});

$("#selectType").on("change", e=>{
	const approvalType=e.target.value;
});

function getApprovalCountAndList(cPage){
<<<<<<< HEAD
	const no=$('#header-empNo').data('employeeNo');
=======
	const no=$('#header-empNo').data('employee-no');
	//$('#header-empNo').data('employeeNo');
>>>>>>> dev

	fetch(path+'/api/approval/getApprovalsCountAndList?no='+no)
	.then(response=>response.json())
	.then(data=>{
		const $pageBar=createPagination(cPage,data.totalPage,'getApprovalCountAndList');
		$("#pagebar-div").append($pageBar);
		//결재 카운트들 태그에 값 넣기
		makeCountText(data.rac);
		// 각 Data 태그에 넣어주기
		let dataArray = Array.from(data.approvals);
		// Target Table에 해당되는 정보 append
		const $body=$("#approvalBody");
		if(data.approvals)
		dataArray.forEach((d)=>{
			let type;
			let status;
			switch(d.approvalNo.slice(0,1)){
				case '1': type="근태수정"; break;
				case '2': type="휴가"; break;
				case '3': type="초과근무"; break;
				case '4': type="경비지출"; break;
				case '5': type="출장신청"; break;
			}
			switch(d.approvalStatus){
				case 1: status="대기"; break;
				case 2: status="진행"; break;
				case 3: status="완료"; break;
				case 4: status="반려"; break;
			}
			const $tr=$("<tr>");
			const $appNo=$("<td>").text(d.approvalNo);
			const $appType=$("<td>").text(type);
			const $appTitle=$("<td>").text(d.approvalTitle);
			const $appEmp=$("<td>").text(d.employeeNo.employeeName);
			const $appDept=$("<td>").text(d.employeeNo.departmentCode.departmentTitle);
			const $appDate=$("<td>").text(d.approvalDate);
			const $approverDate=$("<td>").text(d.approvers[0].approverDate==null?"-":d.approvers[0].approverDate);
			const $approverStatus=$("<td>").text(status);
			$tr.append($appNo).append($appType).append($appTitle).append($appEmp).append($appDept).append($appDate).append($approverDate).append($approverStatus);
			$body.append($tr);

		});
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