//프로젝트 업데이트 기능
	$(document).ready(function() {
		$('#updateProjectBtn').click(e => {
//프로젝트 입력 내용 json 저장
			const projectData = {
				projectTitle: $('input[name="projectTitle"]').val(),
				projectRank: $('#project-rank').val(),
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
			    let empNo = nameParts[1].trim();
			    projectData.employee.push(empNo);
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
					location.assign("/");
				},
				error: function(error) {
					console.log(projectData);
					alert("프로젝트 수정이 실패하였습니다.")
					location.assign("/project/projectupdate.do");
				}
			});
		});
	});
