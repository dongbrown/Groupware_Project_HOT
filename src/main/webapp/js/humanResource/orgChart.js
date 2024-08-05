/*
	조직도 페이지용 js~
*/

$(document).ready(()=>{
	selectOrgData();

});

//조직도 차트 그리기
function makeOrgChart(orgData) {

	const options = {
		contentKey: 'data',
		width: 1100,
		height: 700,
		nodeWidth: 300,
		nodeHeight: 120,
		fontColor: '#000',
		borderColor: '#333',
		childrenSpacing: 50,
		siblingSpacing: 20,
		direction: 'top',
		enableExpandCollapse: true,
		nodeTemplate: (content) => {
			console.log(content);
			if (content.dept != null) {
				return `
                <div style="
    width: 100%;
    height: 100%;
    background-color: #fff;
    border-radius: 5px;
    display: flex;
    align-items: center;
    padding: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
">
    <div style="
        width: 80px;
        height: 80px;
        background-color: #e0e0e0;
        border-radius: 4px;
        overflow: hidden;
        margin-right: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
    ">
        <img src="${content.url != null ? path + '/upload/employee/' + content.url : path + '/images/undraw_profile.svg'}" alt="Profile Image" style="
            width: 100%;
            height: 100%;
        "/>
    </div>
    <div style="
        display: flex;
        flex-direction: column;
        justify-content: center;
        width: calc(100% - 90px);
        height: 80px; /* 이미지 높이와 맞추기 위해 추가 */
    ">
        <div style="
            background-color: #346aff;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            padding: 1px 0;
            margin-bottom: 10px;
            width: 100%;
        ">
            ${content.name}
        </div>
        <div style="
            font-size: 14px;
            text-align: center;
            margin-bottom: 5px;
        ">
            ${content.pos}
        </div>
        <div style="
            font-size: 12px;
            text-align: center;
            color: #757575;
        ">
            ${content.dept}
        </div>
    </div>
</div>
            `;
			} else {
				return `
                <div style="
                    width: 100%;
                    height: 100%;
                    background-color: #fff;
                    border-radius: 5px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 10px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    text-align: center;
                    font-size: 24px;
                    font-weight: bold;
                ">
                    ${content.name}
                </div>
            `;
			}
		},
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