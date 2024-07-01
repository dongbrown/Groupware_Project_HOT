<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!DOCTYPE html>
<html>
<style>
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}

body{
    font-family: 'Pretendard-Regular';
    /* position: relative; */
    background-image: url("https://images.unsplash.com/photo-1558591710-4b4a1ae0f04d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
    background-size: 100%;
    z-index: 500;
}

header{
    position: relative;
    z-index:1000;
}

th{
    white-space: nowrap;
}
/* 메인 헤더 css */
.sideHeader {
    margin: 15px;
    width: 80px;     /*조정시 서브 카테고리 left도 조정해줘야함. */
    height: 96.5vh;
    overflow: hidden;
    transition: width 0.3s;
    position: fixed;
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
}

#sideHeader-sub {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    height: 80%; /* 전체 높이 중 메뉴들이 차지하는 비율 */
}
#sideHeader > div {
    margin: 10px 0; /* 각 메뉴 사이의 간격 */
    text-decoration: none;


    color: white;
}

#sideHeader1 {
    background-color: rgb(0, 57, 100);
    left: 0;

}

.headerContent{
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    color: white;
    opacity: 0.5;
    transition: all 0.3s ease-in-out;
}
.headerContent:hover{
    opacity: 1;
    transform: scale(1.2);
}

/* 메인 헤더 호버시 서브 카테고리 나오는 창 */
.sideHeader-sub {
    z-index:1000;
    width: 65px;
    margin-left: 15px;
    height: 96.5vh;
    overflow: hidden;
    position: fixed;
    border-radius: 20px;
    background-color: rgba(255, 255, 255, 0.387);
    backdrop-filter: blur(10px);
    left: 80px;
    top:15px;
}
/* 메일 카테고리 css */

#mail-category:hover +#mailWrap{
    display: block;
    width: 400px;
}
#mailWrap:hover{
    /* display: block; */
    width: 400px;
}

#mailWrap{
    /* display: none; */
    width: 0px;
    transition: width 0.3s ease-in-out;
}

#mailContent{
    font-family: 'Pretendard-Regular';
    font-size: 20px;
    text-align: center;
}

/* 프로젝트 카테고리 css */
#project-category:hover +#projectWrap{
    display: block;
    width: 400px;
}
#projectWrap:hover{
    /* display: block; */
    width: 400px;
}

#projectWrap{
    /* display: none; */
    width: 0px;
    transition: width 0.3s ease-in-out;
}

#projectContent{
    font-family: 'Pretendard-Regular';
    font-size: 20px;
    text-align: center;
}

/* 전자결재 카테고리 css */
#approval-category:hover +#approvalWrap{
    display: block;
    width: 400px;
}
#approvalWrap:hover{
    /* display: block; */
    width: 400px;
}

#approvalWrap{
    /* display: none; */
    width: 0px;
    transition: width 0.3s ease-in-out;
}

#approvalContent{
    font-family: 'Pretendard-Regular';
    font-size: 20px;
    text-align: center;
}

/* 켈린더 카테고리 css */
#calender-category:hover +#calenderWrap{
    display: block;
    width: 400px;
}
#calenderWrap:hover{
    /* display: block; */
    width: 400px;
}

#calenderWrap{
    /* display: none; */
    width: 0px;
    transition: width 0.3s ease-in-out;
}

#calenderContent{
    font-family: 'Pretendard-Regular';
    font-size: 20px;
    text-align: center;
}

/* 커뮤니티 카테고리 css */
#community-category:hover +#communityWrap{
    display: block;
    width: 400px;
}
#communityWrap:hover{
    /* display: block; */
    width: 400px;
}

#communityWrap{
    /* display: none; */
    width: 0px;
    transition: width 0.3s ease-in-out;
}

#communityContent{
    font-family: 'Pretendard-Regular';
    font-size: 20px;
    text-align: center;
}

/* 채팅 카테고리 css */
#chat-category:hover +#chatWrap{
    display: block;
    width: 400px;
}
#chatWrap:hover{
    /* display: block; */
    width: 400px;
}

#chatWrap{
    /* display: none; */
    width: 0px;
    transition: width 0.3s ease-in-out;
}

