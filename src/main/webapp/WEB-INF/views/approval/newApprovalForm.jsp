<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    LocalDate currentDate = LocalDate.now();
    String formattedDate = currentDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
    request.setAttribute("currentDate", formattedDate);
%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />
<c:set var="approval" value="${com.project.hot.approval.model.dto.Approval}" />

<c:import url="${path }/WEB-INF/views/common/sidebar.jsp" />
<c:import url="${path }/WEB-INF/views/common/header.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<title>결재신청서</title>



<style>

	html, body {
		height: 100%;
		margin: 0;
		padding: 0;
	}

	.page-container {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}

	.content-container {
		display: flex;
		flex: 1;
		overflow: hidden;
	}

	.left-section {
		width: 25%;
		padding: 20px;
		box-sizing: border-box;
		overflow-y: auto;
		border-right: 1px solid #ddd;
	}

	.right-section {
		width: 75%;
		padding: 20px;
		box-sizing: border-box;
		overflow-y: auto;
	}

	.form-container {
		display: none;
		padding: 20px;
		background-color: #f9f9f9;
		border: 1px solid #ddd;
		border-radius: 5px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		margin-bottom: 20px;
	}

	.form-container h5 {
		font-weight: bold;
		margin-bottom: 20px;
		color: #333;
	}


	.form-control {
		font-size: 0.9rem; /* 폼 컨트롤의 폰트 크기 조정 */
	}

	.approval-line {
	    display: flex;
	    justify-content: flex-end; /* 오른쪽 정렬 */
	    margin-bottom: 20px;
	}

	.approval-box {
	    flex: 0 0 auto; /* 크기를 고정 */
	    width: 200px; /* 너비를 줄임 */
	    padding: 10px;
	    margin-left: 10px; /* 왼쪽에 간격을 줘서 상자 사이에 간격 추가 */
	    background-color: #fff;
	    border: 1px solid #ddd;
	}

	.approval-box h5 {
	    text-align: center; /* 제목을 가운데 정렬 */
	    margin-bottom: 10px; /* 제목 아래에 간격 추가 */
	}

	.approval-content p {
	    margin: 5px 0; /* 문단 사이에 간격 추가 */
	    text-align: center;
	}

	.button-container {
		display: flex;
		justify-content: center;
		margin-top: 10px; /* 필요한 경우 마진 조정 */
	}

	.button-container button {
		margin-left: 10px; /* 버튼 간의 간격 조정 */
	}

	#itemTable, #infoTable {
		margin: 0 auto; /* 테이블을 가운데 정렬 */
		border-collapse: collapse; /* 테이블 테두리 겹치지 않도록 설정 */
		width: 100%; /* 테이블이 전체 너비를 차지하도록 설정 */
	}

	#itemTable th, #itemTable td , #infoTable th, #infoTable td{
		text-align: center; /* 테이블 셀 가운데 정렬 */
		vertical-align: middle; /* 셀 세로 가운데 정렬 */
		border: 1px solid #dddddd; /* 테이블 셀에 테두리 추가 */
		padding: 8px; /* 테이블 셀에 패딩 추가 */
		background-color: #fff; /* 테이블 셀 배경색 흰색으로 설정 */
		width: 16.67%;
	}

	#itemTable th, #infoTable th {
		background-color: #f2f2f2; /* 테이블 헤더 배경색 연한 회색으로 설정 */
		font-weight: bold; /* 테이블 헤더 글씨체 굵게 설정 */
	}

	#itemTable tbody tr:nth-child(even),
	#infoTable tbody tr:nth-child(even){
		background-color: #f9f9f9; /* 짝수 행 배경색 연한 회색으로 설정 */
	}

	#itemTable tbody tr:nth-child(odd),
	#infoTable tbody tr:nth-child(odd){
		background-color: #fff; /* 홀수 행 배경색 흰색으로 설정 */
	}
		/* 특정 셀들의 너비를 조정할 수 있습니다 */
	#itemTable th:nth-child(1), #itemTable td:nth-child(1), /* 기안자 */
	#itemTable th:nth-child(2), #itemTable td:nth-child(2), /* 부서 */
	#itemTable th:nth-child(3), #itemTable td:nth-child(3), /* 기안자 */
	#infoTable th:nth-child(1), #infoTable td:nth-child(1),
	#infoTable th:nth-child(2), #infoTable td:nth-child(2),
	#infoTable th:nth-child(3), #infoTable td:nth-child(3) {
	    width: 13%;
	}

	#itemTable th:nth-child(4), #itemTable td:nth-child(4), /* 제목 */
	#itemTable th:nth-child(5), #itemTable td:nth-child(5), /* 휴가시작일 */
	#itemTable th:nth-child(6), #itemTable td:nth-child(6), /* 휴가종료일 */
	#infoTable th:nth-child(4), #infoTable td:nth-child(4),
	#infoTable th:nth-child(5), #infoTable td:nth-child(5),
	#infoTable th:nth-child(6), #infoTable td:nth-child(6) {
	    width: 13%;
	}

	#itemTable th:nth-child(7), #itemTable td:nth-child(7), /* 보존연한 */
	#itemTable th:nth-child(8), #itemTable td:nth-child(8), /* 비상연락처 */
	#itemTable th:nth-child(9), #itemTable td:nth-child(9),  /* 참조자 */
	#infoTable th:nth-child(7), #infoTable td:nth-child(7),
	#infoTable th:nth-child(8), #infoTable td:nth-child(8),
	#infoTable th:nth-child(9), #infoTable td:nth-child(9) {
	    width: 13%;
	}

	#itemTable th:nth-child(10), #itemTable td:nth-child(10), /* 파일첨부 */
	#itemTable th:nth-child(11), #itemTable td:nth-child(11), /* 출장내용 */
	#itemTable th:nth-child(12), #itemTable td:nth-child(12), /* 결재상신 버튼 */
	#itemTable th:nth-child(10), #itemTable td:nth-child(10),
	#itemTable th:nth-child(11), #itemTable td:nth-child(11),
	#itemTable th:nth-child(12), #itemTable td:nth-child(12) {
	    width: 13%;
	}


	/* 입력 필드의 너비를 일관되게 조정 */
	#itemTable input[type="text"], #itemTable input[type="date"], #itemTable select,
	#infoTable input[type="text"], #infoTable input[type="date"], #infoTable select
		{
		width: 100%; /* 입력 필드가 테이블 셀의 전체 너비를 차지하도록 설정 */
		box-sizing: border-box; /* 패딩과 테두리를 요소의 총 너비와 높이에 포함 */
	}
