//버튼 애니메이션
	document.querySelectorAll('button').forEach(button => button.innerHTML = '<div><span>' + button.textContent.trim().split('').join('</span><span>') + '</span></div>');

	getProjectList(1);
//전체 프로젝트 조회
	$("#allProjectSearch").click(e=>{
		getProjectList(1);
	});
//본인 참여 프로젝트 조회
	$("#joinProjectSearch").click(e=>{
		getProjectListByEmpNo(1);
	});
//참여 요청한 프로젝트 조회
	$('#requestProjectSearch').click(e=>{
		getRequestProjectList(1);
	});
//참여 요청(온)!!! 프로젝트 조회
	$('#responseProjectSearch').click(e=>{
		getResponseProjectList(1);
	});

//전체프로젝트 불러오는 함수
		function getProjectList(cPage) {
			$('.conteudo__cartoes-grid').html('');
			fetch(path+'/project/projectlistallajax?cPage=' + cPage+'&employeeNo='+empNo+'&status=1')
				.then(response => response.json())
				.then(data => {
					makeProjectList(data.projects,1);

					const $pagebar = createPagination(cPage, data.totalPage, 'getProjectList');
					$('.pagebar-div').html('').append($pagebar);
				})
				.catch(error => {
					console.error('요청 실패:', error); // 요청 실패 시 에러 처리
				});
		};

//본인 참여 프로젝트 불러오는 함수
		function getProjectListByEmpNo(cPage) {
			$('.conteudo__cartoes-grid').html('');
			fetch(path+'/project/projectlistallajax?cPage=' + cPage+'&employeeNo='+empNo+'&status=2')
				.then(response => response.json())
				.then(data => {
					makeProjectList(data.projects,2);

					const $pagebar = createPagination(cPage, data.totalPage, 'getProjectListByEmpNo');
					$('.pagebar-div').html('').append($pagebar);
				})
				.catch(error => {
					console.error('요청 실패:', error); // 요청 실패 시 에러 처리
				});
		};

//참여 요청한 프로젝트 불러오는 함수
		function getRequestProjectList(cPage) {
			$('.conteudo__cartoes-grid').html('');
			fetch(path+'/project/requestProjectlistallajax?cPage=' + cPage+'&employeeNo='+empNo)
				.then(response => response.json())
				.then(data => {
					makeProjectList(data.projects,3);

					const $pagebar = createPagination(cPage, data.totalPage, 'getRequestProjectList');
					$('.pagebar-div').html('').append($pagebar);
				})
				.catch(error => {
					console.error('요청 실패:', error); // 요청 실패 시 에러 처리
				});
		};

//참여 요청(온)!!! 프로젝트 불러오는 함수
		function getResponseProjectList(cPage) {
			$('.conteudo__cartoes-grid').html('');
			fetch(path+'/project/responseProjectlistallajax?cPage=' + cPage+'&employeeNo='+empNo)
				.then(response => response.json())
				.then(data => {
					makeProjectList2(data.projects);

					const $pagebar = createPagination(cPage, data.totalPage, 'getResponseProjectList');
					$('.pagebar-div').html('').append($pagebar);
				})
				.catch(error => {
					console.error('요청 실패:', error); // 요청 실패 시 에러 처리
				});
		};

		function makeProjectList(projects,num) {
				projects.forEach(p => {
					let $joinBtn;
					let joinMembers = p.memberEmployeeNos.split(',');
					let photos = p.memberPhotos.split(',').map(photo => photo.trim());
					let remainMember=joinMembers.length-3;
					let $addEmpCount='';
					let $projectInMember='';
					let $projectAtag='';
					console.log(p.projectRequestStatus);

					const $projectDiv=$('<div>',{class:'elemento__cartao--fundo',css:{backgroundImage:'url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)'}});
					const $projectDiv2=$('<div>',{class:'elemento__cartao--conteudo',id:'selectProejctInfo'});
					const $projectPtag=$('<p>',{class:'elemento__cartao--texto-categoria'}).html('프로젝트 번호 : <span id="requestProjectNo">'+p.projectNo+'</span><span id="requestProjectEmployeeNo">'+p.employeeNo+'</span>');
					const $projectH3tag=$('<h3>',{class:'elemento__cartao--texto-titulo'}).text(p.projectTitle);
					const $projectMemberWrab=$('<div>',{class:'container'});
					const $projectMemberWrab1=$('<div>',{id:'memberWrab'});
					//프로젝트 참여 요청중 버튼
					if(p.projectRequestStatus=='요청'){
						$projectAtag=$('<div>',{class:'elemento__cartao', href:'#',css:{cursor:'default'}});
						$joinBtn=$('<a>',{role: 'button', id: 'joinBtn', class: 'btn btn-secondary disabled', text: '참여 요청중'});
					//프로젝트 참여 요청중 - 거절됨 버튼
					}else if(p.projectRequestStatus=='거절'){
						$projectAtag=$('<div>',{class:'elemento__cartao', href:'#',css:{cursor:'default'}});
						$joinBtn=$('<button>',{type: 'button', id: 'refusedBtn', class: 'btn btn-danger', text: '참여 거절됨','data-bs-toggle': 'modal', 'data-bs-target': '#refusedModal','data-id':p.projectRefuseContent});
					//프로젝트 참여 요청 버튼
					}else if(p.projectRequestStatus==null || p.projectRequestStatus=='참여'){
						$projectAtag=$('<div>',{class:'elemento__cartao', href:'#',css:{cursor:'default'}});
						$joinBtn=$('<button>',{type: 'button', id: 'joinBtn', class: 'btn btn-primary', text: '참여 요청', 'data-bs-toggle': 'modal', 'data-bs-target': '#joinModal'});
						//본인 참여 프로젝트 표시 && 참여버튼 삭제
							if(num==2 || p.projectRequestStatus=='참여'){
						$projectAtag=$('<a>',{id:"projectListInfo",class:'elemento__cartao', href:'#', 'data-project-no': p.projectNo});
								$projectInMember=$('<div>',{class:'memberIcon'});
								$joinBtn='';
							}
					}
					if(remainMember!=0){
						$addEmpCount=$('<div>',{id:'addMember', class:'circle',text:'+'+remainMember});
					}
					//프로젝트 리스트 참여맴버 사진 출력문
					for(i=0;i<3;i++){
						let $memberPhoto='';
						if(photos[i]!='NULL'){
							$memberPhoto=$('<div>',{class:'circle', css:{backgroundImage:"url("+path+"/upload/employee/"+photos[i]+")",backgroundSize:"100% 100% "}});
						}else{
							$memberPhoto=$('<div>',{class:'circle', css:{backgroundImage:"url(https://blog.kakaocdn.net/dn/bCXLP7/btrQuNirLbt/N30EKpk07InXpbReKWzde1/img.png)",backgroundSize:"100% 100% "}});
						}
						$projectMemberWrab1.append($memberPhoto).append($addEmpCount);
					};

					$projectMemberWrab.append($projectMemberWrab1);
					$projectDiv2.append($projectPtag).append($projectH3tag).append($projectMemberWrab).append($projectInMember);
					$projectAtag.append($projectDiv).append($projectDiv2).append($joinBtn).appendTo($('.conteudo__cartoes-grid'));
				});
		};
