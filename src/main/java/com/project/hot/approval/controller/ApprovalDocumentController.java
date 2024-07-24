package com.project.hot.approval.controller;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.service.ApprovalService;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/approval")
@Controller
public class ApprovalDocumentController {

    private final ApprovalService service;

//    @GetMapping("/approvalAll")
//    public String approvalAll(Model model) {
//        List<Approval> approvalAll = service.getAllDocuments();
//        model.addAttribute("approvalAll", approvalAll);
//        return "approval/documentAll";
//    }


    @GetMapping("/employees")
    @ResponseBody
    public List<Employee> getEmployeesByDepartment(@RequestParam String departmentCode) {
        return service.getEmployeesByDepartment(departmentCode);
    }

    @GetMapping("/newApproval.do")
    public String newApproval(Model model) {
        List<Department> departments = service.selectDepartmentList();
        model.addAttribute("departments", departments);
        return "approval/newApprovalForm";
    }






}
