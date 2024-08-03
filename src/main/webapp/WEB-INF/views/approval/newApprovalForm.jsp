<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<c:import url="/WEB-INF/views/common/header.jsp" />
<%
LocalDate currentDate = LocalDate.now();
String formattedDate = currentDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
request.setAttribute("currentDate", formattedDate);
%>

<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="loginEmployee"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />
<c:set var="approval"
	value="${com.project.hot.approval.model.dto.Approval}" />
<link href="${path }/css/approval/newApprovalForm.css" rel="stylesheet"
	type="text/css">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<section>
	<div class="page-container">
		<div>
			<h3>결재 신청서</h3>
		</div>
		<div class="content-container" STYLE="border: 1px solid red">
			<div class="left-section">
				<div class="form-group">
					<label for="formType">전자결재 양식 선택</label> <select id="formType"
						class="form-control form-control-sm" onchange="showForm()">
						<option value="">양식을 선택하세요</option>
						<option value="form1">출장신청서</option>
						<option value="form2">휴가신청서</option>
						<option value="form3">초과근무신청서</option>
						<option value="form4">경비지출신청서</option>
						<option value="form5">출퇴근정정신청서</option>
					</select>
				</div>


				<div class="form-group">
					<label for="department">부서 선택</label> <select id="select-dept"
						class="form-control" onchange="loadEmployees()">
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
						<select id="approver" class="form-control mr-2"
							style="width: 70%;">
							<c:if test="${not empty employees}">
								<option value="">선택하세요</option>
								<c:forEach var="employee" items="${employees}">
									<option value="${employee.employeeNo}">${employee.employeeName}</option>
								</c:forEach>
							</c:if>
						</select>
						<button type="button" class="btn btn-primary"
							onclick="addApprover();">결재자 추가</button>
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
						<button type="button" class="btn btn-primary"
							onclick="addReferer();">참조자 추가</button>
					</div>
				</div>

				<div class="form-group">
					<label for="receiver">수신처 선택</label>
					<div class="d-flex justify-content-between align-items-center">
						<select id="receiver" class="form-control mr-2"
							style="width: 70%;">
							<c:if test="${not empty employees}">
								<option value="">선택하세요</option>
								<c:forEach var="employee" items="${employees}">
									<option value="${employee.employeeNo}">${employee.employeeName}</option>
								</c:forEach>
							</c:if>
						</select>
						<button type="button" class="btn btn-primary"
							onclick="addReceiver();">수신처 추가</button>
					</div>
				</div>

				<div class="form-group" id="partnerSelect" style="display: none;">
					<label for="partner">동행자 선택</label>
					<div class="d-flex justify-content-between align-items-center">
						<select id="partner" class="form-control mr-2" style="width: 70%;">
							<c:if test="${not empty employees}">
								<option value="">선택하세요</option>
								<c:forEach var="employee" items="${employees}">
									<option value="${employee.employeeNo}">${employee.employeeName}</option>
								</c:forEach>
							</c:if>
						</select>
						<button type="button" class="btn btn-primary"
							onclick="addPartner();">동행자 추가</button>
					</div>
				</div>
				<button type="button" class="btn btn-danger ml-2"
					onclick="resetApprovers()">초기화</button>

			</div>

			<div class="right-section">
				<!-- 출장신청서 -->
				<div id="form1" class="form-container">
					<h5>출장신청서</h5>
					<form id="business-form">
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
								<h5 class="approval-title">
									중간결재자<span class="asterisk">*</span>
								</h5>
								<div class="approval-content"></div>
							</div>
							<div id="finalApprover" class="approval-box">
								<h5 class="approval-title">
									최종결재자<span class="asterisk">*</span>
								</h5>
								<div class="approval-content"></div>
							</div>
						</div>

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
									<td><input type="hidden"
										value="${loginEmployee.employeeNo}" name="approvalEmpNo">
										${loginEmployee.employeeName}</td>
									<th>부서</th>
									<td>${loginEmployee.departmentCode.departmentTitle}</td>
									<th>기안일</th>
									<td class="draftDate"><input type="hidden"
										value="${currentDate}" name="approvalDate">
										${currentDate}</td>
								</tr>
								<tr>
									<th>제목<span class="asterisk">*</span></th>
									<td colspan="5"><input type="text" name="title"
										class="form-control business-title" required></td>
								</tr>
								<tr>
									<th>출장시작일<span class="asterisk">*</span></th>
									<td><input type="date" id="startDate"
										name="businessTripStartDate" class="form-control" required>
									</td>
									<th>출장종료일<span class="asterisk">*</span></th>
									<td><input type="date" id="endDate"
										name="businessTripEndDate" class="form-control" required>
									</td>
									<th>보존연한<span class="asterisk">*</span></th>
									<td><select id="retentionPeriod" class="form-control"
										name="period" required>
											<option value="3">3 개월</option>
											<option value="6">6 개월</option>
											<option value="12">1 년</option>
											<option value="36">3 년</option>
									</select></td>
								</tr>
								<tr>
									<th>출장지<span class="asterisk">*</span></th>
									<td><input type="text" name="businessTripDestination"
										class="form-control" required></td>
									<th>비상연락처</th>
									<td><input type="tel" id="phoneNumber"
										name="businessTripEmergency" class="form-control"></td>
									<th>보안등급<span class="asterisk">*</span></th>
									<td><select id="securityLevel" class="form-control"
										name="security" required>
											<option value="S">S</option>
											<option value="A">A</option>
											<option value="B">B</option>
									</select></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>수신처</th>
									<td colspan="5">
										<div id="recipient" class="form-control recipientDiv"></div>
									</td>
								</tr>
								<tr>
									<th>참조자</th>
									<td colspan="5">
										<div id="referer-div" class="form-control refererDiv"></div>
									</td>
								</tr>
								<tr>
									<th>동행자</th>
									<td colspan="5">
										<div id="partner-div" class="form-control partnerDiv"></div>
									</td>
								</tr>
								<tr>
									<th>파일첨부</th>
									<td colspan="5">
										<div class="input-group">
											<div class="custom-file">
												<input type="file" class="custom-file-input file-input"
													name="upFile" multiple> <label
													class="custom-file-label">파일 선택</label>
											</div>
											<div class="input-group-append">
												<button type="button"
													class="btn btn-primary file-select-button">파일 선택</button>
											</div>
										</div>
									</td>
								</tr>
							</tfoot>
						</table>

						<div class="form-group mt-3">
							<label for="details">출장내용<span class="asterisk">*</span></label>
							<textarea id="details" name="content" class="form-control"
								rows="10" required></textarea>
						</div>
						<div class="d-flex justify-content-center">
							<button type="button" class="btn btn-primary"
								id="business-insert-btn">결재상신</button>
							<button type="button" class="btn btn-secondary ml-2"
								id="business-temp-btn">임시저장</button>
							<button type="button" class="btn btn-danger ml-2">취소</button>
						</div>
					</form>
				</div>



				<!-- 휴가신청서 -->
				<div id="form2" class="form-container">
					<h5>휴가신청서</h5>
					<form id="vacation-form">
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
								<h5 class="approval-title">
									중간결재자<span class="asterisk">*</span>
								</h5>
								<div class="approval-content"></div>
							</div>
							<div id="finalApprover" class="approval-box">
								<h5 class="approval-title">
									최종결재자<span class="asterisk">*</span>
								</h5>
								<div class="approval-content"></div>
							</div>
						</div>
						<div class="form-group">
							<label for="documentType">문서종류<span class="asterisk">*</span></label>
							<select id="documentType" class="form-control"
								name="vacationType" required>
								<option value="반차">반차 신청서</option>
								<option value="연차">연차 신청서</option>
								<option value="병가">병가 신청서</option>
								<option value="육아휴직">육아 휴직 신청서</option>
								<option value="출산휴가">출산 휴가 신청서</option>
							</select>
						</div>

						<table id="infoTable">
							<tbody>
								<tr>
									<th>기안자</th>
									<td><input type="hidden"
										value="${loginEmployee.employeeNo }" name="approvalEmpNo">
										${loginEmployee.employeeName}</td>
									<th>부서</th>
									<td>${loginEmployee.departmentCode.departmentTitle}</td>
									<th>기안일</th>
									<td class="draftDate"><input type="hidden"
										value="${currentDate }" name="approvalDate">
										${currentDate}</td>
								</tr>
								<tr>
									<th>제목<span class="asterisk">*</span></th>
									<td colspan="5"><input type="text" name="title"
										class="form-control vacation-title" required></td>
								</tr>
								<tr>
									<th>휴가시작일<span class="asterisk">*</span></th>
									<td><input type="date" id="startDate" name="vacationStart"
										class="form-control" required></td>
									<th>휴가종료일<span class="asterisk">*</span></th>
									<td><input type="date" id="endDate" name="vacationEnd"
										class="form-control" required></td>
									<th>보존연한<span class="asterisk">*</span></th>
									<td><select id="retentionPeriod" class="form-control"
										name="period" required>
											<option value="3">3 개월</option>
											<option value="6">6 개월</option>
											<option value="12">1 년</option>
											<option value="36">3 년</option>
									</select></td>
								</tr>
								<tr>
									<th>비상연락처</th>
									<td><input type="tel" id="phoneNumber"
										class="form-control" name="vacationEmergency"></td>
									<th>수신처<span class="asterisk">*</span></th>
									<td colspan="3">
										<div id="recipient" class="form-control recipientDiv"></div>
									</td>
								</tr>
								<tr>
									<th>참조자</th>
									<td colspan="3">
										<div id="referer-div" class="form-control refererDiv"></div>
									</td>
									<th>보안등급<span class="asterisk">*</span></th>
									<td><select id="securityLevel" class="form-control"
										name="security" required>
											<option value="S">S</option>
											<option value="A">A</option>
											<option value="B">B</option>
									</select></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>파일첨부</th>
									<td colspan="5">
										<div class="input-group">
											<div class="custom-file">
												<input type="file" class="custom-file-input file-input"
													name="upFile" multiple> <label
													class="custom-file-label">파일 선택</label>
											</div>
											<div class="input-group-append">
												<button type="button"
													class="btn btn-primary file-select-button">파일 선택</button>
											</div>
										</div>
									</td>
								</tr>
							</tfoot>
						</table>
						<div class="form-group mt-3">
							<label for="details">휴가내용<span class="asterisk">*</span></label>
							<textarea id="details" class="form-control" rows="10"
								name="content" required></textarea>
						</div>
						<div class="d-flex justify-content-center">
							<button type="button" class="btn btn-primary"
								id="vacation-insert-btn">결재상신</button>
							<button type="button" class="btn btn-secondary ml-2"
								id="vacation-temp-btn">임시저장</button>
							<button type="button" class="btn btn-danger ml-2">취소</button>
						</div>
					</form>
				</div>



				<!-- 초과근무신청서 -->
				<div id="form3" class="form-container">
					<h5>초과근무신청서</h5>
					<form id="overtime-form">
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
								<h5 class="approval-title">
									중간결재자<span class="asterisk">*</span>
								</h5>
								<div class="approval-content"></div>
							</div>
							<div id="finalApprover" class="approval-box">
								<h5 class="approval-title">
									최종결재자<span class="asterisk">*</span>
								</h5>
								<div class="approval-content"></div>
							</div>
						</div>
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
									<td><input type="hidden"
										value="${loginEmployee.employeeNo}" name="approvalEmpNo">
										${loginEmployee.employeeName}</td>
									<th>부서</th>
									<td>${loginEmployee.departmentCode.departmentTitle}</td>
									<th>기안일</th>
									<td class="draftDate"><input type="hidden"
										value="${currentDate}" name="approvalDate">
										${currentDate}</td>
								</tr>
								<tr>
									<th>제목<span class="asterisk">*</span></th>
									<td colspan="5"><input type="text" name="title"
										class="form-control overtime-title" required></td>
								</tr>
								<tr>
									<th>초과근무일<span class="asterisk">*</span></th>
									<td><input type="date" id="overtimeDate"
										name="overtimeDate" class="form-control" required></td>
									<th>초과근무시작시간<span class="asterisk">*</span></th>
									<td><input type="time" id="form3StartTime"
										name="overtimeStartTime" class="form-control" required>
									</td>
									<th>초과근무종료시간<span class="asterisk">*</span></th>
									<td><input type="time" id="form3EndTime"
										name="overtimeEndTime" class="form-control" required>
									</td>
								</tr>
								<tr>
									<th>참조자</th>
									<td colspan="3">
										<div id="referer-div" class="form-control refererDiv"></div>
									</td>
									<th>보안등급<span class="asterisk">*</span></th>
									<td><select id="securityLevel" class="form-control"
										name="security" required>
											<option value="S">S</option>
											<option value="A">A</option>
											<option value="B">B</option>
									</select></td>
								</tr>
								<tr>
									<th>수신처</th>
									<td colspan="3">
										<div id="recipient" class="form-control recipientDiv"></div>
									</td>
									<th>보존연한<span class="asterisk">*</span></th>
									<td><select id="retentionPeriod" class="form-control"
										name="period" required>
											<option value="3">3 개월</option>
											<option value="6">6 개월</option>
											<option value="12">1 년</option>
											<option value="36">3 년</option>
									</select></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>파일첨부</th>
									<td colspan="5">
										<div class="input-group">
											<div class="custom-file">
												<input type="file" class="custom-file-input file-input"
													name="upFile" multiple> <label
													class="custom-file-label">파일 선택</label>
											</div>
											<div class="input-group-append">
												<button type="button"
													class="btn btn-primary file-select-button">파일 선택</button>
											</div>
										</div>
									</td>
								</tr>
							</tfoot>
						</table>
						<div class="form-group mt-3">
							<label for="details">초과근무내용<span class="asterisk">*</span></label>
							<textarea id="details" name="content" class="form-control"
								rows="10" required></textarea>
						</div>
						<div class="d-flex justify-content-center">
							<button type="button" class="btn btn-primary"
								id="overtime-insert-btn">결재상신</button>
							<button type="button" class="btn btn-secondary ml-2"
								id="overtime-temp-btn">임시저장</button>
							<button type="button" class="btn btn-danger ml-2">취소</button>
						</div>
					</form>
				</div>



				<!-- 경비지출신청서 -->
				<div id="form4" class="form-container">
					<h5>경비지출신청서</h5>
					<form id="expenditure-form">
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
								<h5 class="approval-title">
									중간결재자<span class="asterisk">*</span>
								</h5>
								<div class="approval-content"></div>
							</div>
							<div id="finalApprover" class="approval-box">
								<h5 class="approval-title">
									최종결재자<span class="asterisk">*</span>
								</h5>
								<div class="approval-content"></div>
							</div>
						</div>
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
									<td><input type="hidden"
										value="${loginEmployee.employeeNo}" name="approvalEmpNo">
										${loginEmployee.employeeName}</td>
									<th>부서</th>
									<td>${loginEmployee.departmentCode.departmentTitle}</td>
									<th>기안일</th>
									<td class="draftDate"><input type="hidden"
										value="${currentDate}" name="approvalDate">
										${currentDate}</td>
								</tr>
								<tr>
									<th>제목<span class="asterisk">*</span></th>
									<td colspan="5"><input name="title" type="text"
										class="form-control expenditure-title" required></td>
								</tr>
								<tr>
									<th>경비지출일<span class="asterisk">*</span></th>
									<td><input type="date" name="expenditureDate"
										class="form-control" required></td>
									<th>보존연한<span class="asterisk">*</span></th>
									<td><select id="retentionPeriod" class="form-control"
										name="period" required>
											<option value="3">3 개월</option>
											<option value="6">6 개월</option>
											<option value="12">1 년</option>
											<option value="36">3 년</option>
									</select></td>
									<th>보안등급<span class="asterisk">*</span></th>
									<td><select id="securityLevel" class="form-control"
										name="security" required>
											<option value="S">S</option>
											<option value="A">A</option>
											<option value="B">B</option>
									</select></td>
								</tr>
								<tr>
									<th>참조자</th>
									<td colspan="5">
										<div id="referer-div" class="form-control refererDiv"></div>
									</td>
								</tr>
								<tr>
									<th>수신처</th>
									<td colspan="5">
										<div id="recipient" class="form-control recipientDiv"></div>
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>파일첨부</th>
									<td colspan="5">
										<div class="input-group">
											<div class="custom-file">
												<input type="file" class="custom-file-input file-input"
													name="upFile" multiple> <label
													class="custom-file-label">파일 선택</label>
											</div>
											<div class="input-group-append">
												<button type="button"
													class="btn btn-primary file-select-button">파일 선택</button>
											</div>
										</div>
									</td>
								</tr>
							</tfoot>
						</table>
						<table id="itemTable">
							<thead>
								<tr>
									<th colspan="8">지출품목</th>
								</tr>
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
									<td><input name="items[0].expenditureName" type="text"
										class="form-control item-name"></td>
									<td><input name="items[0].expenditureSpec" type="text"
										class="form-control item-spec"></td>
									<td><input name="items[0].expenditureUnit" type="text"
										class="form-control item-unit"></td>
									<td><input name="items[0].expenditureQuantity"
										type="number" class="form-control item-quantity"></td>
									<td><input name="items[0].expenditurePrice" type="number"
										class="form-control item-price"></td>
									<td><input type="number" class="form-control item-amount"
										readonly></td>
									<td><input name="items[0].expenditureRemark" type="text"
										class="form-control item-remark"></td>
									<td><button type="button"
											class="btn btn-primary btn-add-row">+</button></td>
								</tr>
							</tbody>
							<tfoot>
								<tr class="table-active">
									<td colspan="5" class="text-right text-center"><strong>합계</strong></td>
									<td><input type="number" name="expenditureAmount"
										id="totalAmount"
										class="form-control form-control-plaintext text-center font-weight-bold"
										readonly></td>
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
							<button type="button" class="btn btn-primary"
								id="expenditure-insert-btn">결재상신</button>
							<button type="button" class="btn btn-secondary ml-2"
								id="expenditure-temp-btn">임시저장</button>
							<button type="button" class="btn btn-danger ml-2">취소</button>
						</div>
					</form>
				</div>


				<!-- 출퇴근정정신청서 -->
				<div id="form5" class="form-container">
					<h5>출퇴근정정신청서</h5>
					<form id="commuting-form">
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
								<h5 class="approval-title">
									중간결재자<span class="asterisk">*</span>
								</h5>
								<div class="approval-content"></div>
							</div>
							<div id="finalApprover" class="approval-box">
								<h5 class="approval-title">
									최종결재자<span class="asterisk">*</span>
								</h5>
								<div class="approval-content"></div>
							</div>
						</div>
						<div class="form-group">
							<label for="documentType">문서종류</label> <select id="documentType"
								class="form-control">
								<option>출퇴근정정신청서</option>
							</select>
						</div>
						<table id="infoTable" class="table">
							<tbody>
								<tr>
									<th>기안자</th>
									<td><input type="hidden"
										value="${loginEmployee.employeeNo}" name="approvalEmpNo">
										${loginEmployee.employeeName}</td>
									<th>부서</th>
									<td>${loginEmployee.departmentCode.departmentTitle}</td>
									<th>기안일</th>
									<td class="draftDate"><input type="hidden"
										value="${currentDate}" name="approvalDate">
										${currentDate}</td>
								</tr>
								<tr>
									<th>제목<span class="asterisk">*</span></th>
									<td colspan="5"><input type="text"
										class="form-control commuting-title" name="title" required>
									</td>
								</tr>
								<tr>
									<th>참조자</th>
									<td colspan="3">
										<div id="referer-div" class="form-control refererDiv"></div>
									</td>
									<th>보안등급<span class="asterisk">*</span></th>
									<td><select id="securityLevel" class="form-control"
										name="security" required>
											<option value="S">S</option>
											<option value="A">A</option>
											<option value="B">B</option>
									</select></td>
								</tr>
								<tr>
									<th>수신처<span class="asterisk">*</span></th>
									<td colspan="3">
										<div id="recipient" class="form-control recipientDiv"></div>
									</td>
									<th>보존연한<span class="asterisk">*</span></th>
									<td><select id="retentionPeriod" class="form-control"
										name="period" required>
											<option value="3">3 개월</option>
											<option value="6">6 개월</option>
											<option value="12">1 년</option>
											<option value="36">3 년</option>
									</select></td>
								</tr>
								<tr>
									<th>출퇴근 정정 일자<span class="asterisk">*</span></th>
									<td><input type="date" id="commutingDate"
										name="commutingWorkDate" class="form-control"></td>
									<th>출/퇴근 선택<span class="asterisk">*</span></th>
									<td><select id="commutingType" class="form-control"
										name="commutingType" required>
											<option value="출근">출근</option>
											<option value="퇴근">퇴근</option>
									</select></td>
									<th>정정 시간<span class="asterisk">*</span></th>
									<td><input type="time" id="commutingTime"
										name="commutingEditTime" class="form-control" required>
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th>파일첨부</th>
									<td colspan="5">
										<div class="input-group">
											<div class="custom-file">
												<input type="file" class="custom-file-input file-input"
													name="upFile" multiple> <label
													class="custom-file-label">파일 선택</label>
											</div>
											<div class="input-group-append">
												<button type="button"
													class="btn btn-primary file-select-button">파일 선택</button>
											</div>
										</div>
									</td>
								</tr>
							</tfoot>
						</table>
						<div class="form-group mt-3">
							<label for="details">출퇴근정정 내용<span class="asterisk">*</span></label>
							<textarea id="details" class="form-control" name="content"
								rows="10" required></textarea>
						</div>
						<div class="d-flex justify-content-center">
							<button type="button" class="btn btn-primary"
								id="commuting-insert-btn">결재상신</button>
							<button type="button" class="btn btn-secondary ml-2"
								id="commuting-temp-btn">임시저장</button>
							<button type="button" class="btn btn-danger ml-2">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</section>
<script>
	const path = '${path}';
</script>
<script src='${path }/js/approval/newApprovalForm.js'></script>
<c:import url="/WEB-INF/views/common/footer.jsp" />