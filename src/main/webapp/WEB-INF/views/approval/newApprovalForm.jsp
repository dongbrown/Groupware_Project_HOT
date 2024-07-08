<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="loginEmployee"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp" />
<c:import url="${path }/WEB-INF/views/common/header.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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

.approval-line {
	display: flex;
	justify-content: space-between;
	margin-bottom: 20px;
}

.approval-box {
	flex: 1;
	padding: 10px;
	margin-right: 10px;
	background-color: #fff;
	border: 1px solid #ddd;
}

.button-container {
	display: flex;
	justify-content: center;
	margin-top: 10px; /* 필요한 경우 마진 조정 */
}

.button-container button {
	margin-left: 10px; /* 버튼 간의 간격 조정 */
}

#itemTable {
	margin: 0 auto; /* 테이블을 가운데 정렬 */
	border-collapse: collapse; /* 테이블 테두리 겹치지 않도록 설정 */
	width: 100%; /* 테이블이 전체 너비를 차지하도록 설정 */
}

#itemTable th, #itemTable td {
	text-align: center; /* 테이블 셀 가운데 정렬 */
	vertical-align: middle; /* 셀 세로 가운데 정렬 */
	border: 1px solid #dddddd; /* 테이블 셀에 테두리 추가 */
	padding: 8px; /* 테이블 셀에 패딩 추가 */
	background-color: #fff; /* 테이블 셀 배경색 흰색으로 설정 */
}

#itemTable th {
	background-color: #f2f2f2; /* 테이블 헤더 배경색 연한 회색으로 설정 */
	font-weight: bold; /* 테이블 헤더 글씨체 굵게 설정 */
}

#itemTable tbody tr:nth-child(even) {
	background-color: #f9f9f9; /* 짝수 행 배경색 연한 회색으로 설정 */
}

#itemTable tbody tr:nth-child(odd) {
	background-color: #fff; /* 홀수 행 배경색 흰색으로 설정 */
}

.form-control {
	font-size: 0.9rem; /* 폼 컨트롤의 폰트 크기 조정 */
}

/* 입력 필드의 너비를 일관되게 조정 */
#itemTable input[type="text"], #itemTable input[type="date"], #itemTable select
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
					<label for="department">부서 선택</label> <select id="department"
						class="form-control" onchange="loadEmployees()">
						<option value="">부서를 선택하세요</option>
						<option value="경영팀">경영팀</option>
						<option value="개발팀">개발팀</option>
						<option value="인사팀">인사팀</option>
						<option value="디자인팀">디자인팀</option>
						<option value="홍보팀">홍보팀</option>
					</select>
				</div>
				<div class="form-group">
					<label for="approvers">결재자 선택</label> <select id="approvers"
						class="form-control" multiple></select>
				</div>
				<div class="form-group">
					<label for="references">참조자 선택</label> <select id="references"
						class="form-control" multiple></select>
				</div>

			</div>

			<div class="right-section">
