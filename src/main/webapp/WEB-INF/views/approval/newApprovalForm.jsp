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
<link href="${path }/css/approval/newApprovalForm.css" rel="stylesheet" type="text/css">
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp" />
<c:import url="${path }/WEB-INF/views/common/header.jsp" />
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<section>
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

				<div class="form-group">
					<label for="receiver">수신처 선택</label>
					<div class="d-flex justify-content-between align-items-center">
						<select id="receiver" class="form-control mr-2" style="width: 70%;">
							<c:if test="${not empty employees}">
								<option value="">선택하세요</option>
								<c:forEach var="employee" items="${employees}">
									<option value="${employee.employeeNo}">${employee.employeeName}</option>
								</c:forEach>
							</c:if>
						</select>
						<button type="button" class="btn btn-primary" onclick="addReceiver();">수신처 추가</button>
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
        <div class="form-group">
            <label for="documentType">문서종류</label>
            <select id="documentType" class="form-control">
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
                    <th>휴가종료일</th>
                    <td><input type="date" id="endDate" class="form-control"></td>
                    <th>보존연한</th>
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
                    <th>수신처</th>
                    <td colspan="3">
                        <div id="recipient" class="form-control">
                            <div class="recipient-item">
                                <input type="hidden" name="recipientId" value="사번">
                                <span class="recipient-details">수신처 이름 및 직급부서</span>
                                <span class="remove-recipient" onclick="removeElement(this)">x</span>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>참조자</th>
                    <td colspan="3">
                        <div id="addReferer" class="form-control">
                            <div class="referer-item">
                                <input type="hidden" name="refererId" value="사번">
                                <span class="referer-details">참조자 이름 및 직급부서</span>
                                <span class="remove-referer" onclick="removeElement(this)">x</span>
                            </div>
                        </div>
                    </td>
                    <th>보안등급</th>
                    <td>
                        <select id="securityLevel" class="form-control">
                            <option value="S">S</option>
                            <option value="A">A</option>
                            <option value="B">B</option>
                        </select>
                    </td>
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

</section>
<script>const path='${path}';</script>
<script src='${path }/js/approval/newApprovalForm.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp" />