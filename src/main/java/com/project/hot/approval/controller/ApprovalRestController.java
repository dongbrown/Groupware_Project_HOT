package com.project.hot.approval.controller;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.hot.approval.model.service.ApprovalService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/approval")
public class ApprovalRestController {

	private final ApprovalService service;

	@GetMapping("/getApprovalsCountAndList")
	public Map<String, Object> getApprovalsCountAndList(@RequestParam int no) {
		return service.getApprovalsCountAndList(no);
	}
}
