/*
	프로필 페이지용 js~
*/

//사원 정보 변경
function updateEmployee(){
	const employeePhone=$('#phone').val();
	const employeeAddress=$('#address').val()+$('#detailAddress').val();
	const employeePassword=$('#password').val();

	const phoneNumberRegex = /^01(?:0|1|[6-9])[0-9]{7,8}$/;

	if(employeePhone==""&&employeeAddress==""&&employeePassword==""){
		alert('변경할 정보를 입력해주세요!');
		return;
	}else{
		if(employeePhone!=""){
			if(!phoneNumberRegex.test(employeePhone)){
				alert('휴대전화 정보를 정확히 입력해주세요! \'-\' 빼고 입력하셔야 합니다!');
				return;
			}
		}
		if(employeePassword!=""){
			if(employeePassword!=$('#passwordCheck').val()){
				alert('비밀번호와 비밀번호 확인이 일치하지 않습니다!');
				return;
			}
		}

		let requestEmployee={
			employeeNo:no,
			employeePhone:employeePhone,
			employeeAddress:employeeAddress,
			employeePassword:employeePassword
		};

		fetch(path+'/api/employee/updateEmployee' ,{
			method:'POST',
			headers:{
				'Content-Type':'application/json'
			},
			body:JSON.stringify(requestEmployee)
		})
		.then(response=>{
				if(!response.ok){
					throw new Error('서버응답에러');
				}
				return response.text()
			})
			.then(data=>{
				alert(data);
				location.reload();
			})
			.catch(error=>{
				alert(error.message);
				console.log(error.message);
			})
	}
}









$(document).ready(()=>{

	//사원 정보 수정 패스워드 확인
	$('#passwordCheck').keyup(e=>{
		if($('#password').val()!=null){
			const pwd=$('#password').val();
			const pwdCk=$(e.target).val();
			if(pwd == pwdCk){
				$('#pwdCheckText').html('').html('비밀번호 확인 일치').css('color', 'green');
			}else{
				$('#pwdCheckText').html('').html('비밀번호 확인 불일치').css('color', 'red');
			}
		}
	});


	//이미지 변경 버튼
	$('.photo-change-btn').click(e=>{
		$('#fileInput').click();
	});

	$('#fileInput').change(e=>{
		const upFile=e.target.files[0];
		if(upFile){
			uploadFile(upFile);
		}
	});


});

	function uploadFile(upFile){
		let fd=new FormData();
		fd.append('upFile', upFile);
		fd.append('employeePhoto', employeePhoto);
		fd.append('no', no);

		fetch(path+'/api/employee/updateEmployeePhoto', {
			method:'POST',
			body: fd
		})
		.then(response=>{
			if(!response.ok){
				throw new Error('서버응답에러');
			}
			return response.text()
		})
		.then(data=>{
			alert('이미지 변경 성공!');
			console.log(data);
			location.reload();
		})
		.catch(error=>{
			alert('이미지 변경 실패!');
			console.log(error.message);
		})
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