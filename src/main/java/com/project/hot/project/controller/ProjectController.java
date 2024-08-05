package com.project.hot.project.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.ProjectEmployee;
import com.project.hot.project.model.service.ProjectService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/project")
@RequiredArgsConstructor
public class ProjectController {

	private final ProjectService service;

	@ResponseBody
	@GetMapping("/projectupdateajax")
	public Map<String,Object> workInsertPage (@RequestParam(defaultValue = "1") int cPage,
													@RequestParam("employeeNo") int employeeNo) {
		ObjectMapper mapper=new ObjectMapper();
		try {
			mapper.writeValueAsString(service.selectProjectAll(Map.of("cPage",cPage,"numPerpage",5,"employeeNo",employeeNo)));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return service.selectProjectAll(Map.of("cPage",cPage,"numPerpage",5,"employeeNo",employeeNo));
	};

	@ResponseBody
	@GetMapping("/projectupdatelistajax")
	public Map<String,Object> projectUpdateListPage (@RequestParam(defaultValue = "1") int cPage,
													@RequestParam("employeeNo") int employeeNo) {
		ObjectMapper mapper=new ObjectMapper();
		try {
			mapper.writeValueAsString(service.updateProjectAll(Map.of("cPage",cPage,"numPerpage",5,"employeeNo",employeeNo)));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return service.updateProjectAll(Map.of("cPage",cPage,"numPerpage",5,"employeeNo",employeeNo));
	};

	@ResponseBody
	@GetMapping("/projectlistallajax")
	public Map<String,Object> projectListAll (@RequestParam(defaultValue = "1") int cPage
												,@RequestParam int employeeNo
												,@RequestParam int status) {
		ObjectMapper mapper=new ObjectMapper();
		try {
			mapper.writeValueAsString(service.selectProjectAll(Map.of("cPage",cPage,"numPerpage",8,"employeeNo",employeeNo,"status",status)));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return service.selectProjectAll(Map.of("cPage",cPage,"numPerpage",8,"employeeNo",employeeNo,"status",status));
	}

	@GetMapping("/projectinsert.do")
	public String projectInsertPage (Department d,Model m) {
		List<Department> depts = service.selectDeptAll();
		m.addAttribute("depts",depts);
		return "project/projectInsert";
	};

	@ResponseBody
	@GetMapping("/selectEmpByDept.do")
	public List<Employee> selectEmpByDept(@RequestParam("dept") int deptCode,
											@RequestParam("empNo") int empNo) {

	    List<Employee> result = service.selectEmpByDept(Map.of("deptCode",deptCode,"empNo",empNo));
	    return result;
	}

	@ResponseBody
	@PostMapping("/insertProject.do")
	public ResponseEntity<String> insertProject(@RequestBody Project projectData) {
		try {
			service.insertProject(projectData);
			return ResponseEntity.ok("프로젝트 등록 성공");
		} catch (Exception e) {
			log.error("=========프로젝트 등록 중 오류 발생=========", e);
			return ResponseEntity.badRequest().body("프로젝트 등록 실패");
		}
	}

	@ResponseBody
	@PostMapping("/updateProject.do")
	public ResponseEntity<String> updateProject(@RequestBody Project projectData){
		try {
			service.updateProject(projectData);
			return ResponseEntity.ok("프로젝트 업데이트 성공");
		} catch (Exception e) {
			log.error("=========프로젝트 업데이트 중 오류 발생=========", e);
			return ResponseEntity.badRequest().body("프로젝트 업데이트 실패");
		}
	}

//	@ResponseBody
//	@GetMapping("/selectProjectByNo.do")
//	public Project selectProjectByNo(@RequestParam("projectNo") int projectNo) {
//		Project result = service.selectProjectByNo(projectNo);
//		return result;
//	}
	//프로젝트 수정 - 프로젝트 기존정보 조회
	@GetMapping("/selectProjectByNo.do")
	public String selectProjectByNo(int projectNo,int empNo, Model m) {
		Project project = service.selectProjectByNo(projectNo);
		List<ProjectEmployee> emps = service.selectEmployeetByProjectNo(Map.of("projectNo",projectNo,"empNo",empNo));
		List<Department> depts = service.selectDeptAll();
		m.addAttribute("project",project);
		m.addAttribute("emps",emps);
		m.addAttribute("depts",depts);
		return "project/projectUpdateDetail";
	}
	//프로젝트 전체 조회 - 프로젝트 상세조회
	@GetMapping("/selectProjectListByNo.do")
	public String selectProjectListByNo(int projectNo,int empNo,Model m) {
		Project project = service.selectProjectByNo(projectNo);
		List<ProjectEmployee> emps = service.selectEmployeetByProjectNo(Map.of("projectNo",projectNo,"empNo",empNo));
		List<Department> depts = service.selectDeptAll();
		m.addAttribute("project",project);
		m.addAttribute("emps",emps);
		m.addAttribute("depts",depts);
		return "project/projectListInfo";
	}

	@ResponseBody
	@GetMapping("/selectEmployeetByProjectNo.do")
	public List<ProjectEmployee> selectEmployeetByProjectNo(@RequestParam("projectNo") int projectNo){
		List<ProjectEmployee> result = service.selectEmployeetByProjectNo(Map.of("projectNo",projectNo,"empNo",1));
		return result;
	}


	@ResponseBody
	@PostMapping("/deleteProject.do")
	public ResponseEntity<String> deleteProject(@RequestBody Map<String,Integer> param,
										HttpServletRequest request){
			// 파일 저장 위치 변수 저장
			int delProject=0;
			String path = request.getServletContext().getRealPath("/upload/projectWork");
	//기존 첨부파일 수정 시 삭제한 파일 upload에서 지우는 로직 && DB테이블에서도 지우기
			List<String> attList = service.selectDeleteAttList(param.get("projectNo"));
			File delFile = new File(path);
			// 해당 프로젝트 > 작업 파일들 삭제
			if (attList.size() > 0) {
				if (delFile.exists()) {
					// 해당파일에 존재하는 파일들 가져오기
					File[] files = delFile.listFiles();
					if (files != null) {
						for (File file : files) {
							// 파일안에 가져온 삭제할 rename파일이름이 존재하는지 확인 후 존재하면 해당파일 삭제
							if (file.isFile() && attList.contains(file.getName())) {
								file.delete();
							}
						}

						//파일 삭제 후 db테이블에서 데이터도 삭제 진행
						int result = service.deleteProjectWorkAtt(param.get("projectNo"));

						if(result>0) {
							return ResponseEntity.ok("파일 삭제 성공");
						}else {
							return ResponseEntity.badRequest().body("파일 삭제 실패");
						}
					}
				}
			}
			service.deleteProject(param.get("projectNo"));
			return ResponseEntity.ok("프로젝트 삭제 성공");
		}

	@ResponseBody
	@PostMapping("/requestProject.do")
	public ResponseEntity<String> insertRequestJoinProject(@RequestBody Map<String, Integer> requestData){
		try {
			service.requestJoinProject(requestData);
			return ResponseEntity.ok("프로젝트 참여 요청 성공");
		} catch (Exception e) {
			log.error("=========프로젝트 참여 요청 중 오류 발생=========", e);
			return ResponseEntity.badRequest().body("프로젝트 참여 요청 실패");
		}
	}

	@ResponseBody
	@GetMapping("/requestProjectlistallajax")
	public Map<String,Object> requestProjectlistall(@RequestParam(defaultValue = "1") int cPage
														,@RequestParam int employeeNo){
		ObjectMapper mapper=new ObjectMapper();
		try {
			mapper.writeValueAsString(service.requestProjectlistall(Map.of("cPage",cPage,"numPerpage",8,"employeeNo",employeeNo)));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return service.requestProjectlistall(Map.of("cPage",cPage,"numPerpage",8,"employeeNo",employeeNo));

	}

	@ResponseBody
	@GetMapping("/responseProjectlistallajax")
	public Map<String,Object> responseProjectlistall(@RequestParam(defaultValue = "1") int cPage
														,@RequestParam int employeeNo){
		  Map<String, Object> result = service.responseProjectlistall(
	                Map.of("cPage", cPage, "numPerpage", 8, "employeeNo", employeeNo)
	        );
	        try {
	            ObjectMapper mapper = new ObjectMapper();
	            String jsonResult = mapper.writeValueAsString(result);
	            System.out.println("확인용 : " + jsonResult);
	        } catch (JsonProcessingException e) {
	            e.printStackTrace();
	        }
	        return result;
	}

	@ResponseBody
	@PostMapping("/requestApprovalBtn.do")
	public ResponseEntity<String> requestApproval(@RequestBody Map<String, String> param){
		try {
			int projectNo = Integer.parseInt(param.get("projectNo"));
		    int empNo = Integer.parseInt(param.get("empNo"));
			service.responseApproval(Map.of("projectNo",projectNo,"empNo",empNo));
			return ResponseEntity.ok("프로젝트 참여 요청 성공");
		}catch(Exception e) {
			log.error("=========프로젝트 참여 승인 중 오류 발생=========", e);
			return ResponseEntity.badRequest().body("프로젝트 참여 승인 실패");
		}
	}

	@ResponseBody
	@PostMapping("/requestRefuseUpdate.do")
	public ResponseEntity<String> requestRefuseUpdate(@RequestBody Map<String, Object> param){
		try {
			String refuseComent = (String)param.get("refuseComent");
			String projectNo = (String) param.get("projectNo");
		    String empNo = (String) param.get("empNo");
			service.requestRefuseUpdate(Map.of("refuseComent",refuseComent,"projectNo",projectNo,"empNo",empNo));
			return ResponseEntity.ok("프로젝트 참여 거절 성공");
		}catch(Exception e) {
			log.error("=========프로젝트 참여 거절 중 오류 발생=========", e);
			return ResponseEntity.badRequest().body("프로젝트 참여 거절 실패");
		}
	}

	@ResponseBody
	@PostMapping("/refusedCheckDelete.do")
	public ResponseEntity<String> refusedCheckDelete(@RequestBody Map<String, Integer> param){
		try {
			int projectNo = param.get("projectNo");
		    int empNo = param.get("empNo");
			service.refusedCheckDelete(Map.of("projectNo",projectNo,"empNo",empNo));
			return ResponseEntity.ok("거절 코멘트 확인 후 삭제 성공");
		}catch(Exception e) {
			log.error("=========프로젝트 참여 거절 중 오류 발생=========", e);
			return ResponseEntity.badRequest().body("거절 코멘트 확인 후 삭제 실패");
		}
	}

}
