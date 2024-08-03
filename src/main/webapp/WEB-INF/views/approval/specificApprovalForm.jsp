<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/approval/specificApprovalForm.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
                            <td></td>
                        </tr>
                        <tr>
                            <th>정정 타입</th>
                            <td></td>
                        </tr>
                        <tr>
                            <th>정정 시간</th>
                            <td></td>
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
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script>
	const path ="${path}";
	const type = '${appType}';
	let approvalInfo, references, approvers;
	try {
	    approvalInfo = JSON.parse('${approvalInfo}'.replace(/&quot;/g, '"'));
	    references = JSON.parse('${references}'.replace(/&quot;/g, '"'));
	    approvers = JSON.parse('${approvers}'.replace(/&quot;/g, '"'));
	} catch (error) {
	    console.error("JSON 파싱 오류:", error);
	}
	const approvalNo = approvalInfo[0].approval.approvalNo;

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
	if(type==4){
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
	} else if(type==3){

	}
</script>
</html>
