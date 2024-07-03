<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>

<title>전체 결재 문서</title>

<!-- 필요한 CSS만 남기고 불필요한 CSS는 삭제 -->
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
        width: 14.28%
    }
    th {
        background-color: #f2f2f2;
    }

    #newApprovalBtn{
		margin-right:10px;
		width:150px;
    }

    .approvalStatusTable {
	    display: flex;
	    justify-content: center;
	    margin-top: 20px;
	}

	.approvalStatusTable > table {
	    width: 600px; /* 너비 설정 */
	    margin: 0 10px; /* 테이블 사이 간격 조절 */
	}

	.approvalStatusTable > span {
	    display: block;
	    text-align: center;
	    margin-bottom: 10px; /* span과 테이블 사이 간격 조절 */
	    font-weight: bold;
	}



    .search-bar {
        display: flex;
        padding-left: 10px;
        align-items: center;
        margin-top: 40px;
    }

    .search-bar select,
    .search-bar input {
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-right: 10px;
        transition: all 0.3s ease;
    }

    .search-bar select:focus,
    .search-bar input:focus {
        border-color: #4CAF50;
        outline: none;
        box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
    }

    .search-bar select {
        background-color: #fff;
        color: #333;
    }

    .search-bar input {
        width: 300px;
        max-width: 100%;
    }

    .search-bar button {
        padding: 10px 20px;
        font-size: 16px;
        background-color: #4CAF50;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .search-bar button:hover {
        background-color: #45a049;
    }


	.documentTitle {
	    display: flex;
	    justify-content: space-between;
	    align-items: center; /* 세로 중앙 정렬 */
	    margin-bottom: 20px; /* 아래 여백 추가 */
	}

	.documentTitle h3 {
	    margin-left: 10px; /* 제목의 기본 마진 제거 */

	}

	.documentList{
		margin-top:20px;
	}


	.status-table {
	    width: 300px; /* 너비 설정 */
	    margin: 0 10px; /* 테이블 사이 간격 조절 */
	}

	.table-title {
	    display: block;
	    text-align: center;
	    margin-bottom: 10px; /* span과 테이블 사이 간격 조절 */
	    font-weight: bold;
	}






    /* 모달 스타일 */
    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        position: relative;
    }

    .closeModal {
        color: #aaaaaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .closeModal:hover,
    .closeModal:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

    .modal-dialog {
        max-width: 800px;
    }

    .modal-body {
        padding: 20px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-control-sm {
        margin-bottom: 10px;
    }

    .recipient-list {
        margin-top: 10px;
        height:50px;
        width:100%;
        border:1px solid red;
        max-height: 200px; /* 원하는 최대 높이 설정 */
	    overflow-y: auto; /* 내용이 넘칠 경우 스크롤 표시 */
	    border: 1px solid #ccc; /* 시각적 구분을 위한 테두리 */
	    padding: 5px;
    }

    .recipient-list .recipient {
        display: inline-block;
        padding: 5px 10px;
        margin-right: 5px;
        background-color: #f0f0f0;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .recipient-list .recipient .closeModal {
        cursor: pointer;
        margin-left: 5px;
    }





    .Approver-container {
            display: flex;
            justify-content: space-between;
            margin: 20px;
        }
        .left-section {
            flex: 1;
            margin-right: 10px;
        }
        .middle-section {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .right-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            margin-left: 10px;
        }
        .recipient-list {
            max-height: 200px;
            overflow-y: auto;
            border: 1px solid #ccc;
            padding: 5px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .button-section {
            margin-top: 10px;
        }

        .middle-section {
            display: flex;
            gap: 80px; /* 버튼 사이의 간격 설정 */
            padding-top:19px;
        }



		 #employeeList {
            border: 1px solid #ccc; /* 테두리 설정 */
            height: 150px; /* 높이 설정 */
            width: 200px; /* 너비 설정 */
            margin-top: 10px; /* 위쪽 마진 설정 */
            padding: 10px; /* 안쪽 여백 설정 */
        }

         .btn-container {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .closeModal {
	        color: #000;
	        font-size: 24px;
	        line-height: 1;
	        opacity: 0.5;
	        transition: opacity 0.3s ease;
	    }

	    .closeModal:hover {
	        opacity: 1;
	    }

</style>

<body>
<div class="documentTitle">
    <h3>전체 결재 문서</h3>
    <button id="newApprovalBtn" class="btn btn-primary">작성하기</button>
</div>
    <div class="container mt-5">
        <!-- 전체 결재 문서 버튼 -->

        <!-- 모달 창 -->
        <div id="newApprovalModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="newApprovalModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="newApprovalModalLabel">결재선택</h5>
                        <button type="button" class="closeModal" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- 전자결재 양식 선택 -->
                        <div class="form-group">
                            <label for="formType">전자결재 양식 선택</label>
                            <select id="formType" class="form-control form-control-sm">
                                <option value="출장신청서">출장신청서</option>
                                <option value="휴가신청서">휴가신청서</option>
                                <option value="초과근무신청서">초과근무신청서</option>
                                <option value="경비지출신청서">경비지출신청서</option>
                                <option value="출퇴근신청서">출퇴근정정신청서</option>
                            </select>
                        </div>

						<div class="Approver-container">
							<div class="left-section">
								<!-- 결재자 선택 -->
								<div class="form-group">
									<label for="department">부서 선택</label>
									<select id="department" onchange="loadEmployees()">
										<option value="">부서를 선택하세요</option>
										<option value="인사팀">인사팀</option>
										<option value="개발팀">개발팀</option>
										<option value="영업팀">영업팀</option>
										<option value="경리팀">경리팀</option>
									</select>
									<div id="employeeList" style="margin-top: 10px;"></div>
								</div>
							</div>
							<div class="middle-section">
								<button type="button" onclick="addSelectedEmployees()">추가</button>
								<button type="button" onclick="addSelectedEmployees()">추가</button>
							</div>
							<div class="right-section">
								<div class="form-group">
									<label for="approver">결재자 선택</label>
									<div id="approver" class="recipient-list">
										<!-- 선택된 결재자 표시될 곳 -->
									</div>
								</div>
								<div class="form-group">
									<label for="referrer">참조자 선택</label>
									<div id="referrer" class="recipient-list">
										<!-- 선택된 참조자 표시될 곳 -->
									</div>
								</div>
							</div>
						</div>

						<div class="btn-container">
		                    <button type="button" class="btn btn-primary">저장</button>
		                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		                </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


<div class="approvalStatusTable">
    <span>결재함</span>
    <table border="1">
        <tr>
            <th>결재대기</th>
            <th> <!-- 대기 문서 수 --> </th>
        </tr>
        <tr>
            <th>결재진행</th>
            <th> <!-- 진행 문서 수 --> </th>
        </tr>
        <tr>
            <th>결재완료</th>
            <th> <!-- 완료 문서 수 --> </th>
        </tr>
    </table>

    <span>문서함</span>
    <table border="1">
        <tr>
            <th>완료문서</th>
            <th> <!-- 완료 문서 수 --> </th>
        </tr>
        <tr>
            <th>반려문서</th>
            <th> <!-- 반려 문서 수 --> </th>
        </tr>
        <tr>
            <th>임시저장문서</th>
            <th> <!-- 임시저장 문서 수 --> </th>
        </tr>
    </table>
</div>

<div class="search-bar">
    <select id="selectType">
        <option value="documentWait">결재대기</option>
        <option value="documentProcess">결재진행</option>
        <option value="documentDone">결재완료</option>
    </select>
    <input type="text" id="searchType" placeholder="검색어를 입력하세요" oninput="filterList()">
</div>

<table class="documentList" border="1">
    <thead>
        <tr>
            <th>결재번호</th>
            <th>제목</th>
            <th>기안자</th>
            <th>기안부서</th>
            <th>기안일</th>
            <th>결재일</th>
            <th>상태</th>
        </tr>
    </thead>
    <tbody id="approvalBody">
        <c:if test="${not empty approvalAll}">
            <c:forEach items="${approvalAll}" var="approval">
                <tr data-status="${approval.status}">
                    <td>${approval.approvalNo}</td>
                    <td>${approval.approvalTitle}</td>
                    <td>${approval.employeeName}</td>
                    <td>${approval.departmentName}</td>
                    <td>${approval.approvalDraftDate}</td>
                    <td>${approval.approverDate}</td>
                    <td>${approval.status}</td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty approvalAll}">
            <tr>
                <td colspan="7">
                    <p>조회된 결과가 없습니다.</p>
                </td>
            </tr>
        </c:if>
    </tbody>
</table>

</body>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    function filterList() {
        const selectType = document.getElementById('selectType').value;
        const searchType = document.getElementById('searchType').value.toLowerCase();
        const rows = document.querySelectorAll('#approvalBody tr');

        rows.forEach(row => {
            const status = row.getAttribute('data-status');
            const title = row.cells[1].textContent.toLowerCase();

            if (status === selectType && title.includes(searchType)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }


    // 모달 창 초기화 함수
    function initModal() {
        $('#formType').val('출장보고서'); // 초기 양식 선택
        $('#approver').empty(); // 결재자 목록 초기화
        $('#referrer').empty(); // 참조자 목록 초기화
        $('#referrerInput').val(''); // 참조자 입력창 초기화
    }

    // 작성하기 버튼 클릭 시 모달 창 열기
    $('#newApprovalBtn').click(function() {
        initModal(); // 모달 초기화
        $('#newApprovalModal').modal('show');
    });






 // 부서별 직원 데이터 (실제로는 서버에서 가져와야 함)
    const departmentEmployees = {
      '인사팀': ['김인사', '이인사', '박인사'],
      '개발팀': ['김개발', '이개발', '박개발'],
      '영업팀': ['김영업', '이영업', '박영업'],
      '경리팀': ['김경리', '이경리', '박경리']
    };

    function loadEmployees() {
    	  const department = document.getElementById('department').value;
    	  const employeeList = document.getElementById('employeeList');
    	  employeeList.innerHTML = '';

    	  if (department) {
    	    const employees = departmentEmployees[department];
    	    employees.forEach((employee, index) => {
    	      const checkbox = document.createElement('input');
    	      checkbox.type = 'checkbox';
    	      checkbox.id = `employee${index}`;
    	      checkbox.name = 'employee';
    	      checkbox.value = employee;

    	      const label = document.createElement('label');
    	      label.htmlFor = `employee${index}`;
    	      label.textContent = employee;

    	      // 체크박스에 대한 클릭 이벤트 리스너
    	      checkbox.addEventListener('click', (event) => {
    	        event.stopPropagation();
    	      });

    	      // 라벨에 대한 클릭 이벤트 리스너
    	      label.addEventListener('click', (event) => {
    	        event.preventDefault(); // 기본 동작 방지
    	        checkbox.checked = !checkbox.checked; // 체크박스 상태 토글
    	      });

    	      const wrapper = document.createElement('div');
    	      wrapper.appendChild(checkbox);
    	      wrapper.appendChild(label);
    	      employeeList.appendChild(wrapper);
    	    });
    	  }
    	}

    function isApproverAlreadyAdded(employeeName) {
    	  const approverList = document.getElementById('approver');
    	  return approverList.querySelector(`[data-employee="${employeeName}"]`) !== null;
    	}

    	function updateCheckboxState() {
    	  const checkboxes = document.querySelectorAll('input[name="employee"]');
    	  checkboxes.forEach((checkbox) => {
    	    if (isApproverAlreadyAdded(checkbox.value)) {
    	      checkbox.checked = true;
    	      checkbox.disabled = true;
    	    } else {
    	      checkbox.disabled = false;
    	    }
    	  });
    	}

    	function addSelectedEmployees() {
    	  const selectedEmployees = document.querySelectorAll('input[name="employee"]:checked:not(:disabled)');
    	  const approverList = document.getElementById('approver');
    	  let addedCount = 0;

    	  selectedEmployees.forEach((checkbox) => {
    	    const employeeName = checkbox.value;
    	    if (!isApproverAlreadyAdded(employeeName)) {
    	      const approverElement = document.createElement('div');
    	      approverElement.textContent = employeeName;
    	      approverElement.setAttribute('data-employee', employeeName);

    	      const removeButton = document.createElement('button');
    	      removeButton.textContent = '제거';
    	      removeButton.className = 'remove-approver';
    	      removeButton.onclick = function() {
    	        approverElement.remove();
    	        updateCheckboxState();
    	      };

    	      approverElement.appendChild(removeButton);
    	      approverList.appendChild(approverElement);
    	      addedCount++;
    	    }
    	  });

    	  updateCheckboxState();

    	  if (addedCount === 0) {
    	    alert("새로 추가된 직원이 없습니다. 이미 추가되었거나 선택되지 않았습니다.");
    	  } else {
    	    alert(`${addedCount}명의 직원이 결재자 목록에 추가되었습니다.`);
    	  }
    	}





</script>

<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>

