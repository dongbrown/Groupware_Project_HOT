

document.addEventListener('DOMContentLoaded', function() {
    const chatButtons = document.querySelectorAll('#chat-option1, #chat-option2, #chat-option3');
    // chat-option1 ? HOT사원
    // chat-option2 ? 개인 핫톡
    // chat-option3 ? 그룹 핫톡
    const chatOptionDisplay = document.getElementById('chat-option');
    function setActiveButton(button) {
        chatButtons.forEach(btn => btn.classList.remove('btn-active'));
        button.classList.add('btn-active');
        chatOptionDisplay.textContent = button.textContent;
    }
    setActiveButton(document.getElementById('chat-option1'));
	chatButtons.forEach(button => {
        button.addEventListener('click', function() {
            setActiveButton(this);
        });
    });

    let chatServer;
	chatServer = new WebSocket("ws://localhost:9090/hottalk.do");
	// HotTalk Open시
	chatServer.onopen=(e)=>{
		// console.log("WebSocket 연결 성공 : ", e);
		//constructor(type="", sender="", receiver="", hotTalkNo="", msg="", eventTime=new Date().toISOString())
		const msg = new CommonMessage("enter", loginEmployeeNo).convert()
		chatServer.send(msg);
	}
	$("#chat-option1").click(()=>{
		$("#option-result").text("");
		const msg = new CommonMessage("enter", loginEmployeeNo).convert()
		chatServer.send(msg);
	})

	$("#chat-option2").click(()=>{
		$("#option-result").text("");
		const msg = new CommonMessage("privateHotTalk", loginEmployeeNo).convert();
		chatServer.send(msg);
	})

	$("#chat-option3").click(()=>{
		$("#option-result").text("");
		const msg = new CommonMessage("groupHotTalk", loginEmployeeNo).convert();
		chatServer.send(msg);
	})

	chatServer.onmessage=(response)=>{
		const data = JSON.parse(response.data);
		// console.log(data);
		const $option = document.querySelector("#option-result");
		// console.log(data);
		if(data != null && data.length>0){
			switch(data[0].type){
				case '사원':
					data.forEach(d=>{
						if(d.employeeNo==loginEmployeeNo){
							console.log(d.status);
							console.log(d.profile);
							const $status = document.querySelector(".my-status");
							$status.innerText=d.status;
							const $msg = document.querySelector(".my-status-message");
							$msg.innerText=d.profile;
							$status.innerHTML=d.status;
						}
						const $employee = document.createElement("div");
						const $profile = document.createElement("div");
						const $photo = document.createElement("img");
						const $name = document.createElement("h5");
						const $dept = document.createElement("p");
						if(d.employeePhoto==null){
							$photo.src="https://img.khan.co.kr/news/2023/01/02/news-p.v1.20230102.1f95577a65fc42a79ae7f990b39e7c21_P1.png";
							$photo.style.width="53px";
							$photo.style.height="53px";
							$photo.style.borderRadius="100px";
							$photo.style.marginRight="10px";
							$photo.style.marginLeft="20px";
						} else {
							$photo.src=path+"/upload/employee/"+d.employeePhoto;
							$photo.style.width="53px";
							$photo.style.height="53px";
							$photo.style.borderRadius="100px";
							$photo.style.marginRight="10px";
							$photo.style.marginLeft="20px";
						}
						$name.innerText=d.employeeName;
						$dept.innerText=d.departmentCode;
						$employee.appendChild($photo);
						$profile.appendChild($name);
						$profile.appendChild($dept);
						$employee.appendChild($profile);
						$employee.classList.add("hotTalkEmployee");
						//$employee.addEventListener("click", )
						$option.appendChild($employee);
						$employee.addEventListener("dblclick",()=>{
							// 핫톡 사원 눌렀을 때 우측 상단 메세지들 변경 로직 및 채팅창 초기화
							const $chattingRoom = $(".chat-messages");
							$chattingRoom.empty();
							document.querySelector(".chat-user-name").innerText=d.employeeName;
							document.querySelector('.user-status').innerText=d.status;
							// 예외처리 필요(d.profile, d.employeePhoto) → null 일 수도 있음
							document.querySelector(".user-status-message").innerText=d.profile;
							document.querySelector(".target-avatat").src=path+"/upload/employee/"+d.employeePhoto;

						})
					}); break;
				case '갠톡':
					data.forEach(d=>{
						const $chattingroom = document.createElement("div");
						const $hotTalkTitle = document.createElement("h5");
						$hotTalkTitle.innerText=d.hotTalkTitle;
						const $name = document.createElement("h6");
						const $content = document.createElement("p");
						$content.innerText=d.hotTalkContent[0].hotTalkContent;
						const $profile = document.createElement("div");
						const $photo = document.createElement("img");
						$photo.src="https://cdn-icons-png.freepik.com/512/219/219986.png";
						$photo.style.width="30px";
						$photo.style.height="30px";
						$photo.style.borderRadius="60px";
						$photo.style.marginRight="10px";
						$chattingroom.appendChild($photo);
						$profile.appendChild($hotTalkTitle);
						$profile.appendChild($name);
						$profile.appendChild($content);
						$chattingroom.appendChild($profile);
						$chattingroom.classList.add("hotTalkEmployee");
						$option.appendChild($chattingroom);
						// 채팅방 더블클릭 시 클릭 시 채팅방 대화내용 및 채팅방 오픈
						$chattingroom.addEventListener("dblclick", ()=>{
								// console.log(d);
								openChatRoom(loginEmployeeNo, d.hotTalkNo);
							}
						)
					}); break;
				case '단톡':
					data.forEach(d=>{
						console.log(d);
						const $chattingroom = document.createElement("div");
						const $hotTalkTitle = document.createElement("h5");
						$hotTalkTitle.innerText=d.hotTalkTitle;
						const $name = document.createElement("h6");
						const $content = document.createElement("p");
						$content.innerText=d.hotTalkContent[0].hotTalkContent;
						const $profile = document.createElement("div");
						const $photo = document.createElement("img");
						$photo.src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbunjG0clqdBDZUtPkuGFbXuL1csW0EAQ_BQ&s";
						$photo.style.width="30px";
						$photo.style.height="30px";
						$photo.style.borderRadius="60px";
						$photo.style.marginRight="10px";
						$chattingroom.appendChild($photo);
						$profile.appendChild($hotTalkTitle);
						$profile.appendChild($name);
						$profile.appendChild($content);
						$chattingroom.appendChild($profile);
						$chattingroom.classList.add("hotTalkEmployee");
						$option.appendChild($chattingroom);
						// 채팅방 더블클릭 시 클릭 시 채팅방 대화내용 및 채팅방 오픈
						$chattingroom.addEventListener("dblclick", ()=>{
								openChatRoom(loginEmployeeNo, d.hotTalkNo);
							}
						)
					}); break;
				case 'open':
				const $chattingRoom = $(".chat-messages");
				$chattingRoom.empty();
					data.forEach(d => {
						console.log(d);
						if(d.hotTalkIsGroup=='N'){
							$(".chat-user-name").text(d.receivers[0].receiverName);
							$(".user-status").text(d.receivers[0].status);
							$(".user-status-message").text(d.receivers[0].profile);
						}else{
							$(".chat-user-name").text(d.hotTalkTitle);
							$(".user-status").empty();
							$(".user-status-message").text(d.contents[0].hotTalkContentDate);
						}
					  const contents = d.contents;
					  console.log(contents);
					  contents.forEach(c => {
						console.log(c);
					    const $chatBox = $("<div>").addClass("chat-message");
					    $chatBox.append($("<sup>").text(c.hotTalkContentSender.employeeName));
					    $chatBox.append($("<span>").text(c.hotTalkContent));

					    if (c.hotTalkContentSender.employeeNo != loginEmployeeNo) {
					      $chatBox.addClass("chattingRoom-left-msg");
					    } else {
					      $chatBox.addClass("chattingRoom-right-msg");
					    }

					    $chattingRoom.append($chatBox);
					  });
				});
				break;
			}
		}

	}
	// HotTalk Close 시
	chatServer.onclsoe = (e) =>{
		console.log("WebSocket 연결 종료 : ", e);
	}
	// Error 발생 시
	chatServer.onerror = (error) =>{
		console.log("WebSocket 연결 에러 : ",error);
	}

	function openChatRoom(sender, hotTalkNo){
		// CommonMessage Class 생성자 : constructor(type="", sender="", receiver="", hotTalkNo="", msg="", eventTime=new Date().toISOString())
		const msg = new CommonMessage("open", sender, "", hotTalkNo, "").convert();
		// sender, hotTalkNo 모두 int로 전달
		chatServer.send(msg);
	}

	// 메세지 전송 버튼 클릭 이벤트
	document.querySelector(".send-btn").addEventListener("click", ()=>{
		const msg=document.querySelector("#msg").value;
		if(msg.length>0){
			// CommonMessage Class 생성자 : constructor(type="", sender="", receiver="", hotTalkNo="", msg="", eventTime=new Date().toISOString())
			const msgObj = new CommonMessage("msg", loginEmployeeName, "", "", msg).convert();
			chatServer.send(msgObj);
		}else{
			alert("메세지를 입력하세요.");
			document.querySelector("#msg").focus();
		}
	})

});


class CommonMessage{
	constructor(type="", sender="", receiver="", hotTalkNo="", msg="", eventTime=new Date().toISOString()){
		this.type=type;
		this.sender=sender;
		this.receiver=receiver;
		this.hotTalkNo=hotTalkNo;
		this.msg=msg;
		this.eventTime=eventTime;
	}
	convert(){
		return JSON.stringify(this);
	}
}
class Employee{
	constructor(type="사원", employeeNo="", employeeName="", departmentCode="", employeePhoto=""){
		this.type=type;
		this.employeeNo=employeeNo;
		this.employeeName=employeeName;
		this.departmentCode=departmentCode;
		this.employeePhoto=employeePhoto;
	}
	convert(){
		return JSON.stringify(this);
	}
}
class HotTalkList{
	constructor(type="핫톡",hotTalkIsgroup="", hotTalkTitle="", hotTalkNo="", hotTalkContent=""){
		this.type=type;
		this.hotTalkIsgroup=hotTalkIsgroup;
		this.hotTalkTitle=hotTalkTitle;
		this.hotTalkNo=hotTalkNo;
		this.hotTalkContent=hotTalkContent;
	}
	convert(){
		return JSON.stringify(this);
	}
}
