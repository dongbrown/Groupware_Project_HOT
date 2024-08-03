package com.project.hot.approval.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.hot.approval.model.service.ApprovalService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/myapproval")
@Controller
public class MyApprovalDocumentController {
	private final ApprovalService service;
    private final ObjectMapper mapper;
    @GetMapping("/myDocument")
    public String getMyDocuments(Model m, @RequestParam int employeeNo) {
    	return "approval/myApprovalForm";
    }
    @GetMapping("/receivedDocument")
    public String getReceivedDocuments(Model m, @RequestParam int employeeNo) {
    	return "approval/myApprovalForm";
    }
    @GetMapping("/referenceDocument")
    public String getReferenceDocuments(Model m, @RequestParam int employeeNo) {
    	return "approval/myApprovalForm";
    }
    @GetMapping("/temporaryDocument")
    public String getTempDocuments(Model m, @RequestParam int employeeNo) {
    	return "approval/myApprovalForm";
    }
}
