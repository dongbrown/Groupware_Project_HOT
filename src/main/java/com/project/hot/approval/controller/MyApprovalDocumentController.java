package com.project.hot.approval.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.hot.approval.model.dto.ResponseSpecificApproval;
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
    	m.addAttribute("myapprovalType", 1);
    	List<ResponseSpecificApproval> approvalInfo = service.getMyApproval(employeeNo);
    	m.addAttribute("mydoc", approvalInfo);
    	return "approval/myApprovalForm";
    }
    @GetMapping("/receivedDocument")
    public String getReceivedDocuments(Model m, @RequestParam int employeeNo) {
    	m.addAttribute("myapprovalType", 2);
    	List<ResponseSpecificApproval> approvalInfo = service.getReceivedApproval(employeeNo);
    	m.addAttribute("recdoc", approvalInfo);
    	return "approval/myApprovalForm";
    }
    @GetMapping("/referenceDocument")
    public String getReferenceDocuments(Model m, @RequestParam int employeeNo) {
    	m.addAttribute("myapprovalType", 3);
    	List<ResponseSpecificApproval> approvalInfo = service.getReferenceDocuments(employeeNo);
    	m.addAttribute("refdoc", approvalInfo);
    	return "approval/myApprovalForm";
    }
    @GetMapping("/viewDocument")
    public String getDocumentsByPosition(Model m, @RequestParam int employeeNo) {
    	m.addAttribute("myapprovalType", 4);
    	List<ResponseSpecificApproval> approvalInfo = service.getDocumentsByPosition(employeeNo);
    	m.addAttribute("posdoc", approvalInfo);
    	return "approval/myApprovalForm";
    }
    @GetMapping("/temporaryDocument")
    public String getTempDocuments(Model m, @RequestParam int employeeNo) {
    	m.addAttribute("myapprovalType", 5);
    	List<ResponseSpecificApproval> approvalInfo = service.getTempDocuments(employeeNo);
    	m.addAttribute("tempdoc", approvalInfo);
    	return "approval/myApprovalForm";
    }
}