<!-- 출장신청서 -->
				<div id="form1" class="form-container">
					<h5>출장신청서</h5>
					<form>
						<div class="approval-line">
							<div class="approval-box">
								<h5>기안자</h5>
								<div class="approval-content">
									<!-- 부서 제목과 직원 이름을 여기에 넣어야 함 -->
									<p id="draftDepartment">${loginEmployee.departmentCode.departmentTitle}</p>
									<p id="draftEmployee">${loginEmployee.employeeName}</p>
									<p id="draftDate">오늘날짜를 넣자 default</p>
								</div>
							</div>
							<!-- 중간결재자와 최종결재자는 초기에는 공란 -->
							<div class="approval-box">
								<h5>중간결재자</h5>
							</div>
							<div class="approval-box">
								<h5>최종결재자</h5>
							</div>
						</div>
						<form>
							<div class="form-group">
								<label for="documentType">문서종류</label> <select id="documentType"
									class="form-control">
									<option>출장신청서</option>
								</select>
							</div>

							<table id="itemTable">

								<tbody>
									<tr>
										<th>기안자</th>
										<td>${loginEmployee.employeeName}</td>
										<th>부서</th>
										<td>${loginEmployee.departmentCode.departmentTitle}</td>
										<th>기안일</th>
										<td><input type="date" class="form-control" readonly></td>

									</tr>
									<tr>
										<th>제목</th>
										<td colspan="5"><input type="text" class="form-control"></td>

									</tr>
									<tr>
										<th>출장시작일</th>
										<td><input type="date" class="form-control"></td>
										<th>출장종료일</th>
										<td><input type="date" class="form-control"></td>
										<th>보존연한</th>
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
										<td colspan="2"><input type="text" id="addReferer"
											class="form-control" readonly></td>

										<th>첨부파일</th>
										<td colspan="2">
											<div class="input-group">
												<div class="custom-file">
													<input type="file" id="attachments"
														class="custom-file-input" multiple> <label
														class="custom-file-label" for="attachments">파일 선택</label>
												</div>
												<div class="input-group-append">
													<button type="button" class="btn btn-primary"
														id="attachButton">파일 선택</button>
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
							<div class="approval-box">
								<h5>기안자</h5>
								<div class="approval-content">
									<!-- 부서 제목과 직원 이름을 여기에 넣어야 함 -->
									<p id="draftDepartment">${loginEmployee.departmentCode.departmentTitle}</p>
									<p id="draftEmployee">${loginEmployee.employeeName}</p>
									<p id="draftDate">오늘날짜를 넣자 default</p>
								</div>
							</div>
							<!-- 중간결재자와 최종결재자는 초기에는 공란 -->
							<div class="approval-box">
								<h5>중간결재자</h5>
							</div>
							<div class="approval-box">
								<h5>최종결재자</h5>
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

							<table id="itemTable">

								<tbody>
									<tr>
										<th>기안자</th>
										<td>${loginEmployee.employeeName}</td>
										<th>부서</th>
										<td>${loginEmployee.departmentCode.departmentTitle}</td>
										<th>기안일</th>
										<td><input type="date" class="form-control" readonly></td>

									</tr>
									<tr>
										<th>제목</th>
										<td colspan="5"><input type="text" class="form-control"></td>

									</tr>
									<tr>
										<th>휴가시작일</th>
										<td><input type="date" class="form-control"></td>
										<th>휴가종료일</th>
										<td><input type="date" class="form-control"></td>
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
										<th>참조자</th>
										<td colspan="3"><input type="text" id="addReferer"
											class="form-control" readonly></td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<th>첨부파일</th>
										<td colspan="5">
											<div class="input-group">
												<div class="custom-file">
													<input type="file" id="attachments"
														class="custom-file-input" multiple> <label
														class="custom-file-label" for="attachments">파일 선택</label>
												</div>
												<div class="input-group-append">
													<button type="button" class="btn btn-primary"
														id="attachButton">파일 선택</button>
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