#chatContent{
    font-family: 'Pretendard-Regular';
    font-size: 20px;
    text-align: center;
}


/* 인사 카테고리 css */
#insa-category:hover +#insaWrap{
    display: block;
    width: 400px;
}
#insaWrap:hover{
    /* display: block; */
    width: 400px;
}

#insaWrap{
    /* display: none; */
    width: 0px;
    transition: width 0.3s ease-in-out;
}

#insaContent{
    font-family: 'Pretendard-Regular';
    font-size: 20px;
    text-align: center;
}


/* index css ------------------------------------------------------------------------------ */
#main-wrap{
    position: fixed;
    left: 110px;
    width: 93.5%;
    margin: 15px 0;
    height: 96.5vh;
    background-color: rgba(255, 255, 255, 0.511);
    backdrop-filter: blur(10px);
    display: flex;
    border-radius: 20px;

}

/* 첫번째 줄 css */
#first-wrap{
    display: flex;
    flex-direction: column;
    width: 15%;
    padding: 10px;
}
/* 호버시 크키 커지는 css */
#first-wrap>div{
    transition: all 0.3s
}
#first-wrap>div:hover{
    transform: scale(1.05);
}
/* 1-1 */
#member-card{
    position: relative;
    width: 100%;
    height: 40%;
    border-radius: 15px;
    background-color: rgb(0, 57, 100);
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    color: white;
}
/* 프로필 사진 */
#member-card-profile{
    background-image: url("https://i.imgur.com/WDQ52RE.png");
    background-size: 100% 100%;
    border-radius: 1000px;
    width: 150px;
    height: 150px;
}

/* 프로필 체인지 버튼 */
#changeBtn{
    position: absolute;
   top:15px;
   right: 15px;
   cursor: pointer;
}
#changeBtn:hover{
    animation: rotate 4s linear infinite;
}
@keyframes rotate {
    from {
        transform: rotate(0deg); /* 초기 상태 */
    }
    to {
        transform: rotate(360deg); /* 최종 상태 */
    }
}


/* 프로필 하단 버튼 박스 */
#member-card-mail{
 display: flex;
 width: 50%;
 justify-content: center;
 align-items: center;
 justify-content: space-between;
 margin-top: 30px;
}
#member-card-mail>div{
opacity: 0.5;
}
#member-card-mail>div:hover{
opacity: 1;
}

/* 1-2 */
#approval-card{
    margin-top:10px ;
    width: 100%;
    height: 15%;
    border-radius: 15px;
    background-color: white;
}
/* 1-3 */
#search-card{
    margin-top:10px ;
    width: 100%;
    height: 15%;
    border-radius: 15px;
    border: 3px solid rgb(0, 57, 100);
}
/* 1-4 */
#mail-card{
    margin-top:10px ;
    width: 100%;
    height: 27%;
    border-radius: 15px;
    background-color: white;
}

/* 두번째 줄 css */
#second-wrap{
    width: 50%;
    display: flex;
    flex-direction: column;
    padding: 10px;
}

/* 호버시 크키 커지는 css */
#second-wrap>div{
    transition: all 0.3s
}
#second-wrap>div:hover{
    transform: scale(1.03);
}

/* 2-1 */
#board-card{
    width: 100%;
    height: 35%;
    border-radius: 15px;
    background-color: rgba(255, 255, 255, 0.387);
    backdrop-filter: blur(10px);
}

/* 2-2 */
#project-card{
    margin-top: 10px;
    width: 100%;
    height: 40%;
    border-radius: 15px;
    background-color: rgba(255, 255, 255, 0.387);
    backdrop-filter: blur(10px);
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 15px;
}

/* 2-2-* */
#project-card>div{
    margin: 10px;
    width: 48%;
    height: 100%;
    border: 1px solid red;
    transition: all 0.3s
}

#project-card>div:hover{
    transform: scale(1.07);
}

#agenda-card{
    margin-top: 10px;
    width: 100%;
    height: 25%;
    border-radius: 15px;
    background-color: rgba(255, 255, 255, 0.387);
    backdrop-filter: blur(10px);
}




/* 세번째 줄 css */
#third-wrap{
    width: 35%;
    display: flex;
    flex-direction: column;
    padding: 10px;
}

/* 호버시 크키 커지는 css */
#third-wrap>div{
    transition: all 0.3s
}
#third-wrap>div:hover{
    transform: scale(1.03);
}

/* 3-1 */
#calender-card{
    width: 100%;
    height: 30%;
    border-radius: 15px;
    background-color: rgba(255, 255, 255, 0.387);
    backdrop-filter: blur(10px);
}

/* 3-2 */
#today-work-card{
    margin-top: 10px;
    width: 100%;
    height: 15%;
    border-radius: 15px;
    background-color: rgba(255, 255, 255, 0.387);
    backdrop-filter: blur(10px);
}

/* 3-3 */
#banner-card{
    margin-top: 10px;
    width: 100%;
    height: 25%;
    border-radius: 15px;
    background-color: rgba(255, 255, 255, 0.387);
    backdrop-filter: blur(10px);
}

/* 3-4 */
#menu-card{
    margin-top: 10px;
    width: 100%;
    height: 30%;
    border-radius: 15px;
    background-color: rgba(255, 255, 255, 0.387);
    backdrop-filter: blur(10px);
}

/* 프로젝트 생성 모달창 css */

/* 사원 조회 div */
#input-member-title{
    margin-top: 15px;
    margin-right: 15px;
    width: 300px;
    max-height: 200px;

}

#input-member-title>div{
    display: block;
}

#input-member-list{
    display: flex;
    flex-direction: column;
    height: 300px;
    overflow: scroll;
}

/* 저장 출력된 사원 div */
#checked-member-wrab{
    display: flex;
    align-items: center;
    font-weight: bolder;
    justify-content: center;
    justify-content: space-evenly;
    margin-top: 5px;
    height: 30px;
    width: 300px;
    background-color: rgb(222, 222, 222);
    border-radius: 100px;
}

#member-save-btn{
    margin-top: 10px;
}

.project-choice{
    cursor: pointer;
}

/* 프로젝트 수정 목록 css */
#projectListTable{
    width: 90%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 0;
}
#modal-size1{
    display: flex;
    justify-content: center;
    align-items: center;
}
/* 그래프 표시 */
.graph-container {
    width: 100%;
    display: flex;

}

.bar {
    width: 0;
    background-color: #1b35ffe3;
    margin: 10px 0;
    border-radius: 100px;
    overflow: hidden;
    height: 15px;
    transition: width 2s ease-in-out;
}


/* 작업 모달  css */
#work-contents{
    display: flex;
    flex-direction: column;
    justify-content: end;
}