</style>

<body>
	<div class="page-container">
		<div>
			<h3>결재 신청서</h3>
		</div>
		<div class="content-container" STYLE="border: 1px solid red">
			<div class="left-section">
				<div class="form-group">
					<label for="formType">전자결재 양식 선택</label> <select id="formType" class="form-control form-control-sm" onchange="showForm()">
						<option value="">양식을 선택하세요</option>
						<option value="form1">출장신청서</option>
						<option value="form2">휴가신청서</option>
						<option value="form3">초과근무신청서</option>
						<option value="form4">경비지출신청서</option>
						<option value="form5">출퇴근정정신청서</option>
					</select>
				</div>


				<div class="form-group">
				    <label for="department">부서 선택</label>
				    <select id="select-dept" class="form-control" onchange="loadEmployees()">
				        <option selected>부서를 선택하세요.</option>
								<c:if test="${not empty departments }">
									<c:forEach var="d" items="${departments }">
										<option value="${d.departmentCode}">${d.departmentTitle}</option>
									</c:forEach>
								</c:if>
				    </select>
				</div>

				<div class="form-group">
					<label for="approver">결재자 선택</label>
					<div class="d-flex justify-content-between align-items-center">
						<select id="approver" class="form-control mr-2" style="width: 70%;">
							<c:if test="${not empty employees}">
								<option value="">선택하세요</option>
								<c:forEach var="employee" items="${employees}">
									<option value="${employee.employeeNo}">${employee.employeeName}</option>
								</c:forEach>
							</c:if>
						</select>
						<button type="button" class="btn btn-primary" onclick="addApprover();">결재자 추가</button>
					</div>
				</div>

				<div class="form-group">
					<label for="referer">참조자 선택</label>
					<div class="d-flex justify-content-between align-items-center">
						<select id="referer" class="form-control mr-2" style="width: 70%;">
							<c:if test="${not empty employees}">
								<option value="">선택하세요</option>
								<c:forEach var="employee" items="${employees}">
									<option value="${employee.employeeNo}">${employee.employeeName}</option>
								</c:forEach>
							</c:if>
						</select>
						<button type="button" class="btn btn-primary" onclick="addReferer();">참조자 추가</button>
					</div>
				</div>
				<button type="button" class="btn btn-danger ml-2" onclick="resetApprovers()">초기화</button>

			</div>

			<div class="right-section">
