/*
	프로필 페이지용 js~
*/


$(document).ready(()=>{
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

	function uploadFile(upFile){
		let fd=new FormData();
		fd.append('upFile', upFile);
		fd.append('employeePhoto', employeePhoto);
		fd.append('no', no);

		fetch(path+'/api/updateEmployeePhoto', {
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
});