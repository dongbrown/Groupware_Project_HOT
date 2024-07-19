function connectSse() {
	const loginEmployeeNo = $('#content-wrapper').data('employeeNo');
	const eventSource = new EventSource(`/subscribe/${loginEmployeeNo}`);

	eventSource.onmessage = function(event){
		// console.log("Receive Message : "+event.data);
	}

	eventSource.onerror = function(error){
		console.log("EventSource Fail : ", error);
		eventSource.close();
	}

	eventSource.addEventListener("Init",(e)=>{
		// console.log("Init")
		// console.log(JSON.parse(e.data));
		const hotTalkInfo = JSON.parse(e.data);
		$(".hottalk-no").text(hotTalkInfo[0].noReadCount);
		// console.log($(".hottalk-date"));
		$(".hottalk-date").each((i,d)=>{
			// console.log(hotTalkInfo[i]);
			$(d).text(hotTalkInfo[i].hotTalkContentDate.split('T')[0]+" "+hotTalkInfo[i].hotTalkContentDate.split('T')[1]);
			$(d).parent().append(hotTalkInfo[i].hotTalkContent);
		})
	})

	eventSource.addEventListener("Message", (e)=>{
		// console.log("Message : "+JSON.parse(e.data));
	})

	eventSource.addEventListener("receiveChat", e=>{
		// console.log(e.data);
	})
}

window.onload=connectSse;