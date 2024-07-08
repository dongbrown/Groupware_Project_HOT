package com.project.hot.approval.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.service.ApprovalDocumentService;

import java.util.List;

@Controller
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
    public String newApproval() {
        return "approval/newApprovalForm";
    }

    @GetMapping("/getEmployees")
    public String getEmployees(@RequestParam("department") String department, Model model) {
        List<String> employees = approvalDocumentService.getEmployeesByDepartment(department);
        model.addAttribute("employees", employees);
        return "approval/employeeList";
    }
}