<!-- 출장신청서 -->
				<div id="form1" class="form-container">
					<h5>출장신청서</h5>
					<form>
						<div class="approval-line">
						    <div id="draftApprover" class="approval-box">
						        <h5 class="approval-title">기안자</h5>
						        <div class="approval-content">
						            <p id="draftDepartment">${loginEmployee.departmentCode.departmentTitle}</p>
						            <p id="draftEmployee">${loginEmployee.employeeName}</p>
						            <p id="draftDate">${currentDate}</p>
						        </div>
						    </div>
						    <div id="middleApprover" class="approval-box">
						        <h5 class="approval-title">중간결재자</h5>
						        <div class="approval-content"></div>
						    </div>
						    <div id="finalApprover" class="approval-box">
						        <h5 class="approval-title">최종결재자</h5>
						        <div class="approval-content"></div>
						    </div>
						</div>
						<form>
							<div class="form-group">
								<label for="documentType">문서종류</label> <select id="documentType"
									class="form-control">
									<option>출장신청서</option>
								</select>
							</div>

							<table id="infoTable">

								<tbody>
									<tr>
										<th>기안자</th>
										<td>${loginEmployee.employeeName}</td>
										<th>부서</th>
										<td>${loginEmployee.departmentCode.departmentTitle}</td>
										<th>기안일</th>
										<td class="draftDate">${currentDate}</td>

									</tr>
									<tr>
										<th>제목</th>
										<td colspan="5"><input type="text" class="form-control"></td>

									</tr>
									<tr>
										<th>출장시작일</th>
										<td><input type="date" id="startDate" class="form-control"></td>
										<th>출장종료일</th><!-- 시작일을 min으로 설정해서 그 이후만 선택가능하게 -->
										<td><input type="date" id="endDate" class="form-control"></td><th>보존연한</th>
										<td><select id="retentionPeriod" class="form-control">
												<option>3 개월</option>
												<option>6 개월</option>
												<option>1 년</option>
												<option>3 년</option>
										</select></td>
									</tr>
									<tr>
										<th>출장지</th>
										<td><input type="text" class="form-control"></td>
										<th>비상연락처</th>
										<td><input type="text" class="form-control"></td>
										<th>동행자</th>
										<td><input type="text" class="form-control"></td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<th>참조자</th>
										<td> <input type="text" id="addReferer" class="form-control" readonly></td>
										<th>파일첨부</th>
										<td colspan="3">
											<div class="input-group">
											    <div class="custom-file">
											        <input type="file" class="custom-file-input file-input" multiple>
											        <label class="custom-file-label">파일 선택</label>
											    </div>
											    <div class="input-group-append">
											        <button type="button" class="btn btn-primary file-select-button">파일 선택</button>
											    </div>
											</div>
										</td>
									</tr>
								</tfoot>

							</table>
							<div class="form-group mt-3">
								<label for="details">출장내용</label>
								<textarea id="details" class="form-control" rows="10"></textarea>
							</div>
							<div class="d-flex justify-content-center">
								<button type="submit" class="btn btn-primary">결재상신</button>
								<button type="button" class="btn btn-secondary ml-2">임시저장</button>
								<button type="button" class="btn btn-danger ml-2">취소</button>
							</div>
						</form>
					</form>
				</div>

<!-- 휴가신청서 -->
				<div id="form2" class="form-container">
					<h5>휴가신청서</h5>
					<form>
						<div class="approval-line">
						    <div id="draftApprover" class="approval-box">
						        <h5 class="approval-title">기안자</h5>
						        <div class="approval-content">
						            <p id="draftDepartment">${loginEmployee.departmentCode.departmentTitle}</p>
						            <p id="draftEmployee">${loginEmployee.employeeName}</p>
						            <p id="draftDate">${currentDate}</p>
						        </div>
						    </div>
						    <div id="middleApprover" class="approval-box">
						        <h5 class="approval-title">중간결재자</h5>
						        <div class="approval-content"></div>
						    </div>
						    <div id="finalApprover" class="approval-box">
						        <h5 class="approval-title">최종결재자</h5>
						        <div class="approval-content"></div>
						    </div>
						</div>
						<form>
							<div class="form-group">
								<label for="documentType">문서종류</label> <select id="documentType"
									class="form-control">
									<option>반차 신청서</option>
									<option>월차 신청서</option>
									<option>연차 신청서</option>
									<option>병가 신청서</option>
									<option>육아 휴직 신청서</option>
									<option>출산 휴가 신청서</option>
								</select>
							</div>

							<table id="infoTable">

								<tbody>
									<tr>
										<th>기안자</th>
										<td>${loginEmployee.employeeName}</td>
										<th>부서</th>
										<td>${loginEmployee.departmentCode.departmentTitle}</td>
										<th>기안일</th>
										<td class="draftDate">${currentDate}</td>

									</tr>
									<tr>
										<th>제목</th>
										<td colspan="5"><input type="text" class="form-control"></td>

									</tr>
									<tr>
										<th>휴가시작일</th>
										<td><input type="date" id="startDate" class="form-control"></td>
										<th>휴가종료일</th><!-- 시작일을 min으로 설정해서 그 이후만 선택가능하게 -->
										<td><input type="date" id="endDate" class="form-control"></td><th>보존연한</th>
										<td><select id="retentionPeriod" class="form-control">
												<option>3 개월</option>
												<option>6 개월</option>
												<option>1 년</option>
												<option>3 년</option>
										</select></td>
									</tr>
									<tr>
										<th>비상연락처</th>
										<td><input type="text" class="form-control"></td>
										<th>참조자</th>
										<td colspan="3"><input type="text" id="addReferer" class="form-control" readonly></td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<th>파일첨부</th>
										<td colspan="5">
											<div class="input-group">
											    <div class="custom-file">
											        <input type="file" class="custom-file-input file-input" multiple>
											        <label class="custom-file-label">파일 선택</label>
											    </div>
											    <div class="input-group-append">
											        <button type="button" class="btn btn-primary file-select-button">파일 선택</button>
											    </div>
											</div>
										</td>
									</tr>
								</tfoot>

							</table>
							<div class="form-group mt-3">
								<label for="details">휴가내용</label>
								<textarea id="details" class="form-control" rows="10"></textarea>
							</div>
							<div class="d-flex justify-content-center">
								<button type="submit" class="btn btn-primary">결재상신</button>
								<button type="button" class="btn btn-secondary ml-2">임시저장</button>
								<button type="button" class="btn btn-danger ml-2">취소</button>
							</div>
						</form>
					</form>
				</div>