<!-- 초과근무신청서 -->
				<div id="form3" class="form-container">
					<h5>초과근무신청서</h5>
					<form>
						<div class="approval-line">
							<div class="approval-box">
								<h5>기안자</h5>
								<div class="approval-content">
									<!-- 부서 제목과 직원 이름을 여기에 넣어야 함 -->
									<p id="draftDepartment">${loginEmployee.departmentCode.departmentTitle}</p>
									<p id="draftEmployee">${loginEmployee.employeeName}</p>
									<p id="draftDate">오늘날짜를 넣자 default</p>
								</div>
							</div>
							<!-- 중간결재자와 최종결재자는 초기에는 공란 -->
							<div class="approval-box">
								<h5>중간결재자</h5>
							</div>
							<div class="approval-box">
								<h5>최종결재자</h5>
							</div>
						</div>
						<form>
							<div class="form-group">
								<label for="documentType">문서종류</label> <select id="documentType"
									class="form-control">
									<option>초과근무신청서</option>
								</select>
							</div>

							<table id="approval-Table">

								<tbody>
									<tr>
										<th>기안자</th>
										<td>${loginEmployee.employeeName}</td>
										<th>부서</th>
										<td>${loginEmployee.departmentCode.departmentTitle}</td>
										<th>기안일</th>
										<td><input type="date" class="form-control" readonly></td>

									</tr>
									<tr>
										<th>제목</th>
										<td colspan="5"><input type="text" class="form-control"></td>

									</tr>
									<tr>
										<th>초과근무시작일</th>
							            <td><input type="datetime-local" class="form-control"></td>
							            <th>초과근무종료일</th>
							            <td><input type="datetime-local" class="form-control"></td>
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
										<th>참조자</th>
										<td colspan="3"><input type="text" id="addReferer"
											class="form-control" readonly></td>
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
							<div class="approval-box">
								<h5>기안자</h5>
								<div class="approval-content">
									<!-- 부서 제목과 직원 이름을 여기에 넣어야 함 -->
									<p id="draftDepartment">${loginEmployee.departmentCode.departmentTitle}</p>
									<p id="draftEmployee">${loginEmployee.employeeName}</p>
									<p id="draftDate">오늘날짜를 넣자 default</p>
								</div>
							</div>
							<!-- 중간결재자와 최종결재자는 초기에는 공란 -->
							<div class="approval-box">
								<h5>중간결재자</h5>
							</div>
							<div class="approval-box">
								<h5>최종결재자</h5>
							</div>
						</div>
						<form>
							<div class="form-group">
								<label for="documentType">문서종류</label> <select id="documentType"
									class="form-control">
									<option>경비지출신청서</option>
								</select>
							</div>

							<table id="itemTable">

								<tbody>
									<tr>
										<th>기안자</th>
										<td>${loginEmployee.employeeName}</td>
										<th>부서</th>
										<td>${loginEmployee.departmentCode.departmentTitle}</td>
										<th>기안일</th>
										<td><input type="date" class="form-control" readonly></td>

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
										<td><input type="text" id="addReferer"
											class="form-control" readonly></td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<th>첨부파일</th>
										<td colspan="5">
											<div class="input-group">
												<div class="custom-file">
													<input type="file" id="attachments"
														class="custom-file-input" multiple> <label
														class="custom-file-label" for="attachments">파일 선택</label>
												</div>
												<div class="input-group-append">
													<button type="button" class="btn btn-primary"
														id="attachButton">파일 선택</button>
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
										<td><input type="number"
											class="form-control item-quantity"></td>
										<td><input type="number" class="form-control item-price"></td>
										<td><input type="number" class="form-control item-amount"
											readonly></td>
										<td><input type="text" class="form-control item-remark"></td>
										<td><button type="button"
												class="btn btn-primary btn-add-row">+</button></td>
									</tr>
								</tbody>
								<tfoot>
									<tr class="table-active">
										<td colspan="5" class="text-right text-center"><strong>합계</strong></td>
										<td><input type="number" id="totalAmount" class="form-control form-control-plaintext text-center font-weight-bold"
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
							<div class="approval-box">
								<h5>기안자</h5>
								<div class="approval-content">
									<!-- 부서 제목과 직원 이름을 여기에 넣어야 함 -->
									<p id="draftDepartment">${loginEmployee.departmentCode.departmentTitle}</p>
									<p id="draftEmployee">${loginEmployee.employeeName}</p>
									<p id="draftDate">오늘날짜를 넣자 default</p>
								</div>
							</div>
							<!-- 중간결재자와 최종결재자는 초기에는 공란 -->
							<div class="approval-box">
								<h5>중간결재자</h5>
							</div>
							<div class="approval-box">
								<h5>최종결재자</h5>
							</div>
						</div>
						<form>
							<div class="form-group">
								<label for="documentType">문서종류</label> <select id="documentType" class="form-control">
									<option>출퇴근정정신청서</option>
								</select>
							</div>

							<table id="itemTable">

								<tbody>
									<tr>
										<th>기안자</th>
										<td>${loginEmployee.employeeName}</td>
										<th>부서</th>
										<td>${loginEmployee.departmentCode.departmentTitle}</td>
										<th>기안일</th>
										<td><input type="date" class="form-control" readonly></td>

									</tr>
									<tr>
										<th>제목</th>
										<td colspan="5"><input type="text" class="form-control"></td>

									</tr>
									<tr>
										<th>초과근무시작일</th>
							            <td><input type="datetime-local" class="form-control"></td>
							            <th>초과근무종료일</th>
							            <td><input type="datetime-local" class="form-control"></td>
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
										<th>참조자</th>
										<td colspan="3"><input type="text" id="addReferer"
											class="form-control" readonly></td>
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


		//문서 양식 나오게 하기
    	function showForm() {
			var selectedForm = document.getElementById('formType').value;
			var forms = document
					.getElementsByClassName('form-container');
			for (var i = 0; i < forms.length; i++) {
				forms[i].style.display = 'none';
			}
			if (selectedForm) {
				document.getElementById(selectedForm).style.display = 'block';
			}
		}

		//부서에 해당된 직원들 나타내보자
		function loadEmployees() {
		    var department = $('#department').val();
		    if (department) {
		        $.ajax({
		            url: '/getEmployees',
		            type: 'GET',
		            data: { department: department },
		            success: function(data) {
		                $('#approvers').empty();
		                $('#references').empty();
		                data.forEach(function(employee) {
		                    $('#approvers').append(`<option>${employee.name}</option>`);
		                    $('#references').append(`<option>${employee.name}</option>`);
		                });
		            },
		            error: function() {
		                alert('직원 로딩 중 오류가 발생했습니다.');
		            }
		        });
		    } else {
		        $('#approvers').empty();
		        $('#references').empty();
		    }
		}



	// 초기화 함수
	function initializeForm() {
	    let table = document.getElementById('itemTable');
	    let tbody = table.querySelector('tbody');
	    let addButton = table.querySelector('.btn-add-row');
	    let totalAmountInput = document.getElementById('totalAmount');

	    // 초기 행에 이벤트 리스너 추가
	    addEventListenersToRow(tbody.querySelector('tr'));

    addButton.addEventListener('click', function() {
        addTableRow();
    });


    function addTableRow() {
        let newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td><input type="text" class="form-control item-name"></td>
            <td><input type="text" class="form-control item-spec"></td>
            <td><input type="text" class="form-control item-unit"></td>
            <td><input type="number" class="form-control item-quantity"></td>
            <td><input type="number" class="form-control item-price"></td>
            <td><input type="number" class="form-control item-amount" readonly></td>
            <td><input type="text" class="form-control item-remark"></td>
            <td><button type="button" class="btn btn-danger btn-remove-row">-</button></td>
        `;

        tbody.appendChild(newRow);
        addEventListenersToRow(newRow);
    }

    function addEventListenersToRow(row) {
        let quantityInput = row.querySelector('.item-quantity');
        let priceInput = row.querySelector('.item-price');

        quantityInput.addEventListener('input', updateAmount);
        priceInput.addEventListener('input', updateAmount);
    }

    tbody.addEventListener('click', function(event) {
        if (event.target.classList.contains('btn-remove-row')) {
            let row = event.target.closest('tr');
            row.remove();
            updateTotalAmount();
        }
    });

    function updateAmount(event) {
        let row = event.target.closest('tr');
        let quantity = parseFloat(row.querySelector('.item-quantity').value) || 0;
        let price = parseFloat(row.querySelector('.item-price').value) || 0;
        let amount = quantity * price;
        row.querySelector('.item-amount').value = amount.toFixed(2);

        updateTotalAmount();
    }

    function updateTotalAmount() {
        let total = 0;
        document.querySelectorAll('.item-amount').forEach(function(input) {
            total += parseFloat(input.value) || 0;
        });
        totalAmountInput.value = total.toFixed(2);
    }

    // 초기 로드 시 한 번 합계를 계산
	updateTotalAmount();
	}

	document.addEventListener('DOMContentLoaded', initializeForm);



	/* $(document).ready(function() {
	    // 문서양식 선택 시
	    $('#formType').change(function() {
	        // 선택된 문서양식의 값을 가져옴
	        var selectedForm = $(this).val();
	        // 여기서 필요에 따라 선택된 양식에 따라 추가적인 처리 가능
	    });

	    // 부서 선택 시
	    $('#department').change(function() {
	        var department = $(this).val();
	        if (department) {
	            // 부서에 해당하는 직원들을 가져오는 AJAX 요청 (예시에서는 하드코딩)
	            var employees = [
	                { name: '직원1' },
	                { name: '직원2' },
	                { name: '직원3' }
	            ];
	            // 직원 목록을 오른쪽 섹션의 결재자 라인에 추가
	            appendApprovers(department, employees);
	        }
	    });

	    // 직원 목록을 오른쪽 섹션의 결재자 라인에 추가하는 함수
	    function appendApprovers(departmentTitle, employees) {
	        // 기안자 정보 업데이트
	        $('#draftDepartment').text(departmentTitle);
	        $('#draftEmployee').text(employees[0].name); // 기안자는 첫 번째 직원으로 설정

	        // 중간결재자와 최종결재자 초기화
	        $('.approval-line .approval-box:nth-child(n+2)').empty();

	        // 선택된 직원 수만큼 approval-box 생성
	        for (var i = 1; i < employees.length; i++) {
	            var employeeName = employees[i].name;
	            var newApproverBox = $('<div class="approval-box">' +
	                '<h5>중간결재자</h5>' +
	                '<div class="approval-content">' +
	                '<p>' + departmentTitle + '</p>' +
	                '<p>' + employeeName + '</p>' +
	                '</div>' +
	                '</div>');
	            $('.approval-line').append(newApproverBox);
	        }
	    }
	}); */


	 document.addEventListener('DOMContentLoaded', function() {
	        const attachButton = document.getElementById('attachButton');
	        const fileInput = document.getElementById('attachments');
	        const fileInputLabel = document.querySelector('.custom-file-label');

	        attachButton.addEventListener('click', function() {
	            fileInput.removeAttribute('disabled'); // 파일 선택 input 활성화
	            fileInput.click(); // 파일 선택 input을 클릭하여 파일 선택 창 열기
	        });

	        fileInput.addEventListener('change', function() {
	            // 파일이 선택되었을 때, 선택된 파일 이름을 표시
	            const selectedFiles = Array.from(fileInput.files).map(file => file.name).join(', ');
	            fileInputLabel.textContent = selectedFiles || '파일 선택';
	        });
	    });





</script>




<c:import url="${path }/WEB-INF/views/common/footer.jsp" />