#project-contents{
    display: flex;
    flex-direction: column;
    justify-content: end;
}
</style>
<head>
<meta charset="EUC-KR">
<title>H.O.T 그룹웨어</title>
</head>
<!-- 프로젝트 생성 모달 창 -->
    <!-- create Modal -->
    <div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="createModalLabel" aria-hidden="true">
    <div id="modal-size" class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
        <h1 class="modal-title fs-5" id="createModalLabel">프로젝트 생성</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
    <div style="display: flex; flex-direction: row;">
        <div class="modal-body">
        <!-- 프로젝트 이름 -->
        <div class="input-group mb-3">
            <span class="input-group-text" id="inputGroup-sizing-default">프로젝트 이름</span>
            <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
            </div>
            <!-- 프로젝트 생성자 이름 -->
            <div class="input-group mb-3">
            <span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
            <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" value="홍길동" disabled>
            </div>
            <!-- 프로젝트 중요도 체크박스  -->
            <div class="input-group mb-3">
                <span class="input-group-text" id="inputGroup-sizing-default">프로젝트 중요도</span>
                <select class="form-select" aria-label="Default select example">
                    <option selected>선택하세요.</option>
                    <option value="1" style="color: red;">상</option>
                    <option value="2" style="color: rgb(255, 132, 0);">중</option>
                    <option value="3" style="color: green;">하</option>
                  </select>
            </div>
            <!-- 프로젝트 설명 -->
            <p style="font-weight: bolder;">프로젝트 설명</p>
            <div id="project-contents" class="form-floating">
            <textarea id="floatingTextarea-project" class="form-control" placeholder="Leave a comment here" id="floatingTextarea"></textarea>
            <label for="floatingTextarea">프로젝트 설명</label>
            <span id="project-contents-count" style="margin-left: auto;">0/1000</span>
            </div>
            <script>
                // 설명  text 크기 카운트
                $('#floatingTextarea-project').on('input', function() {
                    let textLength = $(this).val().length;
                    $('#project-contents-count').text(textLength + '/1000');
                });
            </script>
            <!-- 프로젝트 종료 예정일 -->
             <br>
            <div>
                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">프로젝트 종료일</span>
                    <select id="year" class="form-select" aria-label="Year" required>
                        <option value="" selected>년</option>
                        <!-- 연도 옵션 추가  올해와 내년만 출력되게 설정-->
                        <script>
                               const currentYear = new Date().getFullYear();
                                const nextYear = currentYear + 1;

                                for (let year = currentYear; year <= nextYear; year++) {
                                    $('#year').append('<option value="' + year + '">' + year + '</option>');
                                };
                        </script>
                    </select>
                    <select id="month" class="form-select" aria-label="Month" required>
                        <option value="" selected>월</option>
                        <!-- 월 옵션 추가 -->
                        <script>
                            for (let month = 1; month <= 12; month++) {
                                $('#month').append('<option value="' + month + '">' + month + '</option>');
                            }
                        </script>
                    </select>
                    <select id="day" class="form-select" aria-label="Day" required>
                        <option value="" selected>일</option>
                        <!-- 일 옵션 추가 -->
                        <script>
                            for (let day = 1; day <= 31; day++) {
                                $('#day').append('<option value="' + day + '">' + day + '</option>');
                            }
                        </script>
                    </select>
                </div>
            </div>
            <br>
            <!-- 프로젝트 배정 예산 -->
            <div class="input-group mb-3">
                <span class="input-group-text" id="inputGroup-sizing-default">배정예산</span>
                <input type="text" id="project-budget" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" placeholder="입력하세요.">
                </div>
            <script>
                $('#project-budget').keyup(e=>{
                    let value = e.target.value;
                    let value1 = value.replace(/,/g,'');
                    let result = Number(value1).toLocaleString('ko-KR');
                    e.target.value=result;
                });

            </script>

            <br>
            <!--  최대 참여 인원(수)-->
            <div id="member-list" style="display: flex; flex-direction: row;">
                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">총 인원</span>
                    <input id="totalMember" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" value="1" disabled>
                    </div>

                <div class="input-group mb-3" style="margin-left: 20px;">
                    <span class="input-group-text" id="inputGroup-sizing-default">부서</span>
                    <select id="select-dept" class="form-select" aria-label="Default select example">
                        <option selected>선택하세요.</option>
                        <option value="개발1팀">개발1팀</option>
                        <option value="개발2팀">개발2팀</option>
                        <option value="개발3팀">개발3팀</option>
                        <option value="홍보팀">홍보팀</option>
                        <option value="디자인1팀">디자인1팀</option>
                        <option value="디자인2팀">디자인2팀</option>
                    </select>
                </div>
            </div>
            <!-- 체크한 사원 추가 div -->
            <div id="saved-members"></div>

        </div>
                <!-- 사원 조회 생성 -->
        <div id="input-member"></div>
    </div>


        <script>
            $(document).ready(function() {
                let checkedTotalCount = 1;

            $('#select-dept').on('change', function() {
                const selectedText = $("#select-dept option:selected").val();
                const inputMember = $("#input-member");
                //선택하세요 선택시 맴버 비워주기
                if(selectedText === '선택하세요.'){
                    inputMember.text('');
                }else{
                    inputMember.empty();

                    const inputDept = $('<div>', { id:'input-member-title'});
                    const inputMemberList = $('<div>', { id: 'input-member-list' });
                    const inputMemberTitle = $('<div>', { text: selectedText, class: 'input-group-text' });
                    const memberSaveBtn = $('<button>', {id:'member-save-btn', class:'btn btn-primary', text:"저장"})

                    // 부서 선택시 모달창 가로폭 늘어나는 코드
                    $("#modal-size").addClass('modal-lg');

                    inputDept.append(inputMemberTitle);
                    inputMember.append(inputDept);
                    inputMember.append(inputMemberList);
                    inputMember.append(memberSaveBtn);

                    for (let i = 0; i < 10; i++) {
                        const checkboxId = 'flexCheckDefault' + i;
                        const inputMemberWrab = $('<div>');
                        const inputMemberDetail = $('<input>', { class: 'form-check-input', type: 'checkbox', id: checkboxId });
                        const inputMemberDetailText = $('<label>', { class: 'form-check-label', for: checkboxId, text:selectedText + ': 홍길동 사번 / ' +i+"12341234"});

                        // 이미 선택된 항목인지 확인
                        if($('#saved-members').find('.saved-item:contains("' + inputMemberDetailText.text() + '")').length > 0) {
                            inputMemberDetail.prop('checked', true);
                        }

                        inputMemberWrab.append(inputMemberDetail);
                        inputMemberWrab.append(inputMemberDetailText);
                        inputMemberList.append(inputMemberWrab);
                    }
                }

                // 저장버튼 누르면 체크된 직원들 추가

                $('#member-save-btn').on('click', function() {
                    const checkedItems = $('#input-member-list input:checked');
                    const savedMembers = $('#saved-members');

                    checkedItems.each(function() {
                        const label = $(this).next('label').text();
                        const totalMember = 0;
                        checkedTotalCount++;
                        // 이미 존재하는 항목인지 확인
                        if(savedMembers.find('.saved-item:contains("' + label + '")').length > 0) {
                            checkedTotalCount--;
                            return true; // continue to next iteration
                        }
                        $("#totalMember").val(checkedTotalCount);


                        const checkedMembersDel = $('<button>', {class:'btn-close', type:'button'});
                        const savedItem = $('<div>', { text: label, id:'checked-member-wrab', class:'saved-item' });
                        savedItem.append(checkedMembersDel);
                        savedMembers.append(savedItem);
                    });
                });
            });
            // debugger;
            // x 버튼 클릭 시 해당 항목 삭제

            $(document).on('click', '.btn-close', function() {
                $(this).closest('.saved-item').remove();
                // 총 인원수 차감 출력
                checkedTotalCount--;
                $("#totalMember").val(checkedTotalCount);
                // 삭제된 항목의 체크박스 해제
                const removedText = $(this).parent().text();
                $('#input-member-list input:checkbox').each(function() {
                    if($(this).next('label').text() === removedText) {
                        $(this).prop('checked', false);

                    }
                });
            });
        });
            </script>

                    <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary">프로젝트 생성</button>
                    </div>
                </div>
                </div>
            </div>
     <!-- ------------------ -->







     <!-- 프로젝트 수정 모달 창 -->
            <!-- Modal -->
    <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
        <div id="modal-size" class="modal-dialog modal-lg">
            <div class="modal-content align-items-center justify-content-center">

                    <p style="font-weight: bolder; font-size: 20px; margin-top: 20px;">프로젝트 목록</p>

                <div id="projectListTable" class="table-responsive">
                    <div>

                        <table class="table text-start align-middle table-bordered table-hover mb-0"  style="text-align: center;">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col">날짜</th>
                                    <th scope="col">번호</th>
                                    <th scope="col">담당자</th>
                                    <th scope="col">프로젝트 제목</th>
                                    <th scope="col" style="width: 300px;">진행률</th>
                                    <th scope="col">삭제</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="project-choice">
                                    <td>01 Jan 2045</td>
                                    <td>1</td>
                                    <td>김동훈</td>
                                    <td>프로젝트 제목 01</td>
                                    <td>
                                        <div class="graph-container">
                                            <div class="bar" data-percentage="55"></div>
                                            <div style="margin-top: 5px;"> 55%</div>
                                        </div>
                                    </td>
                                    <td><a class="btn btn-sm btn-danger" href="">삭제</a></td>
                                </tr>
                                <tr class="project-choice">
                                    <td>01 Jan 2045</td>
                                    <td>2</td>
                                    <td>김명준</td>
                                    <td>프로젝트 제목 02</td>
                                    <td>
                                        <div class="graph-container">
                                            <div class="bar" data-percentage="30"></div>
                                            <div style="margin-top: 5px;"> 30%</div>
                                        </div>
                                    </td>
                                    <td><a class="btn btn-sm btn-danger" href="">삭제</a></td>
                                </tr>
                                <tr class="project-choice">
                                    <td>01 Jan 2045</td>
                                    <td>3</td>
                                    <td>최선웅</td>
                                    <td>프로젝트 제목 03</td>
                                    <td>
                                        <div class="graph-container">
                                            <div class="bar" data-percentage="80"></div>
                                            <div style="margin-top: 5px;"> 80%</div>
                                        </div>
                                    </td>
                                    <td><a class="btn btn-sm btn-danger" href="">삭제</a></td>
                                </tr>
                                <tr class="project-choice">
                                    <td>01 Jan 2045</td>
                                    <td>4</td>
                                    <td>임성욱</td>
                                    <td>프로젝트 제목 04</td>
                                    <td>
                                        <div class="graph-container">
                                            <div class="bar" data-percentage="50"></div>
                                            <div style="margin-top: 5px;"> 50%</div>
                                        </div>
                                    </td>
                                    <td><a class="btn btn-sm btn-danger" href="">삭제</a></td>
                                </tr>
                                <tr class="project-choice">
                                    <td>01 Jan 2045</td>
                                    <td>5</td>
                                    <td>고재현</td>
                                    <td>프로젝트 제목 05</td>
                                    <td>
                                        <div class="graph-container">
                                            <div class="bar" data-percentage="90"></div>
                                            <div style="margin-top: 5px;">90%</div>
                                        </div>
                                    </td>
                                    <td><a class="btn btn-sm btn-danger" href="">삭제</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <br>
                    <!-- 페이징 처리 예정 -->
                    <div class="btn-toolbar mb-3" role="toolbar" aria-label="Toolbar with button groups" style="display: flex; justify-content: center;">
                        <div class="btn-group me-2" role="group" aria-label="First group">
                            <button type="button" class="btn btn-secondary">prev</button>
                            <button type="button" class="btn btn-outline-secondary">1</button>
                            <button type="button" class="btn btn-outline-secondary">2</button>
                            <button type="button" class="btn btn-outline-secondary">3</button>
                            <button type="button" class="btn btn-outline-secondary">4</button>
                            <button type="button" class="btn btn-secondary">next</button>
                        </div>
                        </div>
                    <script>
                        $(".project-choice").click(e=>{
                            const projectNo = e.target.parentElement.children[1].textContent;
                            console.log(projectNo); // 프로젝트 고유번호 넘겨서 프로젝트 수정페이지로 이동
                            location.assign("/final/projectupdate.html?projectNo="+projectNo);

                        });
                        $(document).ready(function() {
                        $("#updateProject").click(e=>{
                        // 진행도 애니메이션
                            const bars = document.querySelectorAll('.bar');
                            bars.forEach(bar => {
                                const percentage = bar.getAttribute('data-percentage');
                                setTimeout(() => {
                                    bar.style.width = `${percentage}%`;
                                }, 300);// 속도 조절
                            });
                        });
                    });
                    </script>
            </div>
        </div>
    </div>
            <!-- ------------------------------------------------------------------------------- -->




            <!-- 프로젝트 -- 작업 생성 모달 창 -->
    <!-- create Modal -->
    <div class="modal fade" id="createWorkModal" tabindex="-1" aria-labelledby="createWorkModalLabel" aria-hidden="true">
        <div id="modal-size" class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="createWorkModalLabel">작업 생성</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div style="display: flex; flex-direction: row;">
                    <div class="modal-body">
                        <!-- 프로젝트 이름 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="inputGroup-sizing-default">프로젝트 이름</span>
                            <input type="text" class="form-control" aria-label="Sizing example input"
                                aria-describedby="inputGroup-sizing-default" disabled>
                        </div>
                        <!-- 프로젝트 생성자 이름 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="inputGroup-sizing-default">프로젝트 담당자</span>
                            <input type="text" class="form-control" aria-label="Sizing example input"
                                aria-describedby="inputGroup-sizing-default" value="홍길동" disabled>
                        </div>
                        <hr style="border: 1.5px solid rgb(9, 9, 87);">
                        <!-- 작업 이름 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="inputGroup-sizing-default">작업 이름</span>
                            <input type="text" class="form-control" aria-label="Sizing example input"
                                aria-describedby="inputGroup-sizing-default">
                        </div>
                        <!-- 작업 생성자 이름 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="inputGroup-sizing-default">작업 담당자</span>
                            <input type="text" class="form-control" aria-label="Sizing example input"
                                aria-describedby="inputGroup-sizing-default" value="김명준" disabled>
                        </div>

                        <!-- 작업 설명 -->
                        <p style="font-weight: bolder;">작업 설명</p>
                        <div id="work-contents" class="form-floating">
                            <textarea class="form-control" placeholder="Leave a comment here"
                                id="floatingTextarea-work"></textarea>
                            <label for="floatingTextarea">작업 설명</label>
                            <span id="work-contents-count" style="margin-left: auto;">0/1000</span>
                        </div>

                        <script>
                            // 설명  text 크기 카운트
                            $('#floatingTextarea-work').on('input', function() {
                                let textLength = $(this).val().length;
                                $('#work-contents-count').text(textLength + '/1000');
                            });
                        </script>
                        <!-- 작업 종료 예정일 -->
                        <br>
                        <div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">작업 종료일</span>
                                <select id="year" class="form-select" aria-label="Year" required>
                                    <option value="" selected>년</option>
                                    <!-- 연도 옵션 추가 올해와 내년만 출력되게 설정-->
                                    <script>
                                        const currentYear1 = new Date().getFullYear();
                                        const nextYear1 = currentYear + 1;

                                        for (let year = currentYear; year <= nextYear; year++) {
                                            $('#year').append('<option value="' + year + '">' + year + '</option>');
                                        };
                                    </script>
                                </select>
                                <select id="month" class="form-select" aria-label="Month" required>
                                    <option value="" selected>월</option>
                                    <!-- 월 옵션 추가 -->
                                    <script>
                                        for (let month = 1; month <= 12; month++) {
                                            $('#month').append('<option value="' + month + '">' + month + '</option>');
                                        }
                                    </script>
                                </select>
                                <select id="day" class="form-select" aria-label="Day" required>
                                    <option value="" selected>일</option>
                                    <!-- 일 옵션 추가 -->
                                    <script>
                                        for (let day = 1; day <= 31; day++) {
                                            $('#day').append('<option value="' + day + '">' + day + '</option>');
                                        }
                                    </script>
                                </select>
                            </div>
                        </div>
                        <br>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary">프로젝트 생성</button>
                </div>
            </div>
        </div>
    </div>






<header>
    <!-- 메인 카테고리 -->
    <div id="sideHeader1" class="sideHeader">
        <div id="sideHeader-sub">
            <!-- 메인 == 메일 카테고리 -->
            <div id="mail-category" class="headerContent"><a href=""><img src="https://i.imgur.com/c0Ze4Y2.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
                <div id="mailWrap" class="sideHeader-sub">
                        <table id="mailContent" class="table table-dark table-hover">
                            <tr><th style="white-space: nowrap;">메일 보내기</th></tr>
                            <tr><th>수신 메일함</th></tr>
                            <tr><th>발신 메일함</th></tr>
                            <tr><th>메일 보관함</th></tr>
                            <tr><th>휴지통</th></tr>
                        </table>
                </div>
            <!-- 메인 == 프로젝트 카테고리 -->
                <div id="project-category" class="headerContent"><a href=""><img src="https://i.imgur.com/8yHARRe.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
                <div id="projectWrap" class="sideHeader-sub">
                    <table id="projectContent" class="table table-dark table-hover">
                        <tr><th>전체 프로젝트 조회</th></tr>
                        <tr><th id="createProject" style="cursor: pointer;"data-bs-toggle="modal" data-bs-target="#createModal">프로젝트 생성</th></tr>
                        <tr><th id="updateProject" style="cursor: pointer;"data-bs-toggle="modal" data-bs-target="#updateModal">프로젝트 수정</th></tr>
                        <tr><th id="createProjectWork" style="cursor: pointer;"data-bs-toggle="modal" data-bs-target="#createWorkModal">프로젝트-작업 수정</th></tr>
                        <tr><th id="updateProjectWork" style="cursor: pointer;"data-bs-toggle="modal" data-bs-target="#updateProjectWork">프로젝트-작업 삭제</th></tr>
                    </table>


            </div>
            <!-- 메인 == 전자결재 카테고리 -->
                <div id="approval-category" class="headerContent"><a href=""><img src="https://i.imgur.com/Nn5TmVd.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
                <div id="approvalWrap" class="sideHeader-sub">
                    <table id="approvalContent" class="table table-dark table-hover">
                        <tr><th>전자결재 메뉴1</th></tr>
                        <tr><th>전자결재 메뉴2</th></tr>
                        <tr><th>전자결재 메뉴3</th></tr>
                        <tr><th>전자결재 메뉴4</th></tr>
                        <tr><th>전자결재 메뉴5</th></tr>
                        <tr><th>전자결재 메뉴6</th></tr>
                        <tr><th>전자결재 메뉴7</th></tr>
                        <tr><th>전자결재 메뉴8</th></tr>
                    </table>
                </div>
            <!-- 메인 == 켈린더 카테고리 -->
            <div id="calender-category" class="headerContent"><a href=""><img src="https://i.imgur.com/8yHARRe.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
            <div id="calenderWrap" class="sideHeader-sub">
                <table id="calenderContent" class="table table-dark table-hover">
                    <tr><th>켈린더 메뉴1</th></tr>
                    <tr><th>켈린더 메뉴2</th></tr>
                    <tr><th>켈린더 메뉴3</th></tr>
                    <tr><th>켈린더 메뉴4</th></tr>
                    <tr><th>켈린더 메뉴5</th></tr>
                </table>
            </div>

            <!-- 메인 == 커뮤니티 카테고리 -->
            <div id="community-category" class="headerContent"><a href=""><img src="https://i.imgur.com/c0Ze4Y2.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
            <div id="communityWrap" class="sideHeader-sub">
                <table id="communityContent" class="table table-dark table-hover">
                    <tr><th>커뮤니티 메뉴1</th></tr>
                    <tr><th>커뮤니티 메뉴2</th></tr>
                    <tr><th>커뮤니티 메뉴3</th></tr>
                    <tr><th>커뮤니티 메뉴4</th></tr>
                    <tr><th>커뮤니티 메뉴5</th></tr>
                </table>
            </div>

            <!-- 메인 == 채팅 카테고리 -->
            <div id="chat-category" class="headerContent"><a href=""><img src="https://i.imgur.com/Nn5TmVd.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
            <div id="chatWrap" class="sideHeader-sub">
                <table id="chatContent" class="table table-dark table-hover" style="cursor: pointer;">
                    <tr><th>HOT사원</th></tr>
                    <tr><th id="hottalk-list">핫톡목록</th></tr>
                    <tr><th>환경생활</th></tr>
                </table>
            </div>
            <!-- 핫톡 목록 페이지 요청 -->
             <script>
                $("#hottalk-list").click(e=>{
                    location.assign("");
                })
             </script>



                <!-- 메인 == 인사 카테고리 -->
                <div id="insa-category" class="headerContent"><a href=""><img src="https://i.imgur.com/8yHARRe.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
                <div id="insaWrap" class="sideHeader-sub">
                    <table id="insaContent" class="table table-dark table-hover">
                        <tr><th>인사 메뉴1</th></tr>
                        <tr><th>인사 메뉴2</th></tr>
                        <tr><th>인사 메뉴3</th></tr>
                        <tr><th>인사 메뉴4</th></tr>
                        <tr><th>인사 메뉴5</th></tr>
                    </table>
                </div>



        </div>
    </div>

        </div>

    </header>