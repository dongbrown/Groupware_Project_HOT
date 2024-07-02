<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set value="pageContext.request.contextPath" var="path"/>
<c:import url="/WEB-INF/views/common/header.jsp"/>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
<body>
<section>
    <div id="hotTalkMenu">
        <div class="hotTalkMenu">
            <button>HOT사원</button>
            <button>핫톡목록</button>
            <button>환경설정</button>
        </div>
    </div>
    <div class="result">
        나는 채팅방 목록
    </div>
    <div class="specRoom">
        <div class="chattingContent">

        </div>
        <form class="messagefrm">
            <input type="text" placeholder="메시지를 입력하세요...">
            <div class="file-upload">
                <label for="file-input" class="file-upload-btn">
                    <span class="plus-icon">+</span>
                </label>
                <input id="file-input" type="file" style="display: none;">
                <span id="file-name"></span>
            </div>
            <button type="submit">전송</button>
        </form>
    </div>
</section>
</body>
<script type="text/javascript" src="${path }/js/hotTalk/hottalk.js"></script>
</html>