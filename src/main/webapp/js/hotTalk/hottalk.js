

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
	.0

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
	// 상태, 상태메세지 모달창
	/*
	Target
	<sup class="user-profile my-status"></sup>
    <p class="my-status-message"></p>
	*/
	// 상태 변경
	$(".change-status-btn").on('click', function(){
		const status = $("input[name='emp-change-status']:checked").val();
		// console.log(status);
		$("sup.my-status").text(status);
		// loginEmployeeNo, status 값 넘겨주기 → 서버에서 Update
		let newStatus = new Object();
		newStatus.type="change";
		newStatus.employeeNo = loginEmployeeNo;
		newStatus.hotTalkStatus = status;
		chatServer.send(JSON.stringify(newStatus))
	});
	// 상태 메세지 변경
	$(".change-statusMsg-btn").on('click', function(){
		const statusMsg = $("input[name='emp-change-statusMsg']").val();
		$("p.my-status-message").text(statusMsg);
		// loginEmployeeNo, statusMsg 값 넘겨주기 → 서버에서 Update
		let newStatus = new Object();
		newStatus.type="change";
		newStatus.employeeNo = loginEmployeeNo;
		newStatus.hotTalkStatusMessage = statusMsg;
		chatServer.send(JSON.stringify(newStatus))
	})


	let allEmployee = "";
	chatServer.onmessage=(response)=>{
		const data = JSON.parse(response.data);
		// console.log(data);
		const $option = document.querySelector("#option-result");
		// console.log(data);

		if(data != null && data.length>0){
			switch(data[0].type){
				case '사원':
					data.forEach((d,i)=>{
						console.log(d);
						const $employee = document.createElement("div");
						const $profile = document.createElement("div");
						const $photo = document.createElement("img");
						const $name = document.createElement("h5");
						const $dept = document.createElement("p");
						if(d.sender.employeeNo==loginEmployeeNo){
							const $status = document.querySelector(".my-status");
							$status.innerText=d.senderStatus.hotTalkStatus;
							const $msg = document.querySelector(".my-status-message");
							$msg.innerText=d.senderStatus.hotTalkStatusMessage;
							// $status.innerHTML=d.status;
						} else if(d.others[i].receiver.employeePhoto==null){
							$photo.src="https://img.khan.co.kr/news/2023/01/02/news-p.v1.20230102.1f95577a65fc42a79ae7f990b39e7c21_P1.png";
							$photo.style.width="53px";
							$photo.style.height="53px";
							$photo.style.borderRadius="100px";
							$photo.style.marginRight="10px";
							$photo.style.marginLeft="20px";
						} else {
							$photo.src=path+"/upload/employee/"+d.others[i].receiver.employeePhoto;
							$photo.style.width="53px";
							$photo.style.height="53px";
							$photo.style.borderRadius="100px";
							$photo.style.marginRight="10px";
							$photo.style.marginLeft="20px";
						}
						$name.innerText=d.employeeName;
						$dept.innerText=d.departmentCode;
						if(d.employeeNo!=loginEmployeeNo){
							$employee.appendChild($photo);
							$profile.appendChild($name);
							$profile.appendChild($dept);
							$employee.appendChild($profile);
							$employee.classList.add("hotTalkEmployee");
							$employee.setAttribute('data-employeeno', d.employeeNo);
							$option.appendChild($employee);
						}
						$employee.addEventListener("dblclick",()=>{
							// 핫톡 사원 눌렀을 때 우측 상단 메세지들 변경 로직 및 채팅창 초기화
							const $chattingRoom = $(".chat-messages");
							$chattingRoom.empty();
							document.querySelector(".chat-user-name").innerText=d.employeeName;
							document.querySelector('.user-status').innerText=d.status;
							// 예외처리 필요(d.profile, d.employeePhoto) → null 일 수도 있음
							console.log(d);
							if(d.employeePhoto!=null){
								document.querySelector(".target-avatar").src=path+"/upload/employee/"+d.employeePhoto;
							} else {
								document.querySelector(".target-avatar").src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_kSSoomJ9hiFXmiF2RdZlwx72Y23XsT6iwQ&s";
							}
							if(d.profile != null){
								document.querySelector(".user-status-message").innerText=d.profile;
							} else {
								document.querySelector(".user-status-message").innerText=d.departmentCode;
							}

						})
					});
				// console.log($option);
				// Modal 창 Start
				$(".modal-employee-result").text("");
				const $modalEmployees = $($option).clone();
				$modalEmployees.attr("style", "margin-top: 10px; height: 360px;");
				$modalEmployees.attr("class","modal-employee-box");
				$(".modal-employee-result").append($modalEmployees);
				$(document).ready(function() {
				    function moveEmployee($element, $from, $to, fromClass, toClass) {
				        $element.removeClass(fromClass).addClass(toClass);
				        $from.find($element).remove();
				        $to.prepend($element);
				    }

				    // 채팅방 생성 더블클릭으로 사원 이동
				    $(document).on('dblclick', '.modal-employee-result .hotTalkEmployee', function() {
				        moveEmployee($(this), $('.modal-employee-result>#option-result'), $('.modal-additional-employee'), 'hotTalkEmployee', 'additionalEmployee');
				    });

				    // .modal-additional-employee에서 이동
				    $(document).on('dblclick', '.modal-additional-employee .additionalEmployee', function() {
				        moveEmployee($(this), $('.modal-additional-employee'), $('.modal-employee-result>#option-result'), 'additionalEmployee', 'hotTalkEmployee');
				    });

				    // 사원 클릭 후 선택 상태 토글
				    $(document).on('click', '.modal-employee-result .hotTalkEmployee', function(){
				        toggleSelected($(this));
				    });

				    function toggleSelected($element){
				        $element.toggleClass('selected');
				        $element.data('roommember', $element.hasClass('selected'));
				        $element.css('background-color', $element.hasClass('selected') ? '#f0f8ff' : 'white');
				    }

				    // 선택된 사원을 오른쪽으로 이동
				    $(document).on('click', ".moveRight", function(){
				        $('.modal-employee-result .hotTalkEmployee.selected').each(function() {
				            moveEmployee($(this), $('.modal-employee-result>#option-result'), $('.modal-additional-employee'), 'hotTalkEmployee', 'additionalEmployee');
				            $('.selected').css('background-color','white');
				            $(this).removeClass('selected');
				        });
				    });

				    $(document).on('click', '.modal-additional-employee .additionalEmployee', function(){
				        toggleRemoved($(this));
				    });

				    function toggleRemoved($element){
				        $element.toggleClass('removed');
				        $element.data('notmember', $element.hasClass('removed'));
				        $element.css('background-color', $element.hasClass('removed') ? '#f0f8ff' : 'white');
				    }
				    $(document).on('click', ".moveLeft", function(){
				        $('.modal-additional-employee .additionalEmployee.removed').each(function() {
				            moveEmployee($(this), $('.modal-additional-employee .additionalEmployee'), $('.modal-employee-result>#option-result'), 'additionalEmployee', 'hotTalkEmployee');
				            $('.removed').css('background-color','white');
				            $(this).removeClass('removed');
				        });
				    });

				    $('.modal-search').on('keyup', function(){
						if($(this).val().length>1){
							$('.modal-employee-result .hotTalkEmployee h5').each(function(){
								if($(this).text().match($('.modal-search').val())){
									$(this).parent().parent().show();
								} else {
									$(this).parent().parent().hide();
								}
							})
						} else {
							$('.modal-employee-result .hotTalkEmployee').each(function(){
								$(this).show();
							})
						}
					})
					// 채팅방 생성 버튼 로직
					$(".create-btn").on('click', function(e){
						if($(".modal-hottalk-title").val().length==0){
							// console.log($(".modal-hottalk-title").val());
							alert("채팅방 제목을 입력해주세요.");
							return false;
						} else if($('.modal-additional-employee').children().length<2){
							// console.log($('modal-additional-employee').children().length);
							alert("그룹 채팅방의 멤버의 수가 부족합니다.")
							return false;
						} else {
							// console.log($(".modal-hottalk-title").val());
							$("#staticBackdrop").modal("hide");
							$(".chat-user-name").text($(".modal-hottalk-title").val());
							// $(".additionalEmployee").data('employeeno')
							// : 다중 요소에 추가 가능한 class인 만큼 처음 추가한 사원만 나오는 모습
							let members = loginEmployeeNo;
							$(".additionalEmployee").each(function(){
								 members = members+","+$(this).data('employeeno');
							})
							// console.log(members);
							$(".chat-input").data("memberNo",members);
							// console.log($(".chat-input").data("memberNo"));
							// → 모달창에서 추가한 사원들 사번들이 기존 input 태그에 data속성으로 담고 csv 형식으로 출력

						}
					})

				}); break;
				case '갠톡':
					data.forEach(d=>{
						// console.log(d);
						const $chattingroom = document.createElement("div");
						const $hotTalkTitle = document.createElement("h5");
						$hotTalkTitle.innerText=d.hotTalkTitle;
						const $name = document.createElement("h6");
						const $content = document.createElement("p");
						$content.innerText=d.hotTalkContent.hotTalkContent;
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
						// console.log(d);
						const $chattingroom = document.createElement("div");
						const $hotTalkTitle = document.createElement("h5");
						$hotTalkTitle.innerText=d.hotTalkTitle;
						const $name = document.createElement("h6");
						const $content = document.createElement("p");
						$content.innerText=d.hotTalkContent.hotTalkContent;
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
							$(".chat-user-name").text(d.contents[0].hotTalkReceiver[0].receiverName);
							$(".user-status").text(d.contents[0].hotTalkReceiver[0].status);
							$(".user-status-message").text(d.contents[0].hotTalkReceiver[0].profile);
							if(d.contents[0].hotTalkReceiver[0].employeePhoto==null){
								$(".target-avatar").attr("src","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_kSSoomJ9hiFXmiF2RdZlwx72Y23XsT6iwQ&s");
							} else {
								$(".target-avatar").attr("src",path+"/upload/employee/"+d.contents[0].hotTalkReceiver[0].employeePhoto);
							}
						}else{
							$(".chat-user-name").text(d.hotTalkTitle);
							$(".user-status").text("개설 날짜 및 시각");
							$(".user-status-message").text((d.contents[0].hotTalkContentDate).split('T')[0]+" "+(d.contents[0].hotTalkContentDate).split('T')[1]);
						}
					  const contents = d.contents;
					  console.log(contents);
					  contents.forEach(c => {
						console.log(c);
					    const $chatBox = $("<div>").addClass("chat-message");
					    if(c.hotTalkContentSender.employeeNo != loginEmployeeNo){

						}
					    $chatBox.append($("<sup>").html("<b>"+c.hotTalkContentSender.employeeName+"</b> "+(c.hotTalkContentDate.split('T'))[0]+" "+(c.hotTalkContentDate.split('T'))[1]));
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

	$(".make-group-btn").click(()=>{
		// console.log(allEmployee);
		$(".modal-employee-result").append(allEmployee);
	})

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
