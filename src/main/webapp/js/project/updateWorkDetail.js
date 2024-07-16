//총 예산 원화 표시
    $('#project-budget').keyup(e=>{
        let value = e.target.value;
        let value1 = value.replace(/,/g,'');
        let result = Number(value1).toLocaleString('ko-KR');
        e.target.value=result;
    });
//종료 날짜 설정
//오늘 날짜 생성
function getTodayDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const day = String(today.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  // 1년 후 날짜를 가져오는 함수
      function getOneYearLaterDate() {
        const today = new Date();
        const nextYear = new Date(today.setFullYear(today.getFullYear() + 1));
        const year = nextYear.getFullYear();
        const month = String(nextYear.getMonth() + 1).padStart(2, '0');
        const day = String(nextYear.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
      }

// 날짜 입력 필드에 오늘 날짜 설정
  $("#work-end-date").val(getTodayDate());
  $("#work-end-date").attr('min', getTodayDate());
  $("#work-end-date").attr('max', getOneYearLaterDate());
 // 예산 날짜 입력 필드에 오늘 날짜 설정
  $("#budget-end-date").val(getTodayDate());
  $("#budget-end-date").attr('min', getTodayDate());
  $("#budget-end-date").attr('max', getOneYearLaterDate());

  const $dragFile = document.getElementById("dragFile");

  $dragFile.addEventListener("click", (e) => {
	e.target.style.border("3px solid red");
	});

// 설명  text 크기 카운트
    $('#floatingTextarea').on('input', function() {
        let textLength = $(this).val().length;
        $('#work-contents-count').text(textLength + '/1000');
        if(textLength>999){
			const textResult = $(this).val();
			$(this).val(String(textResult).substring(0, 1000));
		}
    });


//파일 첨부에 드래그 시 border 변경
	$dragFile.addEventListener("dragenter", e => {
		document.getElementById("project-work-file").style.border = "3.5px dashed #486AB2";
		document.getElementById("fileUploadBtn").style.opacity = 0.5;
	});
//파일 첨부에 드래그 아웃 시 border 복구
	$dragFile.addEventListener("dragleave", e => {
		document.getElementById("project-work-file").style.border = "3px dashed lightgrey";
		document.getElementById("fileUploadBtn").style.opacity = 1;
	});
//드래그한 파일이 해당 위치에 놓아졌을때
	const files=[];
	$dragFile.ondrop = (e) => {
		document.getElementById("project-work-file").style.border = "3px dashed lightgrey";
		document.getElementById("fileUploadBtn").style.opacity = 1;
		const fileListContainer = document.getElementById("fileListContainer");
		console.log(files);

		e.preventDefault();
		addFiles([...e.dataTransfer.files]);
	};

//파일추가 버튼으로 파일 추가하는 함수
	document.getElementById("fileInput").addEventListener("change",e=>{
		addFiles([...e.target.files]);
	});

//파일 추가 시  추가한 파일 div 생성 표기하는 함수
		function addFiles(fileList) {
			// 드롭된 파일 리스트 가져오기
			fileList.forEach(e => {
				//해당파일 이름이 있으면 가져오지않음.
				if(fileListContainer.innerHTML.indexOf(e.name)==-1){
					files.push(e);
					const $fileContainer = document.createElement('div');
					$fileContainer.classList.add('fileListContainer')

					const $fileSpan = document.createElement('span');
					$fileSpan.classList.add('fileSpan');

					const $fileDelete = document.createElement('button');
					$fileDelete.classList.add('btn-close');

					$fileSpan.textContent = e.name;
					$fileContainer.appendChild($fileSpan);
					$fileContainer.appendChild($fileDelete);
					fileListContainer.appendChild($fileContainer);
				}else{
					alert(e.name+"은 이미 존재합니다.");
				}
			});
		};

//추가된 파일 x버튼 누르면 삭제
	document.addEventListener("click", function(e) {
    if (e.target.classList.contains("att")) {
        e.target.closest(".fileListContainer").remove();
        const deleteFile = e.target.previousSibling.textContent;
		files.forEach((e,i)=>{
			if(e.name===deleteFile){
				files.splice(i,1);
				/*delete e.i;*/
				console.log(files);
			}
		})
    }
});

// ondragover 이벤트가 없으면 onDrop 이벤트가 실핻되지 않습니다.
	$dragFile.ondragover = (e) => {
		e.preventDefault();
	}
//진행 현황 100에 놓으면 작업 완료 버튼 활성화
    $('#work-progress').on('input change', function() {
        if ($('#work-progress').val() == 100) {
            $('#compeleteWorkBtn').css('display', 'block');
            $('#workUpdateBtn').css('display','none');
        }else{
			  $('#compeleteWorkBtn').css('display', 'none');
			  $('#workUpdateBtn').css('display','block');
		}
	});

	var delFileNames = [];
//업데이트 버튼 클릭시 ajax로 값 송출
	$(".fileListContainer>.btn-close").click(function(e) {
// 클릭된 버튼의 부모 요소에서 fileSpan을 찾아 텍스트 가져오기

		const fileName = $(this).closest('.fileListContainer').find('.fileRename').text().trim();

// 이미 리스트에 있는지 확인
		if (!delFileNames.includes(fileName)) {
// 리스트에 없으면 추가
			delFileNames.push(fileName);
		}
	console.log("현재 파일 리스트:", delFileNames);
	});

//최종 작업수정 버튼 클릭 시 ajax로 데이터 송출
	$('#updateWorkBtn').click(e=>{
		let updateData = new FormData();
//첨부파일 내용 저장
	files.forEach((file) => {
   		updateData.append('files', file);
   		updateData.append('fileName', file.name);
	});
//작업 내용 저장
	updateData.append("projectWorkNo", $("input[name='workNo']").val());
	updateData.append("projectWorkTitle", $("#work-title").val());
	updateData.append("projectWorkContent", $("#floatingTextarea").val());
	updateData.append("projectWorkEndDate", $("#work-end-date").val());
	updateData.append("projectWorkRank", $("#work-rank").val());
	updateData.append("projectWorkProgress", $("#work-progress").val());
//기존에 있던 파일 delete할 목록
	updateData.append("delFileList", delFileNames);

		fetch('/work/workupdateajax',{
			method:'POST',
			body:updateData,
		})
		.then(response=>{
			if(!response.ok){
				throw new Error('서버응답에러');
			}
			return response.text();
		})
		.then(data=>{
			alert("작업 업데이트가 완료되었습니다.");
				location.assign('/');
				console.log(data);
		})
		.catch(error=>{
			alert('작업 파일 업데이트를 실패했습니다.');
				console.log(error.message);
		})
	})













