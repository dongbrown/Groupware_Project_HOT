package com.project.hot.approval.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.approval.model.dto.CommutingTimeForm;
import com.project.hot.approval.model.dto.ExpenditureForm;
import com.project.hot.approval.model.dto.ExpenditureItem;
import com.project.hot.approval.model.dto.OvertimeForm;
import com.project.hot.approval.model.dto.RequestApproval;
import com.project.hot.approval.model.dto.RequestBusinessTrip;
import com.project.hot.approval.model.dto.RequestExpenditure;
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
		Map<String, Object> param=new HashMap<>();
		param.put("ra", ra);
		param.put("upFile", upFile);
		param.put("path", req.getServletContext().getRealPath("/upload/approval"));
		String newApprovalNo=service.insertApproval(param);
		if(newApprovalNo != null) {
			vf.setApprovalNo(newApprovalNo);
			int result=service.insertVacation(vf);
			if(result>0) {
				return "완료!";
			}else {
				return "실패!";
			}
		}else {
			return "실패!";
		}
	}

	@PostMapping("/insertCommuting")
	public String insertCommuting(
			@RequestParam("upFile") MultipartFile[] upFile,
			@ModelAttribute RequestApproval ra,
			@ModelAttribute CommutingTimeForm ctf,
			HttpServletRequest req
			) {
		Map<String, Object> param=new HashMap<>();
		param.put("ra", ra);
		param.put("upFile", upFile);
		param.put("path", req.getServletContext().getRealPath("/upload/approval"));
		String newApprovalNo=service.insertApproval(param);
		if(newApprovalNo != null) {
			ctf.setApprovalNo(newApprovalNo);
			int result=service.insertCommuting(ctf);
			if(result>0) {
				return "완료!";
			}else {
				return "실패!";
			}
		}else {
			return "실패!";
		}
	}

	@PostMapping("/insertOvertime")
	public String insertOvertime(
			@RequestParam("upFile") MultipartFile[] upFile,
			@ModelAttribute RequestApproval ra,
			@ModelAttribute OvertimeForm of,
			HttpServletRequest req) {
		Map<String, Object> param=new HashMap<>();
		param.put("ra", ra);
		param.put("upFile", upFile);
		param.put("path", req.getServletContext().getRealPath("/upload/approval"));
		String newApprovalNo=service.insertApproval(param);
		if(newApprovalNo != null) {
			of.setApprovalNo(newApprovalNo);
			int result=service.insertOvertime(of);
			if(result>0) {
				return "완료!";
			}else {
				return "실패!";
			}
		}else {
			return "실패!";
		}
	}

	@PostMapping("/insertBusinessTrip")
	public String insertBusinessTrip(
			@RequestParam("upFile") MultipartFile[] upFile,
			@ModelAttribute RequestApproval ra,
			@ModelAttribute RequestBusinessTrip rbt,
			HttpServletRequest req) {
		Map<String, Object> param=new HashMap<>();
		param.put("ra", ra);
		param.put("upFile", upFile);
		param.put("path", req.getServletContext().getRealPath("/upload/approval"));
		String newApprovalNo=service.insertApproval(param);
		if(newApprovalNo != null) {
			rbt.setApprovalNo(newApprovalNo);
			int result=service.insertBusinessTrip(rbt);
			if(result>0) {
				return "완료!";
			}else {
				return "실패!";
			}
		}else {
			return "실패!";
		}
	}

	@PostMapping("/insertExpenditure")
	public String insertExpenditure(
			@RequestParam("upFile") MultipartFile[] upFile,
			@ModelAttribute RequestApproval ra,
			@ModelAttribute RequestExpenditure re,
			HttpServletRequest req) {
		Map<String, Object> param=new HashMap<>();
		param.put("ra", ra);
		param.put("upFile", upFile);
		param.put("path", req.getServletContext().getRealPath("/upload/approval"));
		String newApprovalNo=service.insertApproval(param);
		if(newApprovalNo != null) {
			re.setApprovalNo(newApprovalNo);
			int result=service.insertExpenditure(re);
			if(result>0) {
				return "완료!";
			}else {
				return "실패!";
			}
		}else {
			return "실패!";
		}
	}

}