<!-- 초과근무신청서 -->
				<div id="form3" class="form-container">
					<h5>초과근무신청서</h5>
					<form>
						<div class="approval-line">
						    <div id="draftApprover" class="approval-box">
						        <h5 class="approval-title">기안자</h5>
						        <div class="approval-content">
						            <p id="draftDepartment">${loginEmployee.departmentCode.departmentTitle}</p>
						            <p id="draftEmployee">${loginEmployee.employeeName}</p>
						            <p id="draftDate">${currentDate}</p>
						        </div>
						    </div>
						    <div id="middleApprover" class="approval-box">
						        <h5 class="approval-title">중간결재자</h5>
						        <div class="approval-content"></div>
						    </div>
						    <div id="finalApprover" class="approval-box">
						        <h5 class="approval-title">최종결재자</h5>
						        <div class="approval-content"></div>
						    </div>
						</div>
						<form>
							<div class="form-group">
								<label for="documentType">문서종류</label> <select id="documentType"
									class="form-control">
									<option>초과근무신청서</option>
								</select>
							</div>

							<table id="infoTable">

								<tbody>
									<tr>
										<th>기안자</th>
										<td>${loginEmployee.employeeName}</td>
										<th>부서</th>
										<td>${loginEmployee.departmentCode.departmentTitle}</td>
										<th>기안일</th>
										<td class="draftDate">${currentDate}</td>

									</tr>
									<tr>
										<th>제목</th>
										<td colspan="5"><input type="text" class="form-control"></td>

									</tr>
									<tr>
										<th>초과근무시작일</th>
										<td><input type="datetime-local" id="form3StartTime" class="form-control"></td>
										<th>초과근무종료일</th><!-- 시작일을 min으로 설정해서 그 이후만 선택가능하게 -->
										<td><input type="datetime-local" id="form3EndTime" class="form-control"></td><th>보존연한</th>
										<td><select id="retentionPeriod" class="form-control">
												<option>3 개월</option>
												<option>6 개월</option>
												<option>1 년</option>
												<option>3 년</option>
										</select></td>
									</tr>
									<tr>
										<th>비상연락처</th>
										<td><input type="text" class="form-control"></td>
										<th>참조자</th>
										<td colspan="3"><input type="text" id="addReferer" class="form-control" readonly></td>
									</tr>
								</tbody>
							</table>
							<div class="form-group mt-3">
								<label for="details">초과근무내용</label>
								<textarea id="details" class="form-control" rows="10"></textarea>
							</div>
							<div class="d-flex justify-content-center">
								<button type="submit" class="btn btn-primary">결재상신</button>
								<button type="button" class="btn btn-secondary ml-2">임시저장</button>
								<button type="button" class="btn btn-danger ml-2">취소</button>
							</div>
						</form>
					</form>
				</div>


