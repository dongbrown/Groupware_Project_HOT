package com.project.hot.approval.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.hot.approval.model.dto.ResponseSpecificApproval;
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
    private final ObjectMapper mapper;
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

    @GetMapping("/specApproval.do")
    public String specApproval(Model model, String targetNo) {
    	int appType = Integer.parseInt(targetNo.substring(0,1));
    	String type="";
    	switch(appType) {
    		case 1: type="출퇴근 정정 신청서";  break;
    		case 2: type="휴가 신청서"; break;
    		case 3: type="초과근무 신청서";  break;
    		case 4: type="경비지출 신청서";  break;
    		case 5: type="출장 신청서";  break;
    	}
    	model.addAttribute("type", type);
    	model.addAttribute("appType", appType);
    	List<ResponseSpecificApproval> approvalInfo = new ArrayList<>();
    	Map<String, String> approverName = new HashMap<>();
    	Set<String> referenceName = new HashSet<>();
    	try {
    	    approvalInfo = service.getSpecificApproval(targetNo);
    	    approvalInfo.stream().forEach(rsa -> {
    	    	rsa.getApproverEmployee().stream().forEach(ae -> {
    	    		String approver = ae.getEmployeeNo().getEmployeeName();
    	    		String approverLevel = ae.getApproverLevel();
    	    		approverName.put(approverLevel, approver);
    	    	});
    	    	rsa.getReferenceEmployee().stream().forEach(re->{
    	    		String reference = re.getEmployeeNo().getEmployeeName();
    	    		referenceName.add(reference);
    	    	});
    	    });

    	    String approvalInfoJson = mapper.writeValueAsString(approvalInfo);
    	    String approverNames = mapper.writeValueAsString(approverName);
    	    String referenceNames = mapper.writeValueAsString(referenceName);
    	    System.out.println("approvalInfoJson : "+approvalInfoJson);
    	    model.addAttribute("approvalInfo", approvalInfoJson);
    	    model.addAttribute("approvers", approverNames);
    	    model.addAttribute("references", referenceNames);
    	} catch(Exception e){
    	    e.printStackTrace();
    	}
    	return "approval/specificApprovalForm";
    }

}
