package com.project.hot.project.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

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

import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.Work;
import com.project.hot.project.model.service.ProjectService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/work")
@RequiredArgsConstructor
public class WorkController {

	private final ProjectService service;

	@GetMapping("/insertwork.do")
	public String insertWork (int projectNo,Model m) {
		Project project = service.selectProjectByNo(projectNo);
		m.addAttribute("project",project);
		 return "project/insertWorkDetail";
	}
//작업 정보 저장
	@ResponseBody
	@PostMapping("/insertWorkDetail.do")
	public ResponseEntity<String> insertWorkDetail(@RequestBody Work work){
		try {
			//service.insertWorkDetail(work);
			return ResponseEntity.ok("프로젝트 업데이트 성공");
		} catch (Exception e) {
			log.error("=========프로젝트 등록 중 오류 발생=========", e);
			return ResponseEntity.badRequest().body("프로젝트 업데이트 실패");
		}
	}
//작업 정보 저장 시 포함되어있는 파일 등록/저장
	@ResponseBody
	@PostMapping("/insertworkatt.do")
	public ResponseEntity<String> insertWorkAtt(
			@RequestParam("files") List<MultipartFile> workDatas
			,@RequestParam int employeeNo
			,@RequestParam int projectNo
			, HttpServletRequest request){
		if(!workDatas.isEmpty()) {
			String path = request.getServletContext().getRealPath("/upload/projectWork");
			workDatas.forEach(e->{
				//원본 파일 이름
				String oriname = e.getOriginalFilename();
				//상단 파일 확장자명
				String ext = oriname.substring(oriname.lastIndexOf("."));
				//변경 이름 설정(날짜 + 랜덤 문자 + 확장자)
				String rename=LocalDateTime.now().toLocalDate().toString()+"_"+UUID.randomUUID().toString()+ext;
				//폴더 없으면 생성하는 로직
				File dir = new File(path);
				if(!dir.exists()) dir.mkdir();

				//첨부파일 저장하기
				try {
					e.transferTo(new File(path, rename));
				}catch(Exception i) {
					i.printStackTrace();
				}
			});
		}
		return ResponseEntity.ok("프로젝트 업데이트 성공");
	}


}
