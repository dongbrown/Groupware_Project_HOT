

document.addEventListener('DOMContentLoaded', function() {

    const chatButtons = document.querySelectorAll('#chat-option1, #chat-option2, #chat-option3');
    // chat-option1 ? HOT사원
    // chat-option2 ? 개인 핫톡
    // chat-option3 ? 그룹 핫톡
    const chatOptionDisplay = document.getElementById('chat-option');
    // 선택된 버튼 활성화
    function setActiveButton(button) {
        chatButtons.forEach(btn => btn.classList.remove('btn-active'));
        button.classList.add('btn-active');
        chatOptionDisplay.textContent = button.textContent;
    }
	chatButtons.forEach(button => {
        button.addEventListener('click', function() {
            setActiveButton(this);
        });
    });
    // 현재시각 구하는 함수(ex. 2024-07-11 11:21:57)
	const getDate = function(){
		const timestamp = new Date().getTime();
		const date = new Date(timestamp);
		const year = date.getFullYear().toString();
		const month = ("0"+(date.getMonth()+1)).slice(-2);
		const day = ("0"+(date.getDay())).slice(-2);
		const hour = ('0'+(date.getHours())).slice(-2);
		const minute = ("0"+(date.getMinutes())).slice(-2);
		const second = ("0"+(date.getSeconds())).slice(-2);
		const now = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
		return now;
	}
    let chatServer;
	chatServer = new WebSocket("ws://localhost:9090/hottalk.do");
	// HotTalk Open시
	chatServer.onopen=(e)=>{
		// console.log("WebSocket 연결 성공 : ", e);
		//constructor(type="", sender="", receiver="", hotTalkNo="", msg="", eventTime=new Date().toISOString())
		setActiveButton(document.getElementById('chat-option1'));
		const msg = new CommonMessage("enter", loginEmployeeNo).convert()
		chatServer.send(msg);
	}
	// 핫톡 사원 리스트 가져오기
	function employeeList(){
		$("#option-result").text("");
		setActiveButton(document.getElementById('chat-option1'));
		const msg = new CommonMessage("enter", loginEmployeeNo).convert()
		chatServer.send(msg);
	}
	// 개인 채팅방 새로운 내용을 가져오게하기 위한 함수
	function privateList(){
		$("#option-result").text("");
		setActiveButton(document.getElementById('chat-option2'));
		const msg = new CommonMessage("privateHotTalk", loginEmployeeNo).convert();
		chatServer.send(msg);
	}
	// 그룹 채팅방 새로운 내용을 가져오게하기 위한 함수
	function groupList(){
		$("#option-result").text("");
		setActiveButton(document.getElementById('chat-option3'));
		const msg = new CommonMessage("groupHotTalk", loginEmployeeNo).convert();
		chatServer.send(msg);
	}


	// 각 버튼 눌렀을 때 함수 호출
	$("#chat-option1").click(()=>{
		employeeList();
	})
	$("#chat-option2").click(()=>{
		privateList();
	})
	$("#chat-option3").click(()=>{
		groupList();
	})
/*
	상태, 상태메세지 모달창
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

	const $chattingRoom = $(".chat-messages");
	let allEmployee = "";
	chatServer.onmessage=(response)=>{
		const data = JSON.parse(response.data);
		// console.log(data);
		const $option = document.querySelector("#option-result");
		// console.log(data);

		if(data != null && data.length>0){
			// $option.innerHTML="";
			switch(data[0].type){
				case '사원':
					data.forEach(d=>{
						const $employee = document.createElement("div");
						const $profile = document.createElement("div");
						const $photo = document.createElement("img");
						const $name = document.createElement("h5");
						const $dept = document.createElement("p");
						if(d.receiver.length==0){
							const $status = document.querySelector(".my-status");
							$status.innerText=d.senderStatus.hotTalkStatus;
							const $msg = document.querySelector(".my-status-message");
							$msg.innerText=d.senderStatus.hotTalkStatusMessage;
							// $status.innerHTML=d.status;
						} else if(d.receiver[0].receiver.employeePhoto==null){
							$photo.src="https://img.khan.co.kr/news/2023/01/02/news-p.v1.20230102.1f95577a65fc42a79ae7f990b39e7c21_P1.png";
							$photo.style.width="53px";
							$photo.style.height="53px";
							$photo.style.borderRadius="100px";
							$photo.style.marginRight="10px";
							$photo.style.marginLeft="20px";
						} else {
							$photo.src=path+"/upload/employee/"+d.receiver[0].receiver.employeePhoto;
							$photo.style.width="53px";
							$photo.style.height="53px";
							$photo.style.borderRadius="100px";
							$photo.style.marginRight="10px";
							$photo.style.marginLeft="20px";
						}

						if(d.receiver.length!=0){
							$name.innerText=d.receiver[0].receiver.employeeName;
							$dept.innerText=d.receiver[0].receiverDept.departmentTitle+"부";
							$employee.appendChild($photo);
							$profile.appendChild($name);
							$profile.appendChild($dept);
							$employee.appendChild($profile);
							$employee.classList.add("hotTalkEmployee");
							$employee.setAttribute('data-employeeno', d.receiver[0].receiver.employeeNo);

							$option.appendChild($employee);
						}
						$employee.addEventListener("dblclick",(e)=>{
							const clickedEmployeeNo = e.target.getAttribute("data-employeeno");
							// console.log(clickedEmployeeNo);
							// console.log(loginEmployeeNo);
							const checkChattingHistory = new CommonMessage("check", loginEmployeeNo, clickedEmployeeNo).convert();
							chatServer.send(checkChattingHistory);
						})
					});
				// console.log($option);
				    $('.search-bar>.search-input').on('keyup', function(){
						if($(this).val().length>1){
							$('#option-result .hotTalkEmployee h5').each(function(){
								if($(this).text().match($('.search-bar>.search-input').val())){
									$(this).parent().parent().show();
								} else {
									$(this).parent().parent().hide();
								}
							})
						} else {
							$('#option-result .hotTalkEmployee').each(function(){
								$(this).show();
							})
						}
					})
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
							$(".chat-messages").text("");
							$("#staticBackdrop").modal("hide");
							$(".chat-user-name").text($(".modal-hottalk-title").val());
							$(".target-avatar").attr("src","https://cdn.hankyung.com/photo/202212/01.32245693.1.jpg");
							// : 다중 요소에 추가 가능한 class인 만큼 처음 추가한 사원만 나오는 모습
							let members = '';
							$(".additionalEmployee").each(function(){
							    members += $(this).data('employeeno') + ',';
							})
							members = members.slice(0, -1); // 마지막 쉼표 제거
							console.log(members);
							$(".chat-send-btn").off("click");
							$(".chat-send-btn").click(()=>{
								const newMsg = $(".chat-msg").val().trim();
								if(newMsg.length!=0){
									 const newChatRoom = new CommonMessage("createChat", loginEmployeeNo, members, "", newMsg,"", $(".chat-user-name").text());
									 chatServer.send(newChatRoom.convert());
								} else {
									Swal.fire({
									  icon: "error",
									  title: "메세지 미입력",
									  text: "채팅방 생성을 위하여 메세지를 입력해주세요."
									});
								}

							})
						}
					})

				}); break;
				case '갠톡':
					data.forEach(d=>{
						// console.log(d);
						const $chattingroom = document.createElement("div");
						const $hotTalkTitle = document.createElement("h5");
						if(loginEmployeeNo==d.receiverNo) $hotTalkTitle.innerText=d.receiverName;
						else $hotTalkTitle.innerText = d.senderName;
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
								// $(".chat-input").data("memberNo",members);
							 	//console.log($(".chat-input").data("memberNo"));
							 	// document.querySelector(".chat-input").setAttribute('memberNo', d.receiver[0].receiver.employeeNo);
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
				$chattingRoom.empty();
					$(".chat-send-btn").off("click");
					/*$(".chat-send-btn").click(()=>{
						sendMsg(loginEmployeeNo, "", data[0].hotTalkNo);
					});*/
					// 해당 방 번호 저장
					$("#room-no").val(data[0].hotTalkNo);
					// console.log(data);
					// console.log($("#room-no").val());
					data.forEach((d,i) => {
						console.log(d);
						// constructor(type="", sender="", receiver="", hotTalkNo="", msg="", eventTime=new Date().toISOString(), title="")
						const isRead = new CommonMessage("read", loginEmployeeNo,"", d.hotTalkNo);
						chatServer.send(JSON.stringify(isRead));
						let receiver;
						const contents = d.contents;
						// console.log(d.contents[0].hotTalkNo);
						if(d.hotTalkIsGroup=='N'){
							privateList();
							// 1:1 채팅에서 첫 번째 content의 발신자 == 로그인한 유저인 경우
							if(contents[0].hotTalkContentSender.hotTalkMember.employeeNo == loginEmployeeNo){
								$(".chat-user-name").text(contents[0].hotTalkReceiver[0].hotTalkReceiver.hotTalkMember.employeeName);
								if(contents[0].hotTalkReceiver[0].hotTalkReceiver.hotTalkStatus != null){
									receiver=contents[0].hotTalkReceiver[0].hotTalkReceiver.hotTalkMember.employeeNo;
									// 첫 번째 content의 수신자를 상단에 출력
									$(".user-status").text(contents[0].hotTalkReceiver[0].hotTalkReceiver.hotTalkStatus.hotTalkStatus);
									$(".user-status-message").text(contents[0].hotTalkReceiver[0].hotTalkReceiver.hotTalkStatus.hotTalkStatusMessage);
								} else {
									$(".user-status").text("Online");
									$(".user-status-message").text("");
								}
								if(d.contents[0].hotTalkReceiver[0].hotTalkReceiver.hotTalkMember.employeePhoto!=null){
									// console.log(data);
									$(".target-avatar").attr("src",path+"/upload/employee/"+d.contents[0].hotTalkReceiver[0].hotTalkReceiver.hotTalkMember.employeePhoto);
								} else {
									$(".target-avatar").attr("src","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_kSSoomJ9hiFXmiF2RdZlwx72Y23XsT6iwQ&s");
								}
							} else {	// 1:1 채팅에서 첫 번째 content의 발신자 != 로그인한 유저의 경우 → 발신자를 상단에 출력
								receiver=contents[0].hotTalkContentSender.hotTalkMember.employeeNo;
								$(".chat-user-name").text(contents[0].hotTalkContentSender.hotTalkMember.employeeName);
								$(".user-status").text(contents[0].hotTalkContentSender.hotTalkStatus.hotTalkStatus);
								$(".user-status-message").text(contents[0].hotTalkContentSender.hotTalkStatus.hotTalkStatusMessage);
								if(contents[0].hotTalkContentSender.hotTalkMember.employeePhoto!=null){
									$(".target-avatar").attr("src",path+"/upload/employee/"+d.contents[0].hotTalkContentSender.hotTalkMember.employeePhoto);
								} else {
									$(".target-avatar").attr("src","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_kSSoomJ9hiFXmiF2RdZlwx72Y23XsT6iwQ&s");
								}
							}
							$(".chat-send-btn").click(()=>{
								// console.log(loginEmployeeNo, receiver, d.contents[0].hotTalkNo, $(".chat-msg").val());
								sendMsg(loginEmployeeNo, receiver, d.contents[0].hotTalkNo);
							});
						}else{
							// console.log(d);
							groupList();
							$(".target-avatar").attr("src","https://cdn.hankyung.com/photo/202212/01.32245693.1.jpg");
							$(".chat-user-name").text(d.hotTalkTitle);
							$(".user-status").text("개설 날짜 및 시각");
							$(".user-status-message").text((d.contents[0].hotTalkContentDate).split('T')[0]+" "+(d.contents[0].hotTalkContentDate).split('T')[1]);
							// const sendMsg = function(sender, receiver, hotTalkNo)
  						    $(".chat-send-btn").click(()=>{
								// console.log(loginEmployeeNo, "", d.contents[0].hotTalkNo, $(".chat-msg").val());
								sendMsg(parseInt(loginEmployeeNo), receiver, d.contents[0].hotTalkNo);

							});
						}
						// sendBtnHandle=function(){sendMsg(loginEmployeeNo, receiver, d.contents[0].hotTalkNo);}
						data[i].attachments.forEach((a,n)=>{
							const c = contents[n];
							// console.log(a.hotTalkRenamedFilename==null);
							// console.log(a.hotTalkRenamedFilename+"//"+c.hotTalkContent)
								if(a.hotTalkRenamedFilename==null){
								    const $chatBox = $("<div>").addClass("chat-message");
								    $chatBox.append($("<sup>").html("<b>"+c.hotTalkContentSender.hotTalkMember.employeeName+"</b> "+(c.hotTalkContentDate.split('T'))[0]+" "+(c.hotTalkContentDate.split('T'))[1]));
								    $chatBox.append($("<span>").text(c.hotTalkContent));
								    if (c.hotTalkContentSender.hotTalkMember.employeeNo != loginEmployeeNo) {
								      $chatBox.addClass("chattingRoom-left-msg");
								    } else {
								      $chatBox.addClass("chattingRoom-right-msg");
								    }
									$chattingRoom.append($chatBox);
								} else if(c.hotTalkContent==a.hotTalkOriginalFilename){
									console.log(a.hotTalkRenamedFilename);
									if(isImageFile(a.hotTalkOriginalFilename)){
										const $chatBox = $("<div>").addClass("chat-message");
										// File 다운로드 a 태그 생성
										const $fileDownload = $("<a>").attr("href", path+"/hottalk/download?hotTalkOriginalFilename="+a.hotTalkOriginalFilename+"&hotTalkRenamedFilename="+a.hotTalkRenamedFilename);
										const $previewImg = $("<img>").attr("src", path+"/upload/hottalk/"+a.hotTalkRenamedFilename).addClass("preview-img")

										$fileDownload.append($previewImg);
										$chatBox.append($fileDownload);
									    $chatBox.append($("<sup>").html("<b>"+c.hotTalkContentSender.hotTalkMember.employeeName+"</b> "+(c.hotTalkContentDate.split('T'))[0]+" "+(c.hotTalkContentDate.split('T'))[1]));
										$chatBox.append($("<span>").text(c.hotTalkContent));
									    if (c.hotTalkContentSender.hotTalkMember.employeeNo != loginEmployeeNo) {
									      $chatBox.addClass("chattingRoom-left-msg");
									    } else {
									      $chatBox.addClass("chattingRoom-right-msg");
									    }
									    $chatBox.addClass("jello-horizontal");
									    $chattingRoom.append($chatBox);
									} else {
										// 이미지 파일이 아닌 파일 출력
										const $chatBox = $("<div>").addClass("chat-message");
										const $fileDownload = $("<a>").attr("href", path+"/hottalk/download?hotTalkOriginalFilename="+a.hotTalkOriginalFilename+"&hotTalkRenamedFilename="+a.hotTalkRenamedFilename);
										const $previewImg = $("<img>").attr("src", path+"/images/hottalk/FileIcon.png").addClass("fileIcon")
										$fileDownload.append($previewImg);
										$chatBox.append($("<sup>").html("<b>"+c.hotTalkContentSender.hotTalkMember.employeeName+"</b> "+(c.hotTalkContentDate.split('T'))[0]+" "+(c.hotTalkContentDate.split('T'))[1]));
										$chatBox.append($fileDownload).append($("<span>").text(c.hotTalkContent));
									    if (c.hotTalkContentSender.hotTalkMember.employeeNo != loginEmployeeNo) {
									      $chatBox.addClass("chattingRoom-left-msg");
									    } else {
									      $chatBox.addClass("chattingRoom-right-msg");
									    }
									    $chatBox.addClass("jello-horizontal");
									    $chattingRoom.append($chatBox);
									}

								}

							// 채팅창 오픈 시 가장 하단으로 이동
							setTimeout(() => {
							    $(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
							}, 100);
						});
				});
				break;
				case "new":
					console.log(data);
					openChatRoom(data.sender, data.hotTalkNo);
					$(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
				break;

			}
		}

		switch(data.type){
			case "msgSuccess":
				openChatRoom(data.sender, data.hotTalkNo);
			break;
			case "file":
				console.log("ㅋㅋ")
				console.log(data);
				openChatRoom(data.sender, data.hotTalkNo);	// openChatRoom 함수 → 파일 일 경우 분기처리 필요
				$(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
			break;
			case "nohistory":
				const target = JSON.parse(data.msg);
				console.log(target);
				// 핫톡 사원 눌렀을 때 우측 상단 메세지들 변경 로직 및 채팅창 초기화
				const $chattingRoom = $(".chat-messages");
				$chattingRoom.empty();
				document.querySelector(".chat-user-name").innerText=target.hotTalkMember.employeeName;
				document.querySelector('.user-status').innerText=target.hotTalkStatus.hotTalkStatus;
				if(target.hotTalkMember.employeePhoto!=null){
					document.querySelector(".target-avatar").src=path+"/upload/employee/"+target.hotTalkMember.employeePhoto;
				} else {
					document.querySelector(".target-avatar").src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_kSSoomJ9hiFXmiF2RdZlwx72Y23XsT6iwQ&s";
				}
				if(target.hotTalkStatus.hotTalkStatusMessage != null){
					document.querySelector(".user-status-message").innerText=innerText=target.hotTalkStatus.hotTalkStatusMessage;
				} else {
					document.querySelector(".user-status-message").innerText=target.department.departmentTitle+"부";
				}
				// 채팅 내용 전송 시 채팅방 생성 로직 구현 필요(기존 이벤트 삭제 후 채팅방 생성 → 채팅방 번호 기준으로 채팅 Content Insert)
				$(".chat-send-btn").off("click");
				$(".chat-send-btn").click(()=>{
					const newMsg = $(".chat-msg").val();
					if(newMsg.length!=0){
						 const newChatRoom = new CommonMessage("createChat", loginEmployeeNo, target.hotTalkMember.employeeNo, "", newMsg);
						 chatServer.send(newChatRoom.convert());
					} else {
						Swal.fire({
						  icon: "error",
						  title: "메세지 미입력",
						  text: "채팅방 생성을 위하여 메세지를 입력해주세요."
						});
					}

				})
			break;
			case "new":
				console.log(data);
				openChatRoom(data.sender, data.hotTalkNo);
				$(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
				$(".chat-msg").val("");
			break;
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
	const sendMsg = function(sender, receiverNo, hotTalkNo){
		if($(".chat-msg").val().trim().length == 0){
			Swal.fire({
				icon: "error",
				title: "메세지 미입력",
				text: "메세지를 입력해주세요."
			});
			$(".chat-msg").focus();
		} else {
			const $chatBox = $("<div>").addClass("chat-message chattingRoom-right-msg").append($("<sup>").html("<b>"+($(".user-name").text())+"</b> "+getDate()));
			$chatBox.append($("<span>").text($(".chat-msg").val()));
			$chattingRoom.append($chatBox);
			const newMsg = new CommonMessage("msg", sender, receiverNo, hotTalkNo, $(".chat-msg").val()).convert();
			chatServer.send(newMsg);
			$(".chat-msg").val("");
		}
	}
	// img 파일 미리보기를 위한 정규표현식
	const imageRegex = /\.(jpg|jpeg|png|gif|bmp|webp|tiff|svg|jfif)$/i;
	// 이미지 파일인지 확인 함수
	function isImageFile(filename) {
	    return imageRegex.test(filename);
	}

	// 파일 선택 함수 → https://sweetalert2.github.io/
	function handleFileSelect() {
	    const fileInput = document.getElementById('file-input');
	    const file = fileInput.files[0];
	    if (file) {
	        Swal.fire({
	            title: `File(${file.name}) 전송`,
	            text: "파일을 전송하시겠습니까?",
	            icon: 'question',
	            showCancelButton: true,
	            confirmButtonColor: '#3085d6',
	            cancelButtonColor: '#d33',
	            confirmButtonText: '전송',
	            cancelButtonText: '취소'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                Swal.fire(
	                    '파일 전송',
	                    '파일을 전송하겠습니다.',
	                    'success'
	                );
	                sendFile(file);
	            } else {
	                // 취소 시 파일 입력 필드 초기화
	                fileInput.value = '';
	            }
	        });
	    }
	}

	// 파일 전송 함수
	function sendFile(file) {
		const thisRoom = document.querySelector("#room-no").value;
	    const formData = new FormData();
	    formData.append('file', file);
		formData.append('hotTalkNo', thisRoom);
		formData.append('hotTalkAttSender', loginEmployeeNo);
	    $.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: path+'/hottalk/upload',	// Ajax통신으로 File 저장
	        data: formData,
	        processData: false,
	        contentType: false,
	        cache: false,
	        success: function (data) {
				console.log(data);
				$(".chat-msg").val(file.name);
	            // 파일 업로드 성공 후 WebSocket을 통해 파일 정보 전송
	            let upFile = new Object();
	            upFile.type="file";
	            upFile.hotTalkNo=thisRoom;
	            upFile.hotTalkOriginalFilename=data.hotTalkOriginalFilename;
	            upFile.hotTalkRenamedFilename=data.hotTalkRenamedFilename;
	            upFile.hotTalkAttSender=data.hotTalkAttSender;
	            console.log(upFile);

	            chatServer.send(JSON.stringify(upFile));
				$(".chat-msg").val("");
	            // 파일 입력 초기화
	            document.getElementById('file-input').value = '';

	            Swal.fire(
	                '성공',
	                '파일이 성공적으로 업로드되었습니다.',
	                'success'
	            );
	        },
	        error: function (e) {
	            console.error('Error:', e);
	            Swal.fire(
	                '오류',
	                '파일 전송 중 오류가 발생했습니다.',
	                'error'
	            );
	        }
	    });
	}

	// 이벤트 리스너 설정
	$(document).ready(function() {
	    $('#file-input').on('change', handleFileSelect);
	});


	class CommonMessage{
		constructor(type="", sender="", receiver="", hotTalkNo="", msg="", eventTime=new Date().toISOString(), title="", hotTalkRenamedFilename=""){
			this.type=type;
			this.sender=sender;
			this.receiver=receiver;
			this.hotTalkNo=hotTalkNo;
			this.msg=msg;
			this.eventTime=eventTime;
			this.title=title;
			this.hotTalkRenamedFilename=hotTalkRenamedFilename;
		}
		convert(){
			return JSON.stringify(this);
		}
	}
});