//응답할 프로젝트 목록 만들기
function makeProjectList2(projects) {
				projects.forEach(p => {
					let $joinBtn;
					const $projectAtag=$('<a>',{class:'elemento__cartao', href:'#',css:{cursor:'default'}});
					const $projectDiv=$('<div>',{class:'elemento__cartao--fundo',css:{backgroundImage:'url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)'}});
					const $projectDiv2=$('<div>',{class:'elemento__cartao--conteudo'});
					const $projectPtag=$('<p>',{class:'elemento__cartao--texto-categoria'}).html('프로젝트 번호 : <span id="requestProjectNo">'+p.projectNo+'</span><span id="requestProjectEmployeeNo" style="display:none;">'+p.employeeNo+'</span>');
					const $projectH3tag=$('<h3>',{class:'elemento__cartao--texto-titulo'}).text(p.projectTitle);
					const $projectMemberWrab=$('<div>',{class:'container'});
					const $projectMemberWrab1=$('<div>',{id:'memberWrab'});

					$joinBtn=$('<a>',{role: 'button', id: 'responseBtn', class: 'btn btn-success','data-bs-toggle': 'modal', 'data-bs-target': '#projectResponseModal', text: '응답'});
					$projectMemberWrab1.html(p.employeeName+' : '+p.departmentTitle +'<span id="employeeNo" style="display:none;">'+p.projectEmployeeNo+"</span>");

					$projectMemberWrab.append($projectMemberWrab1);
					$projectDiv2.append($projectPtag).append($projectH3tag).append($projectMemberWrab).append($joinBtn);
					$projectAtag.append($projectDiv).append($projectDiv2).appendTo($('.conteudo__cartoes-grid'));
				});
		};

//프로젝트 참여 요청 보내기
	$(document).on('click', '#joinBtn', function(e) {
	    e.preventDefault(); // 기본 동작 방지 (모달 열림 방지)
	    let projectNo = $(this).closest('.elemento__cartao').find('#requestProjectNo').text();
	    let projectEmpNo = $(this).closest('.elemento__cartao').find('#requestProjectEmployeeNo').text();
		console.log(projectNo+"  "+projectEmpNo);
		 $('#projectRequestBtn').off('click').on('click', function() {
			fetch(path+'/project/requestProject.do',{
				method:'POST',
				headers: {
			        'Content-Type': 'application/json'
			    },
				body:JSON.stringify({  projectNo: parseInt(projectNo),empNo: parseInt(empNo),projectEmpNo: parseInt(projectEmpNo)}),
			})
			.then(response => {
		        if (!response.ok) {
		            throw new Error('서버 응답이 실패했습니다.');
		        }
		        return response.text();
		    })
			.then(data=>{
				alert("프로젝트 참여 요청 완료");
		    $('#joinModal').modal('hide');
			})
			.catch(error=>{
				alert("이미 참여요청한 프로젝트 입니다.");
				console.log(error);
			})

		});
	});

