//프로젝트 업데이트 기능
	$(document).ready(function() {
//부서 목록 출력
	getDepartmentList();

		$('#updateProjectBtn').click(e => {
//프로젝트 입력 내용 json 저장
			const projectData = {
				projectNo: $('input[name="projectNo"]').val(),
				projectTitle: $('input[name="projectTitle"]').val(),
				projectRank: Number($('#project-rank').val()),
				projectContent: $('#floatingTextarea').val(),
				projectBudget: Number($('#project-budget').val().replace(/,/g, "")),
				projectEndDate: $('#project-end-date').val(),
				projectProgress:Number($('#project-progress').val()),
				employee:[]
			};
			console.log(projectData);

//프로젝트 참여 맴버 json 저장
			$('#saved-members .saved-item').each(function() {
				let text = $(this).text().trim();
			    let parts = text.split(':');
			    let nameParts = parts[1].split('사번 /');
			    let empNo = Number(nameParts[1].trim());
			    projectData.employee.push({
			        employeeNo: empNo
			    });
			});

//프로젝트 업데이트 ajax
			$.ajax({
				url: '/project/updateProject.do',
				type: 'POST',
				contentType: 'application/JSON',
				data: JSON.stringify(projectData),
				success: function(response) {
					alert("프로젝트 수정이 완료되었습니다.")
					console.log(projectData);
					location.assign("/project/projectupdate.do");
				},
				error: function(error) {
					alert("프로젝트 수정이 실패하였습니다.")
					console.log(projectData);
					location.assign("/project/projectupdate.do");
				}
			});
		});
	});
//부서 데이터 가져오는 함수
	function getDepartmentList() {
		fetch(path + '/api/departmentList')
			.then(response => response.json())
			.then(data => {
				const $target = $('#select-dept');
				data.forEach(d => {
					const $departmentTitle = $(d.departmentHighCode <= 1 ?'<option disabled>':'<option>')
					.val(d.departmentCode)
					.text(d.departmentHighCode <= 1 ? `--------- ${d.departmentTitle}부 ---------`: d.departmentTitle);
					$target.append($departmentTitle);
				});
			})
			.catch(error => {
				console.error('요청 실패:', error); // 요청 실패 시 에러 처리
			});
	}




