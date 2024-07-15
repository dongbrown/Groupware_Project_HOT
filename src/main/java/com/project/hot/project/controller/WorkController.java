package com.project.hot.project.controller;

import java.io.File;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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

	@GetMapping("/insertwork.do")
	public String insertWork (int projectNo,Model m) {
		Project project = projectService.selectProjectByNo(projectNo);
		m.addAttribute("project",project);
		 return "project/insertWorkDetail";
	}

	@GetMapping("/workupdatedetail.do")
	public String workUpdate (int workNo,Model m) {
		Work work = workService.selectWorkByWorkNo(workNo);
		m.addAttribute("work",work);
		return "project/workUpdateDetail";
	}


//작업 정보 저장 시 포함되어있는 파일 등록/저장
	@ResponseBody
	@PostMapping("/insertWorkDetail.do")
	public ResponseEntity<String> insertWorkAtt(
	        @RequestParam("files") List<MultipartFile> workDatas,
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

	    if (!workDatas.isEmpty()) {
	        for (MultipartFile e : workDatas) {
	            // 원본 파일 이름
	            String oriname = e.getOriginalFilename();
	            // 파일 확장자명
	            String ext = oriname.substring(oriname.lastIndexOf("."));
	            // 변경 이름 설정(날짜 + 랜덤 문자 + 확장자)
	            String rename = LocalDateTime.now().toLocalDate().toString() + "_" + UUID.randomUUID().toString() + ext;

	            // 첨부파일 저장하기
	            try {
	                e.transferTo(new File(path, rename));
	                //작업등록 성공시 첨부파일 테이블에 데이터 저장
	                if(workResult>0) {
	                int result = workService.insertWorkAtt(Map.of(
	                		"projectNo",workData.getProjectNo(),"employeeNo",workData.getEmployeeNo()
	                		,"fileName",e.getName(),"rename",rename,"projectWorkNo",workData.getProjectWorkNo()));
	                }else {
	                	ResponseEntity.badRequest().body("작업 등록 실패");
	                }
	            } catch (Exception i) {
	                i.printStackTrace();
	                return ResponseEntity.badRequest().body("작업 업데이트 실패: " + i.getMessage());
	            }
	        }
	        return ResponseEntity.ok().body("파일 저장 성공");
	    } else {
	        return ResponseEntity.badRequest().body("파일 저장 실패");
	    }
	}

	@ResponseBody
	@GetMapping("/workupdateajax")
	public Map<String,Object> workUpdatePage(@RequestParam(defaultValue = "1") int cPage,
			@RequestParam("employeeNo") int employeeNo) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			mapper.writeValueAsString(
					workService.selectWorkAll(Map.of("cPage", cPage, "numPerpage", 5, "employeeNo", employeeNo)));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return workService.selectWorkAll(Map.of("cPage", cPage, "numPerpage", 5, "employeeNo", employeeNo));
	};


}
