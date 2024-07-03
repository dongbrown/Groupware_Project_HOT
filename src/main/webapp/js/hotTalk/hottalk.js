

document.addEventListener('DOMContentLoaded', function() {
    const chatButtons = document.querySelectorAll('#chat-option1, #chat-option2, #chat-option3');
    const chatOptionDisplay = document.getElementById('chat-option');
    function setActiveButton(button) {
        chatButtons.forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
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
		console.log("WebSocket 연결 성공 : ", e);
		//constructor(type="", sender="", receiver="", hotTalkNo="", msg="", eventTime=new Date().toISOString())
		const msg = new CommonMessage("enter", loginEmployeeNo).convert()
		chatServer.send(msg);
	}

	chatServer.onmessage=(response)=>{
		const data = JSON.parse(response.data);
		// console.log(data);
		if(data != null && data.length>0){
			switch(data[0].type){
				case '사원':
					data.forEach(d=>{
						const $option = document.querySelector("#option-result");
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
						} else {
							$photo.src="";
							$photo.style.width="53px";
							$photo.style.height="53px";
							$photo.style.borderRadius="100px";
							$photo.style.marginRight="10px";
						}
						$name.innerText=d.employeeName;
						$dept.innerText=d.departmentCode;
						$employee.appendChild($photo);
						$profile.appendChild($name);
						$profile.appendChild($dept);
						$employee.appendChild($profile);

						$employee.classList.add("hotTalkEmployee");
						$option.appendChild($employee);
					})
				break;
				case '핫톡':console.log("핫톡"); break;
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

	// 메세지 전송 버튼 클릭 이벤트
	document.querySelector(".send-btn").addEventListener("click", ()=>{
		const msg=document.querySelector("#msg").value;
		if(msg.length>0){
			// (type="", sender="", receiver="", hotTalkNo="", msg="", eventTime=new Date().toISOString())
			const msgObj = new Message("msg", loginEmployeeName, "", "", msg).convert();
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
