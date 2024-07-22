/*
	조직도 페이지용 js~
*/

$(document).ready(()=>{
	selectOrgData();

});

//조직도 차트 그리기
function makeOrgChart(orgData){

      const options = {
        contentKey: 'data',
        width: 1100,
        height: 700,
        nodeWidth: 200,
        nodeHeight: 140,
        fontColor: '#fff',
        borderColor: '#333',
        childrenSpacing: 50,
        siblingSpacing: 20,
        direction: 'top',
        enableExpandCollapse: true,
        nodeTemplate: (content) =>
          `<div style='display: flex;flex-direction: column;gap: 5px;justify-content: center;align-items: center;height: 100%;'>
          		${content.dept!=null?`<img style='width: 50px;height: 50px;border-radius: 50%;'
          		src=${content.url!=null?`${path+'/upload/employee/'+content.url}`:`${path+'/images/undraw_profile.svg'}`} alt='' />`:``}
          		<div style="font-weight: bold; font-family: Arial; font-size: 14px">
          			${content.name}
          			${content.dept!=null?`<span> ${content.pos}</span>`:``}
          			${content.dept!=null?`<span> ${content.dept}</span>`:``}
          		</div>
           </div>`,
        canvasStyle: 'border: 1px solid black;background: #f6f6f6;',
        enableToolbar: true,
      };
      const tree = new ApexTree(document.getElementById('svg-tree'), options);
      return tree.render(orgData);
}

//사원, 부서 정보 가져오기
function selectOrgData(){

	//회사 사원, 부서 정보 가져오기
	fetch(path+'/api/hr/selectOrgData')
	.then(response=>response.json())
	.then(data=>{
		console.log(data);
		//조직도 그리기
		const graph=makeOrgChart(data);
		data.children.forEach(e=>{
			e.children.forEach(c=>{
				graph.collapse(c.id);
			})
			graph.collapse(e.id);
		})
	  	graph.fitScreen();
	})
	.catch(error=>{
		console.log(error);
	})
}