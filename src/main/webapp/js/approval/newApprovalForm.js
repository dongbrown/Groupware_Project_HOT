/*
	결재문서 작성 페이지용 js~
*/

//휴대폰번호 입력 처리
document.getElementById('phoneNumber').addEventListener('input', function() {
    let input = this.value.replace(/\D/g, ''); // 숫자만 남기기
    let formatted = '';

    if (input.length > 11) {
        input = input.slice(0, 11); // 최대 11자리까지
    }

    if (input.length === 11) {
        // 11자리 포맷: 010-1234-1234
        formatted = input.slice(0, 3) + '-' + input.slice(3, 7) + '-' + input.slice(7);
    } else if (input.length === 10) {
        // 10자리 포맷: 010-123-1234
        formatted = input.slice(0, 3) + '-' + input.slice(3, 6) + '-' + input.slice(6);
    } else {
        // 기본 포맷
        formatted = input;
    }

    this.value = formatted;
});

//휴가 신청서 insert
$('#vacation-insert-btn').click(insertApproval);
$('#vacation-temp-btn').click(insertApproval);
function insertApproval(){
	const $form=$('#vacation-form').get(0);

	//입력 전부했는지 확인
	if($(this).attr('id') == 'vacation-insert-btn'){
		if(!$form.checkValidity()){
			alert('필수정보를 전부 입력해주세요!');
			return;
		}
	}
	
	//결재자 입력 확인
	if($('#middleApprover .approval-content').is(':empty') || $('#finalApprover .approval-content').is(':empty')){
		alert('결재자를 등록해주세요!');
		return;
	}
	
	if($('#phoneNumber').val() != ''){
    	let result = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
    	if(!result.test($('#phoneNumber').val())){
			alert('알맞은 핸드폰번호 형식이 아닙니다!');
			return;
		}
	}
	
	const fd=new FormData($form);

	//보존기한 날짜 Date로 바꾸기
	const periodDate=new Date();
	periodDate.setMonth(periodDate.getMonth()+1+parseInt(fd.get('period')));
	fd.set('period', periodDate.toISOString());
	
	//결재상신인지 임시저장인지 확인하여 status저장
	if($(this).attr('id') == 'vacation-insert-btn'){
		fd.set('approvalStatus', 1); //결재상신
	}else{
		fd.set('approvalStatus', 5); //임시저장
	}

	fetch(path+'/api/approval/insertVacation', {
		method:'POST',
		body:fd
	})
	.then(response=>response.text())
	.then(data=>{
		console.log(data);
		alert(data);
		location.reload();
	})
	.catch(error=>{
		console.log(error);
	})
};


//참조, 수신자 태그 x버튼 함수
function removeElement(element) {
	element.parentElement.remove();
	const no = $(element).siblings().eq(0).val();
	if($(element).parent().attr('class') == 'referer-item'){
		//참조자 삭제
		approvalReferers.forEach(e=>{
			if(e.employeeNo == no){
				approvalReferers.pop(e);
			}
		})
	}else{
		//수신처 삭제
		approvalReceivers.forEach(e=>{
			if(e.employeeNo == no){
				approvalReceivers.pop(e);
			}
		})
	}
}

//부서 불러오기
function loadEmployees() {
	var departmentCode = document.getElementById("select-dept").value;

	if (departmentCode) {
		$.ajax({
			url: '/approval/employees',
			type: 'GET',
			data: { departmentCode: departmentCode },
			success: function(employees) {
				updateEmployeeSelects(employees);
			},
			error: function(xhr, status, error) {
				console.error("Error loading employees:", error);
			}
		});
	} else {
		// 부서가 선택되지 않았을 때 직원 선택 옵션 초기화
		updateEmployeeSelects([]);
	}
}


document.getElementById('formType').addEventListener('change', showForm);

function updateEmployeeSelects(employees) {
	var approverSelect = document.getElementById("approver");
	var refererSelect = document.getElementById("referer");
	var receiverSelect = document.getElementById("receiver");

	// 기존 옵션 제거
	approverSelect.innerHTML = '<option value="">선택하세요</option>';
	refererSelect.innerHTML = '<option value="">선택하세요</option>';
	receiverSelect.innerHTML = '<option value="">선택하세요</option>';

	// 새 직원 옵션 추가
	employees.forEach(function(employee) {
		var optionText = employee.employeeName + ' (' + employee.positionCode.positionTitle + ')';
		var option = new Option(optionText, JSON.stringify(employee));
		approverSelect.add(option.cloneNode(true));
		refererSelect.add(option.cloneNode(true));
		receiverSelect.add(option);
	});
}

// 직원 선택후 결재선 라인에 추가
var middleApprover = null;
var finalApprover = null;
var approvalReferers = [];
var approvalReceivers = [];

function addApprover() {
	var approverSelect = document.getElementById("approver");
	var selectedOption = approverSelect.options[approverSelect.selectedIndex];

	if (selectedOption && selectedOption.value) {
		try {
			var employee = JSON.parse(selectedOption.value);

			if (!middleApprover) {
				middleApprover = employee;
				updateAllForms('middleApprover', employee);
			} else if (!finalApprover) {
				// 중간결재자와 최종결재자가 같으면 안되는 비교
				if (employee.employeeNo === middleApprover.employeeNo) {
					alert("중간결재자와 최종결재자는 같은 사람일 수 없습니다.");
					return;
				}
				// 중간결재자와 최종결재자의 직급을 비교
				if (employee.positionCode.positionCode >= middleApprover.positionCode.positionCode) {
					alert("최종결재자의 직급은 중간결재자보다 높거나 같아야 합니다.");
					return;
				}
				finalApprover = employee;
				updateAllForms('finalApprover', employee);
			} else {
				alert("이미 중간결재자와 최종결재자가 모두 선택되었습니다.");
			}
		} catch (error) {
			console.error("Error parsing employee data:", error);
		}
	}
}

// 기본값으로 'form1' 사용
function getCurrentFormId() {
	var formType = document.getElementById('formType').value;
	return formType ? formType : 'form1';
}


function updateAllForms(type, employee) {
	var forms = document.getElementsByClassName('form-container');
	for (var i = 0; i < forms.length; i++) {
		updateApprovalBox(type, employee, forms[i]);
	}
}


//결재선 라인에 추가버튼 누를때 들어갈 직원
function updateApprovalBox(type, employee, form) {
	console.log("Updating approval box:", type, "in form:", form.id);
	var boxContent = form.querySelector("#" + type + " .approval-content");
	console.log("Box content element:", boxContent);
	if (boxContent) {
		boxContent.innerHTML =
			"<input name='"+ type +"No' value='"+ employee.employeeNo +"' hidden>" +
			"<p>" + employee.departmentCode.departmentTitle + "</p>" +
			"<p>" + employee.employeeName + " " + employee.positionCode.positionTitle + "</p>";
		console.log("Updated content:", boxContent.innerHTML);
	} else {
		console.error("Approval box content not found in form:", form.id, "for type:", type);
	}
}


//참조자 추가
function addReferer() {
	const $refererSelect = document.getElementById("referer");
	const selectedOption = $refererSelect.options[$refererSelect.selectedIndex];

	if (selectedOption && selectedOption.value) {
		const employee = JSON.parse(selectedOption.value);

		if (!approvalReferers.some(ref => ref.employeeNo === employee.employeeNo)) {
			approvalReferers.push(employee);
			makeRefererTags(employee);
		} else {
			alert("이미 추가된 참조자입니다.");
		}
	}
}


//참조자 나타내기
function makeRefererTags(employee) {
	console.log("Updating referers in all forms");

	const $referer = $('<div>').addClass('referer-item');
	const $no = $('<input>').attr('type','hidden').attr('name', 'refererNo').attr('value', employee.employeeNo);
	const $name = $('<span>').addClass('referer-details').text(employee.employeeName+" "+employee.positionCode.positionTitle+'('+employee.departmentCode.departmentTitle+')');
	const $x = $('<span>').addClass('remove-referer').attr('onclick', 'removeElement(this)').text('x');
	$referer.append($no).append($name).append($x);
	$('.refererDiv').append($referer);
}

