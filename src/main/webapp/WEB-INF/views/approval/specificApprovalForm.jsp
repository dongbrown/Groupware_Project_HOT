<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<c:import url="/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/approval/specificApprovalForm.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<section>
    <div class="approval-detail-container">
        <h2>${type }</h2>
        <!-- 공통 정보 -->
        <div class="common-info">
            <table>
                <tr>
                    <th>기안일</th>
                    <td id="approvalDate"></td>
                    <th>제목</th>
                    <td id="approvalTitle"></td>
                </tr>
                <tr>
                    <th>보존연한</th>
                    <td id="approvalPereiod"></td>
                    <th>보안등급</th>
                    <td id="approvalSecurity"></td>
                </tr>
                <tr>
                    <th>기안자</th>
                    <td id="approvalName"></td>
                    <th>기안부서</th>
                    <td id="approvalDepartmentTitle"></td>
                </tr>
                <tr>
                    <th>중간결재자</th>
                    <td id="middleApprover"></td>
                    <th>최종결재자</th>
                    <td id="finalApprover"></td>
                </tr>
                <tr>
                    <th>참조자</th>
                    <td id="referencers" colspan="3"></td>
                </tr>
            </table>
        </div>

        <!-- 결재 유형별 특정 정보 -->
        <c:choose>
            <c:when test="${appType==1 }">
                <!-- 출퇴근 정정 결재 -->
                <div class="specific-info">
                    <h3>출퇴근 정정 정보</h3>
                    <table>
                        <tr>
                            <th>정정 일자</th>
                            <td id="commutingWorkDate"></td>
                        </tr>
                        <tr>
                            <th>정정 타입</th>
                            <td id="commutingType"></td>
                        </tr>
                        <tr>
                            <th>정정 시간</th>
                            <td id="commutingEditTime"></td>
                        </tr>
                    </table>
                </div>
            </c:when>
            <c:when test="${appType ==2}">
                <!-- 휴가 결재 -->
                <div class="specific-info">
                    <h3>휴가 정보</h3>
                    <table>
                        <tr>
                            <th>휴가 종류</th>
                            <td id="vacationType"></td>
                        </tr>
                        <tr>
                            <th>휴가 시작일</th>
                            <td id="vacationStart"></td>
                        </tr>
                        <tr>
                            <th>휴가 종료일</th>
                            <td id="vacationEnd"></td>
                        </tr>
                        <tr>
                            <th>비상 연락처</th>
                            <td id="emergencyPhone"></td>
                        </tr>
                    </table>
                </div>
            </c:when>
            <c:when test="${appType==3 }">
                <!-- 초과근무 결재 -->
                <div class="specific-info">
                    <h3>초과근무 정보</h3>
                    <table>
                        <tr>
                            <th>초과 근무일</th>
                            <td id="overtimeDate"></td>
                        </tr>
                        <tr>
                            <th>초과 근무 시작시간</th>
                            <td id="overtimeStartTime"></td>
                        </tr>
                        <tr>
                            <th>초과 근무 종료시간</th>
                            <td id="overtimeEndTime"></td>
                        </tr>
                    </table>
                </div>
            </c:when>
            <c:when test="${appType==4 }">
                <!-- 경비지출 결재 -->
                <div class="specific-info">
                    <h3>지출 품목 정보</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>품명</th>
                                <th>규격</th>
                                <th>단위</th>
                                <th>수량</th>
                                <th>단가</th>
                                <th>금액</th>
                                <th>비고</th>
                            </tr>
                        </thead>
                        <tbody id="expenditureItems">

                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:when test="${appType==5 }">
                <!-- 출장 결재 -->
                <div class="specific-info">
                    <h3>출장 정보</h3>
                    <table>
                        <tr>
                            <th>출장 시작일</th>
                            <td id="businessStart"></td>
                        </tr>
                        <tr>
                            <th>출장 종료일</th>
                            <td id="businessEnd"></td>
                        </tr>
                        <tr>
                            <th>출장지</th>
                            <td id="businessDestination"></td>
                        </tr>
                        <tr>
                            <th>비상연락처</th>
                            <td id="businessEmergency"></td>
                        </tr>
                        <tr id="partners">
                            <th>동행자</th>

                        </tr>
                    </table>
                </div>
            </c:when>
        </c:choose>

        <!-- 결재 내용 -->
        <div class="approval-content">
            <h3>결재 내용</h3>
            <p id="approvalContent">
            </p>
        </div>

        <!-- 첨부 파일 -->
        <div class="attachments">
            <h3>첨부 파일</h3>
            <ul id="attachmentsAtt">
            </ul>
        </div>
    </div>