<!-- 경비지출신청서 -->
				<div id="form4" class="form-container">
					<h5>경비지출신청서</h5>
					<form>
						<div class="approval-line">
						    <div id="draftApprover" class="approval-box">
						        <h5 class="approval-title">기안자</h5>
						        <div class="approval-content">
						            <p id="draftDepartment">${loginEmployee.departmentCode.departmentTitle}</p>
						            <p id="draftEmployee">${loginEmployee.employeeName}</p>
						            <p id="draftDate">${currentDate}</p>
						        </div>
						    </div>
						    <div id="middleApprover" class="approval-box">
						        <h5 class="approval-title">중간결재자</h5>
						        <div class="approval-content"></div>
						    </div>
						    <div id="finalApprover" class="approval-box">
						        <h5 class="approval-title">최종결재자</h5>
						        <div class="approval-content"></div>
						    </div>
						</div>
						<form>
							<div class="form-group">
								<label for="documentType">문서종류</label> <select id="documentType"
									class="form-control">
									<option>경비지출신청서</option>
								</select>
							</div>

							<table id="infoTable">

								<tbody>
									<tr>
										<th>기안자</th>
										<td>${loginEmployee.employeeName}</td>
										<th>부서</th>
										<td>${loginEmployee.departmentCode.departmentTitle}</td>
										<th>기안일</th>
										<td class="draftDate">${currentDate}</td>

									</tr>
									<tr>
										<th>제목</th>
										<td colspan="5"><input type="text" class="form-control"></td>

									</tr>
									<tr>
										<th>경비지출일</th>
										<td><input type="date" class="form-control"></td>
										<th>보존연한</th>
										<td><select id="retentionPeriod" class="form-control">
												<option>3 개월</option>
												<option>6 개월</option>
												<option>1 년</option>
												<option>3 년</option>
										</select></td>
										<th>참조자</th>
										<td><input type="text" id="addReferer" class="form-control" readonly></td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<th>파일첨부</th>
										<td colspan="5">
											<div class="input-group">
											    <div class="custom-file">
											        <input type="file" class="custom-file-input file-input" multiple>
											        <label class="custom-file-label">파일 선택</label>
											    </div>
											    <div class="input-group-append">
											        <button type="button" class="btn btn-primary file-select-button">파일 선택</button>
											    </div>
											</div>
										</td>
									</tr>
								</tfoot>
							</table>
							<table id="itemTable">
								<thead>
									<tr>
										<th>품명</th>
										<th>규격</th>
										<th>단위</th>
										<th>수량</th>
										<th>단가</th>
										<th>금액</th>
										<th>비고</th>
										<th>추가</th>
										<!-- 추가 버튼 컬럼 -->
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><input type="text" class="form-control item-name"></td>
										<td><input type="text" class="form-control item-spec"></td>
										<td><input type="text" class="form-control item-unit"></td>
										<td><input type="number" class="form-control item-quantity"></td>
										<td><input type="number" class="form-control item-price"></td>
										<td><input type="number" class="form-control item-amount" readonly></td>
										<td><input type="text" class="form-control item-remark"></td>
										<td><button type="button" class="btn btn-primary btn-add-row">+</button></td>
									</tr>
								</tbody>
								<tfoot>
									<tr class="table-active">
										<td colspan="5" class="text-right text-center"><strong>합계</strong></td>
										<td><input type="number" id="totalAmount" class="form-control form-control-plaintext text-center font-weight-bold" readonly></td>
										<td></td>
										<td></td>
									</tr>
								</tfoot>
							</table>
							<div class="form-group mt-3">
								<label for="details">지출내용</label>
								<textarea id="details" class="form-control" rows="10"></textarea>
							</div>
							<div class="d-flex justify-content-center">
								<button type="submit" class="btn btn-primary">결재상신</button>
								<button type="button" class="btn btn-secondary ml-2">임시저장</button>
								<button type="button" class="btn btn-danger ml-2">취소</button>
							</div>
						</form>
					</form>
				</div>


