/**
 *  주소록 페이지 용 js ~
 */

$(document).ready(() => {
	getEmployeeList(1);
	getDepartmentList();
});

function getEmployeeList(cPage) {
	fetch(path + '/api/employeeList?cPage=' + cPage)
		.then(response => response.json())
		.then(data => {
			console.log(data);
			const $pagebar = createPagination(cPage, data.totalData, path + '/api/employeeList');
			$('.pagebar-div').append($pagebar);
		})
		.catch(error => {
			console.error('요청 실패:', error); // 요청 실패 시 에러 처리
		});
}
function getDepartmentList() {
	fetch(path + '/api/departmentList')
		.then(response => response.json())
		.then(data => {
			console.log(data);
		})
		.catch(error => {
			console.error('요청 실패:', error); // 요청 실패 시 에러 처리
		});
}