//수신처 추가
function addReceiver() {
	const $receive = document.getElementById("receiver");
	const selectedOption = $receive.options[$receive.selectedIndex];

	if (selectedOption && selectedOption.value) {
		const employee = JSON.parse(selectedOption.value);

		if (!approvalReceivers.some(ref => ref.employeeNo === employee.employeeNo)) {
			approvalReceivers.push(employee);
			makeReceiversTag(employee);
		} else {
			alert("이미 추가된 수신처입니다.");
		}
	}
}


//수신처 나타내기
function makeReceiversTag(employee) {
	console.log("Updating receivers in all forms");

	const $recipient = $('<div>').addClass('recipient-item');
	const $no = $('<input>').attr('type','hidden').attr('name', 'receiverNo').attr('value', employee.employeeNo);
	const $name = $('<span>').addClass('recipient-details').text(employee.employeeName+" "+employee.positionCode.positionTitle+'('+employee.departmentCode.departmentTitle+')');
	const $x = $('<span>').addClass('remove-recipient').attr('onclick', 'removeElement(this)').text('x');
	$recipient.append($no).append($name).append($x);
	$('.recipientDiv').append($recipient);
}


//결재자,참조자 리셋버튼으로 초기화하기
function resetApprovers() {
	console.log("resetApprovers function called");
	middleApprover = null;
	finalApprover = null;
	approvalReferers = [];
	approvalReceivers = [];

	var forms = document.getElementsByClassName('form-container');
	for (var i = 0; i < forms.length; i++) {
		var form = forms[i];
		var middleApproverContent = form.querySelector("#middleApprover .approval-content");
		var finalApproverContent = form.querySelector("#finalApprover .approval-content");

		if (middleApproverContent) middleApproverContent.innerHTML = "";
		if (finalApproverContent) finalApproverContent.innerHTML = "";
	}

	// 참조자 필드 초기화
	$('#referer-div').html('');

	//수신처 영역 초기화
	$('#recipient').html('');

	// 선택된 옵션 초기화
	document.getElementById("approver").selectedIndex = 0;
	document.getElementById("referer").selectedIndex = 0;

	console.log("Approvers and referers have been reset.");
}



//양식 바뀔때 결재자,참조자정보 초기화
function showForm() {
	var selectedForm = document.getElementById('formType').value;
	var forms = document.getElementsByClassName('form-container');

	// 폼 변경 시 결재자와 참조자 정보 초기화
	clearApproversAndReferers();

	for (var i = 0; i < forms.length; i++) {
		forms[i].style.display = 'none';
	}
	if (selectedForm) {
		var currentForm = document.getElementById(selectedForm);
		if (currentForm) {
			currentForm.style.display = 'block';
		}
	}
}


//양식이 바뀔때마다 결재자 참조자 초기화 시키기
function clearApproversAndReferers() {
	middleApprover = null;
	finalApprover = null;
	approvalReferers = [];
	approvalReceivers = [];


	// 모든 폼에 대해 결재자 정보 초기화
	var forms = document.getElementsByClassName('form-container');
	for (var i = 0; i < forms.length; i++) {
		var form = forms[i];
		var middleApproverContent = form.querySelector("#middleApprover .approval-content");
		var finalApproverContent = form.querySelector("#finalApprover .approval-content");

		if (middleApproverContent) middleApproverContent.innerHTML = "";
		if (finalApproverContent) finalApproverContent.innerHTML = "";
	}

	// 참조자 필드 초기화
	$('#referer-div').html('');
	// 수신처 div 초기화
	$('#receiver').html('');

	// 선택된 옵션 초기화
	var approverSelect = document.getElementById("approver");
	var refererSelect = document.getElementById("referer");
	if (approverSelect) approverSelect.selectedIndex = 0;
	if (refererSelect) refererSelect.selectedIndex = 0;

	console.log("Approvers and referers have been cleared.");
}

