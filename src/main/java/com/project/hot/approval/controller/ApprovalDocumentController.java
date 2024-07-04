package com.project.hot.approval.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.service.ApprovalDocumentService;

@Controller
//@RequestMapping("/approval")
public class ApprovalDocumentController {

	  @Autowired
	    private ApprovalDocumentService approvalDocumentService;

	    @GetMapping("/approvalAll.do")
	    public String approvalAll(Model model) {
	        List<Approval> approvalAll = approvalDocumentService.getAllDocuments();
	        model.addAttribute("approvalAll", approvalAll);
	        return "approval/documentAll";
	    }


	    @GetMapping("/newApproval.do")
	    public String newApproval(@RequestParam Map<String, String> params, Model model) {
	        model.addAllAttributes(params);
	        return "approval/newApproval"; // 뷰 이름을 반환
	    }
}
