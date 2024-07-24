package com.project.hot.hr.controller;

import java.sql.Date;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.hot.employee.model.dto.RequestEmployee;
import com.project.hot.employee.model.dto.SearchEmployeeData;
import com.project.hot.employee.model.service.EmployeeService;
import com.project.hot.hr.model.dto.OrgData;
import com.project.hot.hr.model.dto.RequestCommuting;
import com.project.hot.hr.model.dto.RequestDepartment;
import com.project.hot.hr.model.service.HRService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/hr")
public class HRController {

	private final HRService HRService;
	private final EmployeeService empService;
	private BCryptPasswordEncoder pwencoder=new BCryptPasswordEncoder();

	@GetMapping("/departmentList")
	public Map<String, Object> selectDepartmentForHR(
			@RequestParam(defaultValue="1")int cPage
			, @RequestParam(defaultValue="") String departmentTitle){
		Map<String, Object> param=new HashMap<>();
		param.put("cPage", cPage);
		param.put("numPerpage", 10);
		param.put("departmentTitle", departmentTitle.equals("부서전체")?"":departmentTitle);
		Map<String, Object> result=HRService.selectDepartmentListForHR(param);
		return result;
	}

	@PostMapping("/insertDepartment")
	public String insertDepartment(@RequestBody RequestDepartment rd) {
		int result=HRService.insertDepartment(rd);
		if(result>0) {
			return "부서등록 성공!";
		}else {
			return "부서등록 실패!";
		}
	}

	@PostMapping("/updateDepartment")
	public String updateDepartment(@RequestBody RequestDepartment rd) {
		int result=HRService.updateDepartment(rd);
		if(result>0) {
			return "부서 수정 성공!";
		}else {
			return "부서 수정 실패!";
		}
	}

	@PostMapping("/deleteDepartment")
	public String deleteDepartment(@RequestBody RequestDepartment rd) {
		int result=HRService.deleteDepartment(rd);
		if(result>0) {
			return "부서 삭제 성공!";
		}else {
			return "부서 삭제 실패!";
		}
	}

	@GetMapping("/getEmployeeList")
	public Map<String,Object> getEmployeeList(
			@RequestParam(defaultValue = "1")int cPage
			, @ModelAttribute SearchEmployeeData sed){
		Map<String, Object> param=new HashMap<>();

		if(sed.getTitle().equals("부서전체")) sed.setTitle(null);

		param.put("cPage", cPage);
		param.put("numPerpage", 10);
		param.put("sed", sed);
		Map<String, Object> result=empService.selectEmployeeList(param);
		return result;
	}

	@PostMapping("/deleteEmployee")
	public String deleteEmployee(@RequestBody int no) {
		int result=HRService.deleteEmployee(no);
		if(result>0) {
			return "삭제 성공!";
		}else {
			return "삭제 실패!";
		}
	}

	@PostMapping("/updateEmployee")
	public String updateEmployee(@ModelAttribute RequestEmployee re) {
		int result=HRService.updateEmployee(re);
		if(result>0) {
			return "수정 성공!";
		}else {
			return "수정 실패!";
		}
	}

	@PostMapping("/insertEmployee")
	public String insertEmployee(@ModelAttribute RequestEmployee re) {
		//패스워드 암호화
		String encodedPwd=pwencoder.encode(re.getEmployeePassword());
		re.setEmployeePassword(encodedPwd);

		//생년월일 저장
		String ssn=re.getEmployeeSsn();
		if(ssn.charAt(7)=='1'||ssn.charAt(7)=='2') {
			//1900년대 출생자
			String birth="19" + ssn.substring(0, 2) + "-" + ssn.substring(2, 4) + "-" + ssn.substring(4, 6);
			re.setEmployeeBirthDay(Date.valueOf(birth));
		}else {
			//2000년대 출생자
			String birth="20" + ssn.substring(0, 2) + "-" + ssn.substring(2, 4) + "-" + ssn.substring(4, 6);
			re.setEmployeeBirthDay(Date.valueOf(birth));
		}

		//주민번호 암호화
		String encodedSsn=pwencoder.encode(re.getEmployeeSsn());
		re.setEmployeeSsn(encodedSsn);

		//핸드폰번호에 '-' 붙이기
		String phone=re.getEmployeePhone();
		if(phone.length()==11) {
			String formatPhone=String.format("%s-%s-%s", phone.substring(0, 3), phone.substring(3, 7), phone.substring(7));
			re.setEmployeePhone(formatPhone);
		}else {
			String formatPhone=String.format("%s-%s-%s", phone.substring(0, 3), phone.substring(3, 6), phone.substring(6));
			re.setEmployeePhone(formatPhone);
		}

		int result=HRService.insertEmployee(re);

		if(result>0) {
			return "생성 성공!";
		}else {
			return "생성 실패!";
		}
	}

	@GetMapping("/selectAllEmpCommuting")
	public Map<String, Object> searchEmpCommuting(@ModelAttribute RequestCommuting rc, @RequestParam int cPage){
		Map<String, Object> param=new HashMap<>();
		param.put("cPage", cPage);
		param.put("numPerpage", 15);
		param.put("rc", rc);
		Map<String, Object> result=HRService.selectAllEmpCommuting(param);
		return result;
	}

	@PostMapping("/deleteCommuting")
	public String deleteCommuting(@RequestBody int no) {
		int result=HRService.deleteCommuting(no);
		if(result>0) {
			return "삭제 성공!";
		}else {
			return "삭제 실패!";
		}
	}

	@PostMapping("/updateCommuting")
	public String updateCommuting(@RequestBody RequestCommuting rc) {
		//한국시간으로 변환
		if(rc.getGoTime()!=null) {
			ZonedDateTime utc=rc.getGoTime().atZone(ZoneId.of("UTC"));
			ZonedDateTime kst=utc.withZoneSameInstant(ZoneId.of("Asia/Seoul"));
			rc.setGoTime(kst.toLocalDateTime());
		}
		if(rc.getLeaveTime()!=null) {
			ZonedDateTime utc=rc.getLeaveTime().atZone(ZoneId.of("UTC"));
			ZonedDateTime kst=utc.withZoneSameInstant(ZoneId.of("Asia/Seoul"));
			rc.setLeaveTime(kst.toLocalDateTime());
		}
		int result=HRService.updateCommuting(rc);
		if(result>0) {
			return "수정 성공!";
		}else {
			return "수정 실패!";
		}
	}

	@GetMapping("/selectOrgData")
	public OrgData selectDeptAndEmployee(){
		return HRService.selectOrgData();
	}
}
