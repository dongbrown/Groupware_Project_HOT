function connectSse() {

	const loginEmployeeNo = $('#header-empNo').data('employeeNo');
	const eventSource = new EventSource(`/subscribe/${loginEmployeeNo}`);
	// console.log(loginEmployeeNo);
	eventSource.onmessage = function(event){
		// console.log("Receive Message : "+event.data);
	}

	eventSource.onerror = function(error){
		// console.log("EventSource Fail : ", error);
		eventSource.close();
	}

	eventSource.addEventListener("Init", (e) => {
		// console.log(loginEmployeeNo);
		const hotTalkInfo = JSON.parse(e.data);

	  	const hotTalkDivNotiBox = $(".hottalk-notify");
	  	hotTalkDivNotiBox.empty();
		const header = $("<h6>").addClass("dropdown-header").text("HotTalk");
  		hotTalkDivNotiBox.append(header);
		hotTalkInfo.forEach((d) => {
			// console.log(d.hotTalkContent);

		    const hotTalkInfoBox = $("<a>").addClass("dropdown-item d-flex align-items-center");
		    const hotTalkInfoFirstDiv = $("<div>").addClass("mr-3");
		    hotTalkInfoBox.append(hotTalkInfoFirstDiv);
		    const hotTalkInfoFistDivInnerDiv = $("<div>").addClass("icon-circle bg-primary");
		    hotTalkInfoFirstDiv.append(hotTalkInfoFistDivInnerDiv);
		    const hotTalkIcon = $("<i>").addClass("fas fa-comment text-white");
		    hotTalkInfoFistDivInnerDiv.append(hotTalkIcon);

		    const hotTalkInfoSecondDiv = $("<div>");
		    hotTalkInfoBox.append(hotTalkInfoSecondDiv);
		    const hotTalkInfoSecondDivInnerDiv = $("<div>").addClass("hottalk-date small text-gray-500");

		    const date = new Date(d.hotTalkContentDate);
		    const formattedDate = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')} ${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`;

		    hotTalkInfoSecondDivInnerDiv.text(formattedDate);
		    hotTalkInfoSecondDiv.append(hotTalkInfoSecondDivInnerDiv);

		    hotTalkInfoSecondDiv.append(" " + d.hotTalkContent);

		    hotTalkDivNotiBox.append(hotTalkInfoBox);
	  });

		if (hotTalkInfo.length > 0 && hotTalkInfo[0].noReadCount != null) {
			$(".hottalk-no").text(hotTalkInfo[0].noReadCount);
	  	} else {
	    	$(".hottalk-no").text("0");
	  	}
	  	const moveLink = $("<a>").addClass("dropdown-item text-center small text-white").attr("href", `${path}/hottalk`).text("HotTalk 이동").css("background-color", "#4e73df");;
  		hotTalkDivNotiBox.append(moveLink);
	});

	eventSource.addEventListener("Message", (e)=>{
		// console.log("Message : "+JSON.parse(e.data));
	})

	eventSource.addEventListener("receiveChat", e=>{
		// console.log(e.data);
	})
}

window.onload=connectSse;
