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






    /* 모달 스타일 개선 */
.modal-content {
    background-color: #ffffff;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    border: none;
}

.modal-header {
    background-color: #f8f9fa;
    border-bottom: 1px solid #e9ecef;
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
    padding: 20px 25px;
}

.modal-title {
    font-weight: 600;
    color: #333;
}

.modal-body {
    padding: 25px;
}

.closeModal {
    font-size: 28px;
    font-weight: 700;
    line-height: 1;
    color: #000;
    text-shadow: 0 1px 0 #fff;
    opacity: 0.5;
    transition: opacity 0.15s linear;
}

.closeModal:hover {
    opacity: 1;
}

/* 폼 요소 스타일 개선 */
.form-control, select {
    border-radius: 5px;
    border: 1px solid #ced4da;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.form-control:focus, select:focus {
    border-color: #80bdff;
    outline: 0;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

/* 버튼 스타일 개선 */
.btn {
    border-radius: 5px;
    font-weight: 500;
    transition: all 0.2s ease-in-out;
}

.btn-primary {
    background-color: #007bff;
    border-color: #007bff;
}

.btn-primary:hover {
    background-color: #0056b3;
    border-color: #0056b3;
}

.btn-secondary {
    background-color: #6c757d;
    border-color: #6c757d;
}

.btn-secondary:hover {
    background-color: #545b62;
    border-color: #4e555b;
}

/* 리스트 스타일 개선 */
.recipient-list {
    background-color: #f8f9fa;
    border-radius: 5px;
    padding: 10px;
    min-height: 150px;
}

.recipient {
    background-color: #e9ecef;
    border-radius: 20px;
    padding: 5px 15px;
    margin: 5px;
    display: inline-block;
    font-size: 14px;
}

/* 레이아웃 개선 */
.Approver-container {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
}

.left-section, .right-section {
    flex: 1;
    margin: 0 15px;
}

.middle-section {
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 20px;
}

/* 버튼 컨테이너 스타일 */
.btn-container {
    display: flex;
    justify-content: flex-end;
    margin-top: 30px;
    gap: 15px;
}

</style>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



<body>
<div class="documentTitle">
        <h3>전체 결재 문서</h3>
        <a href="<c:url value='/approval/newApproval.do' />">
            <button class="btn btn-primary">작성하기</button>
        </a>
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
            <c:forEach var="approval" items="${approvalAll}">
                <tr data-status="${approval.status}">
                    <td>${approval.approvalNo}</td>
                    <td>${approval.approvalTitle}</td>
                    <td>${approval.employeeNo.employeeName}</td>
                    <td>${approval.departmentCode.departmentTitle}</td>
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


<script>

</script>

<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>

