package com.project.hot.approval.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.approval.model.dto.RequestApproval;
import com.project.hot.approval.model.dto.VacationForm;
import com.project.hot.approval.model.service.ApprovalService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/approval")
public class ApprovalRestController {

	private final ApprovalService service;

	@GetMapping("/getApprovalsCountAndList")
	public Map<String, Object> getApprovalsCountAndList(@RequestParam int no, @RequestParam(defaultValue = "1") int cPage) {
		Map<String, Object> param=new HashMap<>();
		param.put("no", no);
		param.put("cPage", cPage);
		param.put("numPerpage", 10);
		return service.getApprovalsCountAndList(param);
	}

	@PostMapping("/insertVacation")
	public String insertVacation(
			@RequestParam("upFile") MultipartFile[] upFile,
			@ModelAttribute RequestApproval ra,
			@ModelAttribute VacationForm vf,
			HttpServletRequest req) {
		Map<String, Object> param=Map.of("ra", ra, "vf", vf, "upFile", upFile, "path", req.getServletContext().getRealPath("/upload/approval"));
		int result=service.insertVacation(param);
		if(result>0) {
			return "완료!";
		}else {
			return "실패!";
		}
	}
}