<!-- 출퇴근정정신청서 -->
				<div id="form5" class="form-container">
					<h5>출퇴근정정신청서</h5>
					<form>
						<div class="approval-line">
						    <div id="draftApprover" class="approval-box">
						        <h5 class="approval-title">기안자</h5>
						        <div class="approval-content">
						            <p id="draftDepartment">${loginEmployee.departmentCode.departmentTitle}</p>
						            <p id="draftEmployee">${loginEmployee.employeeName}</p>
						            <p id="draftDate">${currentDate}</p>
						        </div>
						    </div>
						    <div id="middleApprover" class="approval-box">
						        <h5 class="approval-title">중간결재자</h5>
						        <div class="approval-content"></div>
						    </div>
						    <div id="finalApprover" class="approval-box">
						        <h5 class="approval-title">최종결재자</h5>
						        <div class="approval-content"></div>
						    </div>
						</div>
						<form>
							<div class="form-group">
								<label for="documentType">문서종류</label> <select id="documentType"
									class="form-control">
									<option>출퇴근정정신청서</option>
								</select>
							</div>

							<table id="infoTable">

								<tbody>
									<tr>
										<th>기안자</th>
										<td>${loginEmployee.employeeName}</td>
										<th>부서</th>
										<td>${loginEmployee.departmentCode.departmentTitle}</td>
										<th>기안일</th>
										<td class="draftDate">${currentDate}</td>

									</tr>
									<tr>
										<th>제목</th>
										<td colspan="2"><input type="text" class="form-control"></td>
										<th>참조자</th>
										<td colspan="2"><input type="text" id="addReferer" class="form-control" readonly></td>

									</tr>
									<tr>
										<th>출근일자 및 시간</th>
										<td><input type="datetime-local" id="form5StartTime" class="form-control"></td>
										<th>수정일자 및 시간</th><!-- 시작일을 min으로 설정해서 그 이후만 선택가능하게 -->
										<td><input type="datetime-local" id="form5EndTime" class="form-control"></td><th>보존연한</th>
										<td><select id="retentionPeriod" class="form-control">
												<option>3 개월</option>
												<option>6 개월</option>
												<option>1 년</option>
												<option>3 년</option>
										</select></td>
									</tr>
								</tbody>
							</table>
							<div class="form-group mt-3">
								<label for="details">초과근무내용</label>
								<textarea id="details" class="form-control" rows="10"></textarea>
							</div>
							<div class="d-flex justify-content-center">
								<button type="submit" class="btn btn-primary">결재상신</button>
								<button type="button" class="btn btn-secondary ml-2">임시저장</button>
								<button type="button" class="btn btn-danger ml-2">취소</button>
							</div>
						</form>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>


