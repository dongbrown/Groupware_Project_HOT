/*
	사원 생성 페이지용 js~
*/

$(document).ready(()=>{

	getDepartmentList();
})

//사원 생성 함수
function createEmployee(){
	const $form=$('#createForm').get(0);

	if(!$form.checkValidity()){
		alert('정보를 전부 입력해주세요!');
		return;
	}

	const fd=new FormData($form);

	//아이디 중복 확인

	//아이디 4글자 이상 확인
	if(fd.get('employeeId').length()<4){
		alert('아이디는 4글자 이상!');
		return;
	}

	//패스워드 4글자 이상 확인
	if(fd.get('employeePassword').length()<4){
		alert('비밀번호는 4글자 이상!');
		return;
	}

	//한국어 이름인지 확인
	const koreanNamePattern = /^[가-힣]+$/;
	if(!koreanNamePattern.test(fd.get('employeeName'))){
		alert('한국어 이름으로 입력해주세요!');
		return;
	}

	//주민번호 합치기
	const preSsn=fd.get('preSsn'); //주민번호 앞자리
	const postSsn=fd.get('postSsn'); //주민번호 뒷자리
	const ssn=preSsn+'-'+postSsn;

	//주민번호 옳바른지 확인
	const ssnPattern = /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))-[1-4][0-9]{6}$/;
	if(!ssnPattern.test(ssn)){
		alert('옳바른 주민번호 형식이 아닙니다');
		return;
	}
	fd.append('employeeSsn', ssn);

	//휴대폰 번호 확인
	const phonePattern = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	if(!phonePattern.test(fd.get('employeePhone'))){
		alert('올바른 휴대전화 형식이 아닙니다');
		return;
	}

	//주소에 상세주소 합치기
	let address=fd.get('employeeAddress');
	address+=' '+$('#detailAddress').val();
	fd.set('employeeAddress', address);

	fetch(path+'/api/hr/insertEmployee',{
		method:"POST",
		body:fd
	})
	.then(response=>response.text())
	.then(data=>{
		alert(data);
		location.reload();
	})
}

//아이디 중복 확인 이벤트
$('input[name=employeeId]').keyup(checkId);

function checkId(){
	const id=$('input[name=employeeId]').val();

	fetch(path+'/api/employee/selectAllEmployeeId?id='+id)
	.then(response=>response.json())
	.then(data=>{
		if(data){
			$('input[name=employeeId]').next().text('중복된 아이디 값입니다.');
		}else{
			$('input[name=employeeId]').next().text('');
		}
	})
}

//부서 데이터 가져오는 함수
function getDepartmentList() {
	fetch(path + '/api/employee/departmentList')
		.then(response => response.json())
		.then(data => {
			data.forEach(d=>{
				//사원 수정 모달창의 부서 select태그에 option태그 생성
				const $deptOp=$('<option>').attr('value', d.departmentCode)
								.text(d.departmentHighCode<=1?`---${d.departmentTitle}---`:d.departmentTitle)
								.attr('disabled', d.departmentHighCode<=1);
				$('select[name=departmentCode]').append($deptOp);
			});
		})
		.catch(error => {
			console.error('요청 실패: ', error); // 요청 실패 시 에러 처리
		});
}

//다음 주소찾기 api
var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }