/*
	조직도 페이지용 js~
*/

$(document).ready(()=>{
	selectAllEmployee();
});


//조직도 차트 그리기
function makeOrgChart(employees){

}

//사원들 정보 가져오기
function selectAllEmployee(){

	//회사 사원, 부서 정보 가져오기
	fetch(path+'/api/hr/selectAllEmployee')
	.then(response=>response.json())
	.then(data=>{
		console.log(data);
		makeOrgChart(data);
	})
	.catch(error=>{
		console.log(error);
	})
}