//결재자 정보
function updateApproverInfo(form) {
	if (middleApprover) {
		updateApprovalBox('middleApprover', middleApprover, form);
	}
	if (finalApprover) {
		updateApprovalBox('finalApprover', finalApprover, form);
	}
}


//파일선택
document.querySelectorAll('.file-input').forEach(input => {
	input.addEventListener('change', function() {
		// 가장 가까운 부모 요소에서 라벨 찾기
		const label = this.closest('.input-group').querySelector('.custom-file-label');
		if (label) {
			const selectedFiles = Array.from(this.files).map(file => file.name).join(', ');
			label.textContent = selectedFiles || '파일 선택';
		}
	});
});


function initializeForms() {
	var forms = document.getElementsByClassName('form-container');
	for (var i = 0; i < forms.length; i++) {
		updateApproverInfo(forms[i]);
	}
}

window.onload = function() {
	initializeForms();
	// 기타 필요한 초기화 함수들...
};



document.getElementById('formType').addEventListener('change', showForm);

//초기화 시키는 버튼 이벤트 리스너
document.addEventListener('DOMContentLoaded', function() {

	// 초기화 버튼 이벤트
	var resetButton = document.querySelector('button.btn-danger');
	if (resetButton) {
		resetButton.addEventListener('click', resetApprovers);
	} else {
		console.error("Reset button not found");
	}


	// 양식 변경시 초기화 이벤트
	var formTypeSelect = document.getElementById('formType');
	if (formTypeSelect) {
		formTypeSelect.addEventListener('change', showForm);
	}



	// 모든 폼의 파일 선택 버튼에 대해 이벤트 리스너 추가
	document.querySelectorAll('.file-select-button').forEach(button => {
		button.addEventListener('click', function() {
			// 가장 가까운 부모 요소에서 파일 입력 찾기
			const fileInput = this.closest('.input-group').querySelector('.file-input');
			if (fileInput) {
				fileInput.click();
			}
		});
	});


	// 현재 날짜를 YYYY-MM-DD 형식으로 가져오는 함수
	function getCurrentDate() {
		const now = new Date();
		const year = now.getFullYear();
		const month = String(now.getMonth() + 1).padStart(2, '0');
		const day = String(now.getDate()).padStart(2, '0');
		return `${year}-${month}-${day}`;
	}

	// 모든 기안일 필드에 현재 날짜 설정
	const draftDateFields = document.querySelectorAll('.draftDate');
	const currentDate = getCurrentDate();

	draftDateFields.forEach(field => {
		if (!field.textContent.trim()) {
			field.textContent = currentDate;
		}
	});

});

// 날짜 선택시 시작일보다 종료일이 앞서지 않게 선택
document.addEventListener('DOMContentLoaded', function() {
	const startDate = document.getElementById('startDate');
	const endDate = document.getElementById('endDate');

	// 시작일이 변경될 때마다 종료일의 최소 날짜를 갱신
	startDate.addEventListener('change', function() {
		endDate.min = startDate.value;

		// 만약 현재 선택된 종료일이 새로운 시작일보다 이전이라면 종료일을 시작일과 같게 설정
		if (endDate.value < startDate.value) {
			endDate.value = startDate.value;
		}
	});
});

$(document).ready(function() {
	// 추가 버튼 클릭 시 이벤트 처리
	$('.btn-add-row').click(function() {
		var newRow = '<tr>' +
			'<td><input type="text" class="form-control item-name"></td>' +
			'<td><input type="text" class="form-control item-spec"></td>' +
			'<td><input type="text" class="form-control item-unit"></td>' +
			'<td><input type="number" class="form-control item-quantity"></td>' +
			'<td><input type="number" class="form-control item-price"></td>' +
			'<td><input type="number" class="form-control item-amount" readonly></td>' +
			'<td><input type="text" class="form-control item-remark"></td>' +
			'<td><button type="button" class="btn btn-primary btn-add-row">+</button></td>' +
			'</tr>';

		$('#itemTable tbody').append(newRow);
	});
});




