<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지출경의서</title>
    <style>
        /* 스타일 정의 */
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 80%;
            margin: 0 auto;
        }
        h1 {
            text-align: center;
        }
        .form-table, .form-table td, .form-table th {
            border: 1px solid #ddd;
            border-collapse: collapse;
        }
        .form-table {
            width: 100%;
            margin-bottom: 20px;
        }
        .form-table th, .form-table td {
            padding: 8px;
            text-align: left;
        }
        .form-section {
            margin-bottom: 20px;
        }
        .form-section h2 {
            margin-bottom: 10px;
        }
        .form-section input, .form-section select, .form-section textarea {
            width: calc(100% - 20px);
            margin: 5px 0;
            padding: 8px;
        }
        .buttons {
            text-align: center;
        }
        .buttons button {
            padding: 10px 20px;
            margin: 5px;
            cursor: pointer;
        }
        .hidden {
            display: none;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <h1>지출경의서</h1>
        <form id="expenseForm">
            <div class="form-section">
                <table class="form-table">
                    <tr>
                        <th>문서유형</th>
                        <th>제목</th>
                        <td><input type="text" name="title" value="documentTitle"></td>
                        <th>보존연한</th>
                        <td>
                            <select name="approvalDocPeriod">
                                <option value="1month">1개월</option>
                                <option value="3months">3개월</option>
                                <option value="6months">6개월</option>
                                <option value="1year">1년</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- 비품 지출 신청서 양식 -->
            <div id="expenseFormSection" class="form-section">
                <table class="form-table">
                    <tr>
                        <th>첨부파일</th>
                        <td colspan="5">
                            <input type="file" name="attachment">
                        </td>
                    </tr>
                    <tr>
                        <th>참조자</th>
                        <td colspan="5">
                            <select name="reference" id="referenceSelect"></select>
                            <button onclick="addReference()">+</button>
                        </td>
                    </tr>
                </table>

                <table class="form-table">
                    <thead>
                        <tr>
                            <th>품번</th>
                            <th>품명</th>
                            <th>규격</th>
                            <th>단위</th>
                            <th>수량</th>
                            <th>단가</th>
                            <th>금액</th>
                            <th>비고</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td><input type="text" name="itemName1"></td>
                            <td><input type="text" name="spec1"></td>
                            <td><input type="text" name="unit1"></td>
                            <td><input type="text" name="quantity1"></td>
                            <td><input type="text" name="price1"></td>
                            <td><input type="text" name="amount1" readonly></td>
                            <td><input type="text" name="remark1"></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td><input type="text" name="itemName2"></td>
                            <td><input type="text" name="spec2"></td>
                            <td><input type="text" name="unit2"></td>
                            <td><input type="text" name="quantity2"></td>
                            <td><input type="text" name="price2"></td>
                            <td><input type="text" name="amount2" readonly></td>
                            <td><input type="text" name="remark2"></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td><input type="text" name="itemName3"></td>
                            <td><input type="text" name="spec3"></td>
                            <td><input type="text" name="unit3"></td>
                            <td><input type="text" name="quantity3"></td>
                            <td><input type="text" name="price3"></td>
                            <td><input type="text" name="amount3" readonly></td>
                            <td><input type="text" name="remark3"></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td><input type="text" name="itemName4"></td>
                            <td><input type="text" name="spec4"></td>
                            <td><input type="text" name="unit4"></td>
                            <td><input type="text" name="quantity4"></td>
                            <td><input type="text" name="price4"></td>
                            <td><input type="text" name="amount4" readonly></td>
                            <td><input type="text" name="remark4"></td>
                        </tr>
                    </tbody>
                </table>

                <table class="form-table">
                    <tr>
                        <th>구매 사유</th>
                        <td colspan="5">
                            <textarea name="purchaseReason" rows="5" placeholder="내용을 입력해주세요"></textarea>
                        </td>
                    </tr>
                </table>

                <table class="form-table">
                    <tr>
                        <th>특이사항</th>
                        <td colspan="5">
                            <textarea name="specialNotes" rows="5" placeholder="내용을 입력해주세요"></textarea>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- 다른 지출 신청서 양식 -->
            <div id="equipmentFormSection" class="form-section hidden">
                <table class="form-table">
                    <tr>
                        <th>장비명</th>
                        <td><input type="text" name="equipmentName"></td>
                    </tr>
                    <tr>
                        <th>수량</th>
                        <td><input type="number" name="equipmentQuantity"></td>
                    </tr>
                    <tr>
                        <th>설명</th>
                        <td><textarea name="equipmentDescription" rows="4"></textarea></td>
                    </tr>
                </table>
            </div>

            <div class="buttons">
                <button type="submit">작성완료</button>
                <button type="reset">취소</button>
            </div>
        </form>
    </div>

    <script>
        function addReference() {
            var referenceSelect = document.getElementById('referenceSelect');
            var option = document.createElement('option');
            option.text = '참조자 추가'; // 실제 참조자 이름으로 변경
            referenceSelect.add(option);
        }
    </script>



</body>
</html>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>
    <!-- <script>
        $(document).ready(function() {
            function toggleForm() {
                var documentType = $("#documentType").val();
                if (documentType === "expense") {
                    $("#expenseFormSection").removeClass("hidden");
                    $("#equipmentFormSection").addClass("hidden");
                } else if (documentType === "equipment") {
                    $("#expenseFormSection").addClass("hidden");
                    $("#equipmentFormSection").removeClass("hidden");
                }
            }

            $("#documentType").change(function() {
                toggleForm();
            });



            function addReference() {
                var selectBox = document.getElementById("referenceSelect");
                var selectedValue = selectBox.value;
                var selectedText = selectBox.options[selectBox.selectedIndex].text;

                var referenceList = document.getElementById("referenceList");
                var newOption = document.createElement("option");
                newOption.value = selectedValue;
                newOption.text = selectedText;
                referenceList.appendChild(newOption);





    </script> -->