</section>
<div class="modal fade" tabindex="-1" id="approval-modal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">결재</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="form-check">
					<input class="form-check-input" type="radio" name="decision"
						id="approve" value="1" checked> <label
						class="form-check-label" for="approve"> 승인 </label>
				</div>
				<div class="form-check">
					<input class="form-check-input" type="radio" name="decision"
						id="reject" value="2"> <label
						class="form-check-label" for="reject"> 반려 </label>
				</div>
				<div class="form-check direct-decision">
					<input class="form-check-input" type="radio" name="decision"
						id="finalize" value="3"> <label
						class="form-check-label" for="finalize"> 전결 </label>
				</div>
				<div class="comment-group" id="comment-group">
					<label for="comment">반려 사유</label>
					<textarea id="comment" name="comment" rows="4" cols="50"></textarea>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary approval-btn">결재</button>
			</div>
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script>
	const path ="${path}";
	const type = '${appType}';
	let approvalInfo, references, approvers, approverNo, approverStatus, approverDate;
	try {
	    approvalInfo = JSON.parse('${approvalInfo}'.replace(/&quot;/g, '"'));
	    references = JSON.parse('${references}'.replace(/&quot;/g, '"'));
	    approvers = JSON.parse('${approvers}'.replace(/&quot;/g, '"'));
	    approverNo = JSON.parse('${approverNo}'.replace(/&quot;/g, '"'));
	    approverStatus = JSON.parse('${approverStatus}'.replace(/&quot;/g, '"'));
	    approverDate = JSON.parse('${approverDate}'.replace(/&quot;/g, '"'));
	} catch (error) {
	    console.error("JSON 파싱 오류:", error);
	}
	const approvalNo = approvalInfo[0].approval.approvalNo;
	const info = approvalInfo[0];
	
	/* 결재 문서 공통 부분 출력 */
    $("#approvalName").append(approvalInfo[0].approval.employeeNo.employeeName);
    $("#approvalDepartmentTitle").append(approvalInfo[0].approval.employeeNo.departmentCode.departmentTitle);
	$("#referencers").append(references.join(', '));
	$("#finalApprover").append(approvers[2]);
	$("#middleApprover").append(approvers[1]);
	$("#approvalPereiod").append(approvalInfo[0].approval.approvalPeriod);
	$("#approvalSecurity").append(approvalInfo[0].approval.approvalSecurity);
	$("#approvalTitle").append(approvalInfo[0].approval.approvalTitle);
	$("#approvalDate").append(approvalInfo[0].approval.approvalDate);
	$("#approvalContent").append(approvalInfo[0].approval.approvalContent==null?"내용 없음":approvalInfo[0].approval.approvalContent);
	const atts = approvalInfo[0].atts;
	atts.forEach(att=>{
		$("#attachmentsAtt").append($("<li>").append($("<a>").attr("href", path+'/upload/approval/'+att.approvalAttRenameFilename).attr("download", att.approvalAttOriginalFilename).append(att.approvalAttOriginalFilename)))
	})
	/* 문서 종류 별 출력 */
	if(type==1){
		$("#commutingWorkDate").append(info.ctf.commutingWorkDate);
		$("#commutingType").append(info.ctf.commutingType);
		$("#commutingEditTime").append(info.ctf.commutingEditTime.split('T')[1]);
	} else if(type==2){
		 $("#vacationType").append(info.vf.vacationType+"휴가");
		 $("#vacationStart").append(info.vf.vacationStart);
		 $("#vacationEnd").append(info.vf.vacationEnd);
		 $("#emergencyPhone").append(info.vf.vacationEmergency);
	} else if(type==3){
	     $("#overtimeDate").append(info.otf.overtimeDate);
	     $("#overtimeStartTime").append((info.otf.overtimeStartTime).split('T')[1]);
	     $("#overtimeEndTime").append((info.otf.overtimeEndTime).split('T')[1]);
	} else if(type==4){
		const edi = approvalInfo[0].edi;
		const edf = approvalInfo[0].edf;
		edi.forEach(p =>{
			$("#expenditureItems").append(
					$("<tr>").append($("<td>").append(p.expenditureName)).append($("<td>").append(p.expenditureSpec==null?"없음":p.expenditureUnit))
					.append($("<td>").append(p.expenditureUnit==null?"없음":p.expenditureUnit)).append($("<td>").append(p.expenditureQuantity))
					.append($("<td>").append(p.expenditurePrice)).append($("<td>").append(parseInt(p.expenditureQuantity)*parseInt(p.expenditurePrice)))
					.append($("<td>").append(p.expenditureRemark))
			)
		})
	} else if(type==5) {
		$("#businessStart").append(info.btf.businessTripStartDate);
		$("#businessEnd").append(info.btf.businessTripEndDate);
		$("#businessDestination").append(info.btf.businessTripDestination);
		$("#businessEmergency").append(info.btf.businessTripEmergency);
		const partners = info.btf.businessTripPartners[0].employeeNo
		$("#partners").append($("<td>").append(partners.employeeName));
	}
	
	$(document).ready(function() {
		//결재자 결재 버튼 생성
		const loginEmployeeNo=$('#header-empNo').data('employee-no');
		const $button=$('<button>').addClass('btn btn-primary ml-2').attr('data-bs-toggle', 'modal').attr('data-bs-target', '#approval-modal').text('결재');
		
		//결재 상태 확인 하여 결재상태, 결재일 띄우기
		//중간 결재자
		if(approverStatus[1] == 1 ){
			$("#middleApprover").append($('<img>').attr('src',path+'/images/check.png')).append('승인').append('('+approverDate[1]+')');
		}else if(approverStatus[1] == 3){
			$("#middleApprover").append($('<img>').attr('src',path+'/images/check.png')).append('전결').append('('+approverDate[1]+')');
		}else if(approverStatus[1] == 2){
			$("#middleApprover").append($('<img>').attr('src',path+'/images/x.png')).append('반려').append('('+approverDate[1]+')');
		}
		//마지막 결재자
		if(approverStatus[2] == 1 ){
			$("#finalApprover").append($('<img>').attr('src',path+'/images/check.png')).append('승인').append('('+approverDate[2]+')');
		}else if(approverStatus[2] == 3){
			$("#finalApprover").append($('<img>').attr('src',path+'/images/check.png')).append('전결').append('('+approverDate[2]+')');
		}else if(approverStatus[2] == 2){
			$("#finalApprover").append($('<img>').attr('src',path+'/images/x.png')).append('반려').append('('+approverDate[2]+')');
		}
		
		//결재자 결재상태 확인하여 결재버튼 만들기
		if(loginEmployeeNo == approverNo[1] && approverStatus[1] == 4){
			//중간 결재자
			$("#middleApprover").append($button);
		}
		if(loginEmployeeNo == approverNo[2] && approverStatus[1] == 1 && approverStatus[2] == 4){
			//마지막 결재자
			$("#finalApprover").append($button);
		}
		
		//반려사유는 반려가 체크되었을 때에만 띄우기
		$('#comment-group').hide()
		$('input[name="decision"]').change(function() {
	        // '반려' 값이 체크되었는지 확인
	        if ($('input[name="decision"]:checked').val() === '2') {
	            $('#comment-group').show();  // '반려'가 선택되었으면 텍스트 영역을 보이게 함
	        } else {
	            $('#comment-group').hide();   // 다른 값이 선택되었으면 텍스트 영역을 숨김
	            $('#comment').val('');
	        }
	    });
		
		$('.approval-btn').click(approval);
		if(loginEmployeeNo == approverNo[2]){
			$('.direct-decision').remove(); // 마지막 결재자는 전결 체크옵션 지우기
		}
	});
	
	
	//결재하기 함수
	function approval(){
		const newApproverStatus=$('input[name="decision"]:checked').val();
		const loginEmployeeNo=$('#header-empNo').data('employee-no');
		let level;
		if(loginEmployeeNo == approverNo[1]){
			level = 1;
		}else{
			level = 2;
		}
		
		const approverReject=$('#comment').val();
		const approverData={
				approverStatus:newApproverStatus,
				approverReject:approverReject,
				approvalNo:approvalNo,
				level:level,
				employeeNo:loginEmployeeNo
		}
		
		fetch(path+'/api/approval/updateApprovalStatus',{
			method:'POST',
			headers:{
				'Content-Type':'application/json'
			},
			body:JSON.stringify(approverData)
		})
		.then(response=>response.text())
		.then(data=>{
			console.log(data);
			alert(data);
			location.reload();
		})
		.catch(error=>{
			console.log(error);
		})
	}
</script>
<c:import url="/WEB-INF/views/common/footer.jsp"/>