<script>

	//부서 불러오기
	function loadEmployees() {
	    var departmentCode = document.getElementById("select-dept").value;

	    if (departmentCode) {
	        $.ajax({
	            url: '/approval/employees',
	            type: 'GET',
	            data: { departmentCode: departmentCode },
	            success: function(employees) {
	                updateEmployeeSelects(employees);
	            },
	            error: function(xhr, status, error) {
	                console.error("Error loading employees:", error);
	            }
	        });
	    } else {
	        // 부서가 선택되지 않았을 때 직원 선택 옵션 초기화
	        updateEmployeeSelects([]);
	    }
	}


	document.getElementById('formType').addEventListener('change', showForm);

	function updateEmployeeSelects(employees) {
	    var approverSelect = document.getElementById("approver");
	    var refererSelect = document.getElementById("referer");

	    // 기존 옵션 제거
	    approverSelect.innerHTML = '<option value="">선택하세요</option>';
	    refererSelect.innerHTML = '<option value="">선택하세요</option>';

	    // 새 직원 옵션 추가
	    employees.forEach(function(employee) {
	        var optionText = employee.employeeName + ' (' + employee.positionCode.positionTitle + ')';
	        var option = new Option(optionText, JSON.stringify(employee));
	        approverSelect.add(option.cloneNode(true));
	        refererSelect.add(option);
	    });
	}

	// 직원 선택후 결재선 라인에 추가
	var middleApprover = null;
	var finalApprover = null;
	var referers = [];

	function addApprover() {
		  var approverSelect = document.getElementById("approver");
		  var selectedOption = approverSelect.options[approverSelect.selectedIndex];

		  if (selectedOption && selectedOption.value) {
		    try {
		      var employee = JSON.parse(selectedOption.value);

		      if (!middleApprover) {
		        middleApprover = employee;
		        updateAllForms('middleApprover', employee);
		      } else if (!finalApprover) {
		        // 중간결재자와 최종결재자가 같으면 안되는 비교
		        if (employee.employeeNo === middleApprover.employeeNo) {
		            alert("중간결재자와 최종결재자는 같은 사람일 수 없습니다.");
		            return;
		          }
		        // 중간결재자와 최종결재자의 직급을 비교
		        if (employee.positionCode.positionCode >= middleApprover.positionCode.positionCode) {
		          alert("최종결재자의 직급은 중간결재자보다 높거나 같아야 합니다.");
		          return;
		        }
		        finalApprover = employee;
		        updateAllForms('finalApprover', employee);
		      } else {
		        alert("이미 중간결재자와 최종결재자가 모두 선택되었습니다.");
		      }
		    } catch (error) {
		      console.error("Error parsing employee data:", error);
		    }
		  }
		}

	// 기본값으로 'form1' 사용
	function getCurrentFormId() {
	    var formType = document.getElementById('formType').value;
	    return formType ? formType : 'form1';
	}


	function updateAllForms(type, employee) {
		  var forms = document.getElementsByClassName('form-container');
		  for (var i = 0; i < forms.length; i++) {
		    updateApprovalBox(type, employee, forms[i]);
		  }
		}


	//결재선 라인에 추가버튼 누를때 들어갈 직원
	function updateApprovalBox(type, employee, form) {
		  console.log("Updating approval box:", type, "in form:", form.id);
		  var boxContent = form.querySelector("#" + type + " .approval-content");
		  console.log("Box content element:", boxContent);
		  if (boxContent) {
		    boxContent.innerHTML =
		      "<p>" + employee.departmentCode.departmentTitle + "</p>" +
		      "<p>" + employee.employeeName + " " + employee.positionCode.positionTitle + "</p>";
		    console.log("Updated content:", boxContent.innerHTML);
		  } else {
		    console.error("Approval box content not found in form:", form.id, "for type:", type);
		  }
	}


	//참조자 추가
	function addReferer() {
	  var refererSelect = document.getElementById("referer");
	  var selectedOption = refererSelect.options[refererSelect.selectedIndex];

	  if (selectedOption && selectedOption.value) {
	    var employee = JSON.parse(selectedOption.value);

	    if (!referers.some(ref => ref.employeeNo === employee.employeeNo)) {
	      referers.push(employee);
	      updateReferersInAllForms();
	    } else {
	      alert("이미 추가된 참조자입니다.");
	    }
	  }
	}


	//참조자 나타내기
	function updateReferersInAllForms() {
		console.log("Updating referers in all forms");
		  var refererString = referers.map(ref => ref.employeeName).join(", ");
		  var forms = document.getElementsByClassName('form-container');

		  for (var i = 0; i < forms.length; i++) {
		    var form = forms[i];
		    var refererInput = form.querySelector("#addReferer");
		    var refererList = form.querySelector("#refererList");

		    if (refererInput) {
		      refererInput.value = refererString;
		    } else if (refererList) {
		      refererList.innerHTML = refererString;
		    }
		  }
		}


	//결재자,참조자 리셋버튼으로 초기화하기
	function resetApprovers() {
			console.log("resetApprovers function called");
	  middleApprover = null;
	  finalApprover = null;
	  referers = [];

	  var forms = document.getElementsByClassName('form-container');
	  for (var i = 0; i < forms.length; i++) {
	    var form = forms[i];
	    var middleApproverContent = form.querySelector("#middleApprover .approval-content");
	    var finalApproverContent = form.querySelector("#finalApprover .approval-content");

	    if (middleApproverContent) middleApproverContent.innerHTML = "";
	    if (finalApproverContent) finalApproverContent.innerHTML = "";
	  }

	  // 참조자 필드 초기화
	  document.getElementById("addReferer").value = "";

	  // 선택된 옵션 초기화
	  document.getElementById("approver").selectedIndex = 0;
	  document.getElementById("referer").selectedIndex = 0;

	  console.log("Approvers and referers have been reset.");
	}



	//양식 바뀔때 결재자,참조자정보 초기화
	function showForm() {
	    var selectedForm = document.getElementById('formType').value;
	    var forms = document.getElementsByClassName('form-container');

	    // 폼 변경 시 결재자와 참조자 정보 초기화
	    clearApproversAndReferers();

	    for (var i = 0; i < forms.length; i++) {
	        forms[i].style.display = 'none';
	    }
	    if (selectedForm) {
	        var currentForm = document.getElementById(selectedForm);
	        if (currentForm) {
	            currentForm.style.display = 'block';
	            updateReferersInAllForms();
	        }
	    }
	}


	//양식이 바뀔때마다 결재자 참조자 초기화 시키기
	function clearApproversAndReferers() {
	    middleApprover = null;
	    finalApprover = null;
	    referers = [];
	    updateReferersInAllForms();

	    // 모든 폼에 대해 결재자 정보 초기화
	    var forms = document.getElementsByClassName('form-container');
	    for (var i = 0; i < forms.length; i++) {
	        var form = forms[i];
	        var middleApproverContent = form.querySelector("#middleApprover .approval-content");
	        var finalApproverContent = form.querySelector("#finalApprover .approval-content");

	        if (middleApproverContent) middleApproverContent.innerHTML = "";
	        if (finalApproverContent) finalApproverContent.innerHTML = "";
	    }

	    // 참조자 필드 초기화
	    var refererInput = document.getElementById("addReferer");
	    if (refererInput) refererInput.value = "";

	    // 선택된 옵션 초기화
	    var approverSelect = document.getElementById("approver");
	    var refererSelect = document.getElementById("referer");
	    if (approverSelect) approverSelect.selectedIndex = 0;
	    if (refererSelect) refererSelect.selectedIndex = 0;

	    console.log("Approvers and referers have been cleared.");
	}

	//결재자 정보
	function updateApproverInfo(form) {
		  if (middleApprover) {
		    updateApprovalBox('middleApprover', middleApprover, form);
		  }
		  if (finalApprover) {
		    updateApprovalBox('finalApprover', finalApprover, form);
		  }
		}


	//파일선택
	document.querySelectorAll('.file-input').forEach(input => {
        input.addEventListener('change', function() {
            // 가장 가까운 부모 요소에서 라벨 찾기
            const label = this.closest('.input-group').querySelector('.custom-file-label');
            if (label) {
                const selectedFiles = Array.from(this.files).map(file => file.name).join(', ');
                label.textContent = selectedFiles || '파일 선택';
            }
        });
    });


	function initializeForms() {
		  var forms = document.getElementsByClassName('form-container');
		  for (var i = 0; i < forms.length; i++) {
		    updateApproverInfo(forms[i]);
		  }
		}

		window.onload = function() {
		  initializeForms();
		  // 기타 필요한 초기화 함수들...
		};



		document.getElementById('formType').addEventListener('change', showForm);

		//초기화 시키는 버튼 이벤트 리스너
		document.addEventListener('DOMContentLoaded', function() {

			// 초기화 버튼 이벤트
			var resetButton = document.querySelector('button.btn-danger');
			if (resetButton) {
			  resetButton.addEventListener('click', resetApprovers);
			} else {
			  console.error("Reset button not found");
			}


			// 양식 변경시 초기화 이벤트
			var formTypeSelect = document.getElementById('formType');
			  if (formTypeSelect) {
			      formTypeSelect.addEventListener('change', showForm);
			  }


			// 참조자 추가시 나타내는 이벤트
			updateReferersInAllForms();


			// 모든 폼의 파일 선택 버튼에 대해 이벤트 리스너 추가
		    document.querySelectorAll('.file-select-button').forEach(button => {
		        button.addEventListener('click', function() {
		            // 가장 가까운 부모 요소에서 파일 입력 찾기
		            const fileInput = this.closest('.input-group').querySelector('.file-input');
		            if (fileInput) {
		                fileInput.click();
		            }
		        });
	   		});


		 // 현재 날짜를 YYYY-MM-DD 형식으로 가져오는 함수
		    function getCurrentDate() {
		        const now = new Date();
		        const year = now.getFullYear();
		        const month = String(now.getMonth() + 1).padStart(2, '0');
		        const day = String(now.getDate()).padStart(2, '0');
		        return `${year}-${month}-${day}`;
		    }

		    // 모든 기안일 필드에 현재 날짜 설정
		    const draftDateFields = document.querySelectorAll('.draftDate');
		    const currentDate = getCurrentDate();

		    draftDateFields.forEach(field => {
		        if (!field.textContent.trim()) {
		            field.textContent = currentDate;
		        }
		    });

	});

		// 날짜 선택시 시작일보다 종료일이 앞서지 않게 선택
		document.addEventListener('DOMContentLoaded', function() {
		    const startDate = document.getElementById('startDate');
		    const endDate = document.getElementById('endDate');

		    // 시작일이 변경될 때마다 종료일의 최소 날짜를 갱신
		    startDate.addEventListener('change', function() {
		        endDate.min = startDate.value;

		        // 만약 현재 선택된 종료일이 새로운 시작일보다 이전이라면 종료일을 시작일과 같게 설정
		        if (endDate.value < startDate.value) {
		            endDate.value = startDate.value;
		        }
		    });
		});

		$(document).ready(function() {
		    // 추가 버튼 클릭 시 이벤트 처리
		    $('.btn-add-row').click(function() {
		        var newRow = '<tr>' +
		            '<td><input type="text" class="form-control item-name"></td>' +
		            '<td><input type="text" class="form-control item-spec"></td>' +
		            '<td><input type="text" class="form-control item-unit"></td>' +
		            '<td><input type="number" class="form-control item-quantity"></td>' +
		            '<td><input type="number" class="form-control item-price"></td>' +
		            '<td><input type="number" class="form-control item-amount" readonly></td>' +
		            '<td><input type="text" class="form-control item-remark"></td>' +
		            '<td><button type="button" class="btn btn-primary btn-add-row">+</button></td>' +
		            '</tr>';

		        $('#itemTable tbody').append(newRow);
		    });
		});





</script>




<c:import url="${path }/WEB-INF/views/common/footer.jsp" />