//참여 요청 승인 버튼 로직
	$(document).on('click', '#responseBtn', function(e) {
		let projectNo = $(this).closest('.elemento__cartao').find('#requestProjectNo').text();
		let empNo = $(this).closest('.elemento__cartao').find('#employeeNo').text();

		$("#requestApprovalBtn").click(e=>{
			fetch(path+"requestApprovalBtn.do",{
				method:'POST',
				headers: {
			        'Content-Type': 'application/json'
			    },
			     body: JSON.stringify({
		            projectNo: projectNo,
		            empNo: empNo
        		}),
			})
			.then(response => {
		        if (!response.ok) {
		            throw new Error('서버 응답이 실패했습니다.');
		        }
		        return response.text();
			})
			.then(data=>{
				alert("승인 완료");
				location.reload();
			})
			.catch(error=>{
				alert("프로젝트 승인 실패");
				console.log(error);
			})
		});
	});
//프로젝트 참여 요청 거절시
	//모달창 초기화
	$(document).on('click', '#responseBtn', function(e) {
		$("#requestRefuseResultBtn").css("display","none");
		$("#refuseTextarea").val("");
		$("#refuseTextarea").css("display","none");
		$("#requestRefuseCancleBtn").css("display","none");
		$("#requestRefuseBtn").css("display","block");
		$("#requestApprovalBtn").css("display","block");
		$(".modal-body").text("해당 사원의 프로젝트 참여를 허용하시겠습니까?");
	})
	$("#requestRefuseBtn").click(e=>{
		$("#requestRefuseResultBtn").css("display","block");
		$("#refuseTextarea").css("display","block");
		$("#requestRefuseCancleBtn").css("display","block");
		$("#requestRefuseBtn").css("display","none");
		$("#requestApprovalBtn").css("display","none");
		$(".modal-body").text("거절 사유를 입력해주세요.");
	});
	$("#requestRefuseCancleBtn").click(e=>{
		$("#requestRefuseResultBtn").css("display","none");
		$("#refuseTextarea").css("display","none");
		$("#requestRefuseCancleBtn").css("display","none");
		$("#requestRefuseBtn").css("display","block");
		$("#requestApprovalBtn").css("display","block");
		$(".modal-body").text("해당 사원의 프로젝트 참여를 허용하시겠습니까?");
	});
	//프로젝트 사유 적고 거절 시 최종 거절진행 - PROJECTR_REQUEST테이블에 수정(상태, 거절 코멘트)
	$(document).on('click', '#responseBtn', function(e) {
		let projectNo = $(this).closest('.elemento__cartao').find('#requestProjectNo').text();
		let empNo = $(this).closest('.elemento__cartao').find('#employeeNo').text();

		$("#requestRefuseResultBtn").click(e=>{
			const refuseComent = $('#refuseTextarea').val();
			fetch(path+'requestRefuseUpdate.do',{
				method:'POST',
				headers: {
			        'Content-Type': 'application/json'
			    },
			    body: JSON.stringify({
					refuseComent : refuseComent,
					projectNo : projectNo,
					empNo : empNo,
			    }),
			})
			.then(response => {
			        if (!response.ok) {
			            throw new Error('서버 응답이 실패했습니다.');
			        }
			        return response.text();
				})
				.then(data=>{
					alert("거절 완료");
					location.reload();
				})
				.catch(error=>{
					alert("프로젝트 거절 실패");
					console.log(error);
				})
			})
		});

//거절된 프로젝트 버튼 클릭시 모달에서 거절 사유 표시
	$(document).on('click', '#refusedBtn', function(e) {
		let projectNo = $(this).closest('.elemento__cartao').find('#requestProjectNo').text();

		const refuseComent = $(e.target).data('id');
		if(refuseComent==null){
			$("#refuseComent").text("등록된 사유가 없습니다.");
		}else{
			$("#refuseComent").text(refuseComent);
		}
		//거절 코멘트 확인 후 삭제 버튼
		$("#refusedCheckBtn").click(e=>{
			fetch(path+'refusedCheckDelete.do',{
				method:'POST',
				headers: {
			        'Content-Type': 'application/json'
			    },
			    body: JSON.stringify({
					projectNo : projectNo,
					empNo : empNo,
			    }),
			})
			.then(response => {
			        if (!response.ok) {
			            throw new Error('서버 응답이 실패했습니다.');
			        }
			        return response.text();
				})
				.then(data=>{
					location.reload();
				})
				.catch(error=>{
					alert("거절 코멘트 확인 후 삭제 실패");
					console.log(error);
				})
		});
	});

//프로젝트 전체 조회에서 프로젝트 클릭시 모달에 해당 프로젝트 정보 표시
	$(document).on('click', '#projectListInfo', function(e) {
		let projectNo = $(this).closest('.elemento__cartao').find('#requestProjectNo').text();
		let employeeNo = $(this).closest('.elemento__cartao').find('#requestProjectEmployeeNo').text();
		 location.assign(path+"/project/selectProjectListByNo.do?projectNo="+projectNo+"&empNo="+employeeNo);
	})