package com.project.hot.approval.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.VacationForm;
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


	    @PostMapping("/vacation")
	    @ResponseBody
	    public Map<String, Object> inputVacationForm(@RequestBody Map<String, Object> requestData) {
	        Map<String, Object> response = new HashMap<>();
	        try {
	            VacationForm vacationForm = new VacationForm();
	            vacationForm.setEmployeeId((Integer) requestData.get("employeeId"));
	            // 여기에 다른 필요한 필드 설정

	            Map<String, Object> result = approvalDocumentService.inputVacationForm(vacationForm);
	            response.put("success", true);
	            response.put("employeeId", result.get("employeeId"));
	        } catch (Exception e) {
	            e.printStackTrace(); // 콘솔에 에러 출력
	            response.put("success", false);
	            response.put("error", e.getMessage());
	        }
	        return response;
	    }

}
