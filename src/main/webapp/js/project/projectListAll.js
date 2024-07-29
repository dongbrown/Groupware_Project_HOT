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
			fetch('/project/projectlistallajax?cPage=' + cPage+"&employeeNo=0")
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

//전체프로젝트 불러오는 함수
		function getProjectListByEmpNo(cPage) {
			$('.conteudo__cartoes-grid').html('');
			fetch('/project/projectlistallajax?cPage=' + cPage+'&employeeNo='+empNo)
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

//참여 요청한 프로젝트 불러오는 함수
		function getRequestProjectList(cPage) {
			$('.conteudo__cartoes-grid').html('');
			fetch('/project/requestProjectlistallajax?cPage=' + cPage+'&employeeNo='+empNo)
				.then(response => response.json())
				.then(data => {
					makeProjectList(data.projects,1);

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
			fetch('/project/responseProjectlistallajax?cPage=' + cPage+'&employeeNo='+empNo)
				.then(response => response.json())
				.then(data => {
					makeProjectList(data.projects,1);

					const $pagebar = createPagination(cPage, data.totalPage, 'getResponseProjectList');
					$('.pagebar-div').html('').append($pagebar);
				})
				.catch(error => {
					console.error('요청 실패:', error); // 요청 실패 시 에러 처리
				});
		};

		function makeProjectList(projects,num) {

				projects.forEach(p => {
					let joinMembers;
					let photos;
					let remainMember;
					let $joinBtn;
					if(num===1){
						joinMembers = p.memberEmployeeNos.split(',');
						photos = p.memberPhotos.split(',');
						remainMember=photos.length-3;
					};
					let $addEmpCount='';
					let $projectInMember='';
					const $projectAtag=$('<a>',{class:'elemento__cartao', href:'#', 'data-project-no': p.projectNo});
					const $projectDiv=$('<div>',{class:'elemento__cartao--fundo',css:{backgroundImage:'url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)'}});
					const $projectDiv2=$('<div>',{class:'elemento__cartao--conteudo'});
					const $projectPtag=$('<p>',{class:'elemento__cartao--texto-categoria'}).html('프로젝트 번호 : <span id="requestProjectNo">'+p.projectNo+'</span><span id="requestProjectEmployeeNo" style="display:none;">'+p.employeeNo+'</span>');
					const $projectH3tag=$('<h3>',{class:'elemento__cartao--texto-titulo'}).text(p.projectTitle);
					const $projectMemberWrab=$('<div>',{class:'container'});
					const $projectMemberWrab1=$('<div>',{id:'memberWrab'});
					//프로젝트 참여 요청중 버튼
					if(p.projectRequestStatus=='요청' && p.projectRequestEmployee==empNo){
						$joinBtn=$('<a>',{role: 'button', id: 'joinBtn', class: 'btn btn-secondary disabled', text: '참여 요청중'});
					//프로젝트 참여온거에 대한 응답 버튼
					}else if(p.projectRequestStatus=='요청' && p.requestProject.employeeNo==empNo){
						$joinBtn=$('<a>',{role: 'button', id: 'joinBtn', class: 'btn btn-success','data-bs-toggle': 'modal', 'data-bs-target': '#projectResponseModal', text: '응답'});
					//프로젝트 참여 요청 버튼
					}else{
						$joinBtn=$('<button>',{type: 'button', id: 'joinBtn', class: 'btn btn-primary', text: '참여 요청', 'data-bs-toggle': 'modal', 'data-bs-target': '#joinModal'});
						//본인 참여 프로젝트 표시 && 참여버튼 삭제
						for(i=0;i<joinMembers.length;i++){
							if(empNo==Number(joinMembers[i])){
								$projectInMember=$('<div>',{class:'memberIcon'});
								$joinBtn='';
							}else if(empNo!=Number(joinMembers[i])){
							}
						}
					}
					if(remainMember!=0){
						$addEmpCount=$('<div>',{id:'addMember', class:'circle',text:'+'+remainMember});
					}
					if(p.projectRequestStatus=='요청' && p.requestProject.employeeNo==empNo){
						$projectMemberWrab1.text(p.requestProject.projectRequestEmployee);
					}else{
						//프로젝트 리스트 참여맴버 사진 출력문
						for(i=0;i<3;i++){
							let $memberPhoto='';
							if(photos[i]=='NULL'){
								$memberPhoto=$('<div>',{class:'circle', css:{backgroundImage:"url(https://blog.kakaocdn.net/dn/bCXLP7/btrQuNirLbt/N30EKpk07InXpbReKWzde1/img.png)",backgroundSize:"100% 100% "}});
							}else{
								$memberPhoto=$('<div>',{class:'circle', css:{backgroundImage:"url("+path+"/upload/employee/"+photos[i]+")",backgroundSize:"100% 100% "}});
							}
							$projectMemberWrab1.append($memberPhoto).append($addEmpCount);
						};
					};
					$projectMemberWrab.append($projectMemberWrab1);
					$projectDiv2.append($projectPtag).append($projectH3tag).append($projectMemberWrab).append($joinBtn).append($projectInMember);
					$projectAtag.append($projectDiv).append($projectDiv2).appendTo($('.conteudo__cartoes-grid'));
				});
		};

//프로젝트 참여 요청 보내기
	$(document).on('click', '#joinBtn', function(e) {
	    e.preventDefault(); // 기본 동작 방지 (모달 열림 방지)
	    let projectNo = $(this).closest('.elemento__cartao').find('#requestProjectNo').text();
	    let projectEmpNo = $(this).closest('.elemento__cartao').find('#requestProjectEmployeeNo').text();

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

