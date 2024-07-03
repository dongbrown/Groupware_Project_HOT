

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
	}
	// 서버에서 HotTalk Message 전달 시
	chatServer.onmessage=(msg)=>{
		console.log("msg? "+msg);

		console.log("deconvert(msg)? "+Message.deconvert(msg))
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

class Message{
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
	static deconvert(data){
		return JSON.parse(data);
	}
}
class HotTalkEmployee{

}
class PersonalHotTalk{

}
class GroupHotTalk{

}