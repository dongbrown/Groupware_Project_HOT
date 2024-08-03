/**
 *
 */
const path ="${path}";
const type ="${myapprovalType}";
let mydoc='${mydoc}';
try{
	mydoc = JSON.parse(mydoc.replace(/&quot;/g, '"'));
} catch(error){
	console.error("JSON 파싱오류:", error)
}
switch(type){
	case 1: /* 내 기안 문서 */
		console.log(mydoc);
	break;
	case 2: /* 수신 문서 */

	break;
	case 3: /* 참조 문서 */

	break;
	case 4: /* 열람 문서 */

	break;
	case 5: /* 임시저장 문서 */

	break;
}