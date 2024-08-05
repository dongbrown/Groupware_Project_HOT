
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
  $("#project-end-date").val(getTodayDate());
  $("#project-end-date").attr('min', getTodayDate());
  $("#project-end-date").attr('max', getOneYearLaterDate());

  const $dragFile = document.getElementById("dragFile");

  $dragFile.addEventListener("click", (e) => {
	e.target.style.border("3px solid red");
	});

// 설명  text 크기 카운트
    $('#floatingTextarea').on('input', function() {
        let textLength = $(this).val().length;
        $('#project-contents-count').text(textLength + '/1000');
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
    if (e.target.classList.contains("btn-close")) {
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

//ajax - 작업 데이터 생성 처리
	document.getElementById("insertWorktBtn").addEventListener("click",e=>{

	let attData = new FormData();
//첨부파일 내용 저장
	files.forEach((file) => {
   		attData.append('files', file);
   		attData.append('fileName', file.name);
	});
//작업 내용 저장
	attData.append('projectNo', document.getElementsByName("projectNo")[0].value),
	attData.append('employeeNo', empNo),
	attData.append('projectWorkTitle' ,document.getElementsByName("workTitle")[0].value),
	attData.append('projectWorkContent' ,document.getElementsByName("workContent")[0].value),
	attData.append('projectWorkEndDate' ,document.getElementById("project-end-date").value),
	attData.append('projectWorkRank' ,document.getElementsByName("importance")[0].value),

//첨부 파일에 값 저장
			fetch(path+'/work/insertWorkDetail.do',{
				method:'POST',
				body:attData,
			})
			.then(response => {
			if(!response.ok){
				throw new Error('서버응답에러');
			}
			return response.text();
			})
			.then(data => {
				alert("작업 등록이 완료되었습니다.");
				location.assign(path+'/work/workinsert.do');
			})
			.catch(error => {
				alert('작업 파일 등록을 실패했습니다.');
				console.log(error.message);
			})
	});

