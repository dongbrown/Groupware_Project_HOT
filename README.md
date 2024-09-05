# HOT(Have the opportunity to implement)
<img src="https://github.com/user-attachments/assets/8592ffd9-35d9-400e-98cf-7ae4281dd909" style="width: 100%;">
<br>

## ✋ 프로젝트 소개

<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="30%">
     <img src="https://github.com/user-attachments/assets/4e66610c-851e-48d1-8f53-9fa0d24da4dc" style="width: 100%"/>
    </td>
    <td width="70%">
      <img src="https://github.com/user-attachments/assets/17e9f339-6cc0-48a0-8bff-09ce75486f88" style="width: 100%;"/>
    </td>
  </tr>
</table>

### 📅 개발 기간 : 2024.06.25 ~ 2024.08.06

그룹웨어 사이트를 전자결재, 일정관리, 메일, SNS, 사내 커뮤니티 및 피드형 게시판 등 필수적인 기능을 기획/제작한 웹 사이트입니다.

<br>
<br>


## 👨‍👨‍👧‍👧 팀원 소개

| 이름   | 역할       | 담당 업무                    |
|--------|------------|---------------------------|
| 김명준 | 팀장 | 실시간 채팅, 전자결재      |
| 최선웅 | 팀원 | 프로젝트, 메인페이지   | 
| 고재현 | 팀원 | 인사, 조직도, 전자결재 | 
| 김동훈 | 팀원 | 일정관리, 커뮤니티, 이메일 | 


<br>
<br>

## ⚙️ 기술 스택
<img src="https://github.com/user-attachments/assets/383fd344-4fb0-43d3-8bcb-002b0c357c82" style="width: 48%; height: 300px;"/>
<img src="https://github.com/user-attachments/assets/916150a1-d754-4247-b437-48e2655ebda2" style="width: 48%; height: 300px;"/>

### 개발 환경
- 운영체제: Mac OS
- 개발환경: Eclipse, SQL Developer, Visual Studio Code
- DBMS: Oracle DB - SQL Developer
- Server: Apache Tomcat 9.0
- 개발 언어: Java, HTML5, CSS, JavaScript, jQuery
- 라이브러리 및 프레임워크: Spring Framework, Spring Boot, Mybatis, JSP, Servlet, JSTL, jQuery, Bootstrap, FullCalendar
- 기술 및 API: Ajax, RESTful API, WebSocket, SMTP, JSON, EL
- 형상관리: GitHub / Sourcetree / Notion

<br>

## 📃 WBS 및 ERD
<details>
  <summary><b>WBS</b></summary>
  <br>
  <div markdown="1">
    <ul>
      <img src="https://www.notion.so/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2Fa4dad6af-2889-4f24-849e-36828eac7662%2F121c0abb-b926-416e-a1ee-b3467ccd8bda%2FUntitled.png?table=block&id=42a5f2b1-81dd-48c5-a524-1e9bc27d6fc4&spaceId=a4dad6af-2889-4f24-849e-36828eac7662&width=2000&userId=17bae69d-6413-43c4-854c-4fa3895934cb&cache=v2"/>
    </ul>
  </div>
</details>

<details>
  <summary><b>ERD</b></summary>
  <br>
  <div markdown="1">
    <ul>
      <img src="https://github.com/user-attachments/assets/edabadf3-6251-49d6-944b-00eb5b7f530b"/>
      <img src="https://github.com/user-attachments/assets/6a93b317-4219-428c-95d6-0b3728e9b78d"/>
    </ul>
  </div>
</details>
<br>

## 🔧 구현 기능

### 전체 기능 개요

1. **전자결재:**
   - 양식별 결재 작성 및 기안
   - 중간 / 최종 결재 처리
   - 결재 상태별 문서 확인

2. **프로젝트:**
   - 프로젝트내 작업 생성 수정
   - 프로젝트별 진행도 그래프
   - 파일 업로드 및 공유

3. **일정관리:**
   - 내 일정 등록, 수정, 삭제 기능
   - 참석자 선택하여 일정 공유
   - 권한에 따른 전사일정 등록, 수정, 삭제 기능

4. **메일:**
   - 메일 전송(파일 첨부)
   - 수신 / 답장 / 전달 기능
   - 임시 저장, 삭제 및 복구 기능

5. **SNS:**
   - 웹소켓을 이용한 채팅 기능
   - 사원 검색하여 초대
   - 개인 채팅 / 그룹 채팅

6. **커뮤니티:**
   - 사내 커뮤니티 등록 및 초대 기능
   - 공개 커뮤니티 목록 확인 및 가입 
   - 커뮤니티별 피드형 게시판(댓글, 좋아요, 사진 첨부)

### 담당 기능 상세 설명

#### (1) DB 설계 및 관리
- 체계적인 데이터베이스 설계 프로세스 구현
- 데이터 무결성 및 일관성 확보를 위한 정규화 적용
- 성능 최적화를 위한 전략적 역정규화 구현
- 데이터 보안 및 무결성 강화

#### (2) 일정관리 기능
- 내 일정 / 공유 일정 분리하여 관리
- 공유하고 싶은 사원 선택하여 일정 공유
- 체크박스로 확인하고 싶은 일정만 확인할 수 있는 편리한 UI
- 드래그로 간단한 일정 수정

#### (3) 사내 커뮤니티 - 피드형 게시판 기능
- 커뮤니티 생성 및 관리 기능 구현
- 공개 커뮤니티 목록 조회 및 즉시 가입, 비공개 커뮤니티 초대 기능
- 텍스트, 이미지 포함 게시물 작성 및 좋아요, 댓글, 대댓글 기능
- 실시간 업데이트를 통한 새 게시물, 댓글, 좋아요 반영
- 즐겨찾기 및 내 커뮤니티 목록 관리 기능
- 커뮤니티 내 게시물 검색 기능
- 비공개 커뮤니티 접근 제한 및 게시물/댓글 작성자 권한 관리

#### (4) 메일 기능
- 다양한 메일함 구현
- 메일 조회, 작성, 발송, 답장, 전달 기능 구현
- 파일 첨부 및 드래그 앤 드롭 지원
- 메일 상태 관리
- 고급 검색 및 필터링 기능

## 📚 배운 점 & 아쉬운 점

### 성과 및 학습
1. 데이터베이스 설계 및 관리 역량 강화
2. 일정관리 시스템 구현을 통한 프론트엔드 및 백엔드 통합 개발 경험
3. 사내 커뮤니티 및 피드형 게시판 개발을 통한 소셜 미디어 기능 구현 경험
4. 메일 시스템 구현을 통한 복잡한 비즈니스 로직 처리 능력 향상
5. 협업 및 형상 관리 툴 활용 능력 향상

### 아쉬웠던 사항
- Docker 및 AWS를 활용하여 개인 서버를 구축하고 CI/CD를 직접 하지 못한 점

## 🔧 개선 사항 및 향후 계획

1. 성능 개선
   - 데이터베이스 쿼리 최적화
   - 페이지 로딩 속도 개선

2. 사용자 편의성 향상
   - 모바일 친화적 디자인 적용

3. 새로운 기능 추가
   - 간단한 투표 기능 구현
   - 할 일 목록(To-Do List) 기능 추가

4. 데이터 백업 및 복구 시스템 구축

이러한 개선 사항과 향후 계획을 통해 시스템의 안정성, 성능, 사용자 경험을 점진적으로 향상시키고, 실제 업무 환경에서 활용할 수 있는 그룹웨어 솔루션으로 발전시켜 나갈 계획입니다.
