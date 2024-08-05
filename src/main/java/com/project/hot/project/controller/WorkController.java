package com.project.hot.project.controller;

import java.io.File;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.Work;
import com.project.hot.project.model.service.ProjectService;
import com.project.hot.project.model.service.WorkService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/work")
@RequiredArgsConstructor
public class WorkController {

	private final WorkService workService;
	private final ProjectService projectService;
	static private List<Object> fileRenameList;

	@ResponseBody
	@GetMapping("/projectupdateajax")
	public Map<String,Object> projectUpdatePage (@RequestParam(defaultValue = "1") int cPage,
													@RequestParam("employeeNo") int employeeNo) {
		ObjectMapper mapper=new ObjectMapper();
		try {
			mapper.writeValueAsString(workService.selectProjectAll(Map.of("cPage",cPage,"numPerpage",5,"employeeNo",employeeNo)));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return workService.selectProjectAll(Map.of("cPage",cPage,"numPerpage",5,"employeeNo",employeeNo));
	};

	@GetMapping("/insertwork.do")
	public String insertWork (int projectNo,Model m) {
		Project project = projectService.selectProjectByNo(projectNo);
		m.addAttribute("project",project);
		System.out.println(project);
		 return "project/insertWorkDetail";
	}

	//작업 수정
	@GetMapping("/workupdatedetail.do")
	public String workUpdate (int workNo,Model m) {
		Work work = workService.selectWorkByWorkNo(workNo);
//		fileRenameList.clear();
//		work.getProjectAtt().forEach(e->{
//			fileRenameList.add(e);
//		});
		m.addAttribute("work",work);
		return "project/workUpdateDetail";
	}
	//전체 프로젝트 조회 - 프로젝트 작업 리스트 - 작업 상세 조회
	@GetMapping("/selectworkdetail.do")
	public String selectWorkDetail (int workNo,Model m) {
		Work work = workService.selectWorkByWorkNo(workNo);
		m.addAttribute("work",work);
		return "project/selectWorkDetail";
	}


//작업 정보 저장 시 포함되어있는 파일 등록/저장
	@ResponseBody
	@PostMapping("/insertWorkDetail.do")
	public ResponseEntity<String> insertWork(
	        @RequestParam(value = "files", required = false) List<MultipartFile> workDatas,
	        @RequestParam int projectNo,
	        @RequestParam int employeeNo,
	        @RequestParam String projectWorkTitle,
	        @RequestParam String projectWorkContent,
	        @RequestParam Date projectWorkEndDate,
	        @RequestParam int projectWorkRank,
	        HttpServletRequest request) {

		//work 객체에 데이터 저장
		Work workData = new Work();
		workData.setProjectNo(projectNo);
		workData.setEmployeeNo(employeeNo);
		workData.setProjectWorkTitle(projectWorkTitle);
		workData.setProjectWorkContent(projectWorkContent);
		workData.setProjectWorkEndDate(projectWorkEndDate);
		workData.setProjectWorkRank(projectWorkRank);
		//작업 등록
		int workResult=workService.insertWorkDetail(workData);
	    // 파일 저장 위치 변수 저장
	    String path = request.getServletContext().getRealPath("/upload/projectWork");
	    File dir = new File(path);
	    if (!dir.exists()) dir.mkdir();

	    if (workDatas != null && !workDatas.isEmpty()) {
	        for (MultipartFile e : workDatas) {
	            // 원본 파일 이름
	            String oriname = e.getOriginalFilename();
	            // 파일 확장자명
	            String ext = oriname.substring(oriname.lastIndexOf("."));
	            // 변경 이름 설정(날짜 + 랜덤 문자 + 확장자)
	            String rename = LocalDate.now().format(DateTimeFormatter.BASIC_ISO_DATE)
	                    + "_"
	                    + String.format("%06d", new Random().nextInt(1000000))
	                    + ext;

	            // 첨부파일 저장하기
	            try {
	                e.transferTo(new File(path, rename));
	                //작업등록 성공시 첨부파일 테이블에 데이터 저장
	                if(workResult>0) {
	                int result = workService.insertWorkAtt(Map.of(
	                		"projectNo",workData.getProjectNo(),"employeeNo",workData.getEmployeeNo()
	                		,"fileName",e.getOriginalFilename(),"rename",rename,"projectWorkNo",workData.getProjectWorkNo()));
	                }else {
	                	ResponseEntity.badRequest().body("파일 등록 실패");
	                }
	            } catch (Exception i) {
	                i.printStackTrace();
	                return ResponseEntity.badRequest().body("파일 저장 실패: " + i.getMessage());
	            }
	        }
	        return ResponseEntity.ok().body("파일 저장 성공");
	    }
	    return ResponseEntity.ok().body("작업 업데이트 성공");
	}

	@ResponseBody
	@PostMapping("/deleteWork.do")
	public ResponseEntity<String> deleteWork(@RequestBody Map<String,Integer> param,
										HttpServletRequest request){
			// 파일 저장 위치 변수 저장
			String path = request.getServletContext().getRealPath("/upload/projectWork");
	//기존 첨부파일 수정 시 삭제한 파일 upload에서 지우는 로직 && DB테이블에서도 지우기
			List<String> attList = workService.selectDeleteAttList(param.get("workNo"));
			File delFile = new File(path);
			// 해당 작업 파일들 삭제
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
						int result = workService.deleteWorkAtt(param.get("workNo"));
						if(result>0) {
							workService.deleteWork(param.get("workNo"));
						}else {
							return ResponseEntity.badRequest().body("작업 삭제 실패");
						}
					}
				}
			}
			return ResponseEntity.ok().body("작업 삭제 성공");
		}

	@ResponseBody
	@GetMapping("/workupdateajax")
	public Map<String,Object> workUpdatePage(@RequestParam(defaultValue = "1") int cPage,
											@RequestParam("employeeNo") int employeeNo,
											@RequestParam("projectNo") int projectNo) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			mapper.writeValueAsString(
					workService.selectWorkAll(Map.of("cPage", cPage, "numPerpage", 5, "employeeNo", employeeNo,"projectNo",projectNo)));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return workService.selectWorkAll(Map.of("cPage", cPage, "numPerpage", 5, "employeeNo", employeeNo,"projectNo",projectNo));
	};

	@ResponseBody
	@PostMapping("/workupdateajax")
	public ResponseEntity<String> workUpdate(
			 	@RequestParam(value = "files", required = false) List<MultipartFile> workDatas,
		        @RequestParam int projectWorkNo,
		        @RequestParam int projectWorkProgress,
		        @RequestParam String projectWorkTitle,
		        @RequestParam String projectWorkContent,
		        @RequestParam Date projectWorkEndDate,
		        @RequestParam int projectWorkRank,
		        @RequestParam int employeeNo,
		        @RequestParam(required = false) List<String> delFileList,
		        HttpServletRequest request){
//work 객체에 데이터 저장
		Work workData = new Work();
		workData.setProjectWorkNo(projectWorkNo);
		workData.setProjectWorkProgress(projectWorkProgress);
		workData.setProjectWorkTitle(projectWorkTitle);
		workData.setProjectWorkContent(projectWorkContent);
		workData.setProjectWorkEndDate(projectWorkEndDate);
		workData.setEmployeeNo(employeeNo);
		workData.setProjectWorkRank(projectWorkRank);

//작업 업데이트
		int workResult = workService.updateWorkDetail(workData);
// 파일 저장 위치 변수 저장
		String path = request.getServletContext().getRealPath("/upload/projectWork");
//기존 첨부파일 수정 시 삭제한 파일 upload에서 지우는 로직 && DB테이블에서도 지우기
		File delFile = new File(path);
		// db에 기존파일 삭제한 파일자료 삭제
		if (delFileList.size() > 0) {
			int attDelFileResult = workService.deleteWorkAtt(delFileList);
			if (attDelFileResult > 0) {
				// projectWork폴더가 존재 확인
				if (delFile.exists()) {
					// 해당파일에 존재하는 파일들 가져오기
					File[] files = delFile.listFiles();
					// 해당파일이 존재하면 실행 로직
					if (files != null) {
						for (File file : files) {
							// 파일안에 가져온 삭제할 rename파일이름이 존재하는지 확인 후 존재하면 해당파일 삭제
							if (file.isFile() && delFileList.contains(file.getName())) {
								file.delete();
							}
						}
					}
				}
			}
		}
		File dir = new File(path);
		if (!dir.exists())
			dir.mkdir();

		if (workDatas != null && !workDatas.isEmpty()) {
			for (MultipartFile e : workDatas) {
				// 원본 파일 이름
				String oriname = e.getOriginalFilename();
				// 파일 확장자명
				String ext = oriname.substring(oriname.lastIndexOf("."));
				// 변경 이름 설정(날짜 + 랜덤 문자 + 확장자)
				String rename = LocalDate.now().format(DateTimeFormatter.BASIC_ISO_DATE) + "_"
						+ String.format("%06d", new Random().nextInt(1000000)) + ext;

				// 첨부파일 저장하기
				try {
					e.transferTo(new File(path, rename));
					// 작업등록 성공시 첨부파일 테이블에 데이터 저장
					if (workResult > 0 && workDatas.size() > 0) {
						int result = workService.insertWorkAtt(Map.of("projectNo", workData.getProjectNo(),
								"employeeNo", workData.getEmployeeNo(), "fileName", e.getOriginalFilename(), "rename",
								rename, "projectWorkNo", workData.getProjectWorkNo()));
					} else {
						ResponseEntity.badRequest().body("작업 등록 실패");
					}
				} catch (Exception i) {
					i.printStackTrace();
					return ResponseEntity.badRequest().body("작업 업데이트 실패: " + i.getMessage());
				}
			}
			return ResponseEntity.ok().body("파일 저장 성공");
		}
		return ResponseEntity.ok().body("파일 저장 성공");

	}


}
