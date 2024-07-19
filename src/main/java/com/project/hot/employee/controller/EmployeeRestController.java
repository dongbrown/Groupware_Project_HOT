package com.project.hot.employee.controller;

import java.io.File;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.RequestEmployee;
import com.project.hot.employee.model.dto.SearchEmployeeData;
import com.project.hot.employee.model.service.EmployeeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/employee")
public class EmployeeRestController {

	private final EmployeeService service;
	private BCryptPasswordEncoder pwencoder=new BCryptPasswordEncoder();

	// 사원 정보를 담은 리스트 반환
	@GetMapping("/employeeList")
	public Map<String, Object> getEmployeeList(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(defaultValue = "12") int numPerpage,
			@ModelAttribute SearchEmployeeData sed) {
		Map<String, Object> param=new HashMap<>();
		param.put("sed", sed);
		param.put("cPage", cPage);
		param.put("numPerpage", numPerpage);
		return service.selectEmployeeList(param);
	}

	// 부서 전체 리스트 반환
	@GetMapping("/departmentList")
	public List<Department> selectDepartmentList(){
		return service.selectDepartmentList();
	}

	// 사원 한명 출퇴근 정보 반환
	@GetMapping("/commuting/{no}")
	public Map<String, Object> getCommutingList(
			@PathVariable(name = "no") int employeeNo,
			@RequestParam String month,
			@RequestParam(defaultValue = "1") int cPage){
		Map<String, Object> param=new HashMap<>();
		param.put("employeeNo", employeeNo);
		param.put("year", LocalDate.now().getYear());
		param.put("month", month);
		param.put("cPage", cPage);
		param.put("numPerpage", 10);
		return service.selectCommutingList(param);
	}

	// 사원 이미지 업데이트
	@PostMapping("/updateEmployeePhoto")
	public ResponseEntity<String> updateEmployeePhoto(
			@RequestParam("upFile") MultipartFile upFile
			, @RequestParam String employeePhoto //원래 있던 사원 이미지 파일 이름
			, @RequestParam int no
			, HttpServletRequest req
			, Principal p) {
		if(!upFile.isEmpty()) {
			String path=req.getServletContext().getRealPath("/upload/employee"); //저장 경로
			String oriname=upFile.getOriginalFilename(); //원본 이름
			String ext=oriname.substring(oriname.lastIndexOf(".")); //확장자
			String rename=LocalDateTime.now().toLocalDate().toString()+"_"+(int)(Math.random()*10000000)+ext; // 변경 이름

			File dir=new File(path);
			if(!dir.exists()) dir.mkdirs(); //폴더 없으면 생성

			//파일 저장
			try {
				upFile.transferTo(new File(path, rename));
				int result=service.updateEmployeePhoto(Map.of("rename",rename,"employeeNo",no));
				if(result>0) {
					File delFile=new File(path, employeePhoto);
					delFile.delete();

					//세션에 담긴 로그인 유저 정보 변경해주기
					UserDetails updatedEmp=service.selectEmployeeById(p.getName());
					Authentication a=new UsernamePasswordAuthenticationToken(updatedEmp, updatedEmp.getPassword(), updatedEmp.getAuthorities());
					SecurityContextHolder.getContext().setAuthentication(a);
					return ResponseEntity.ok().body("이미지 변경 성공!");
				}else {
					File delFile=new File(path, rename);
					delFile.delete();
					//데이터베이스 update 실패
					return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 업로드 실패!");
				}
			}catch(Exception e) {
				//파일 저장 실패
				e.printStackTrace();
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 업로드 실패!");
			}
		}else {
			//파일 안넘어옴
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("파일을 선택해주세요!");
		}
	}

	@PostMapping("/updateEmployee")
	public ResponseEntity<String> updateEmployee(@RequestBody RequestEmployee requestEmployee, Principal p) {

		//패스워드 암호화
		if(requestEmployee.getEmployeePassword()!=null&&!requestEmployee.getEmployeePassword().equals("")) {
			String encodedPwd=pwencoder.encode(requestEmployee.getEmployeePassword());
			requestEmployee.setEmployeePassword(encodedPwd);
		}

		//핸드폰번호에 '-' 붙이기
		if(requestEmployee.getEmployeePhone()!=null&&!requestEmployee.getEmployeePhone().equals("")) {
			String phone=requestEmployee.getEmployeePhone();
			if(phone.length()==11) {
				String formatPhone=String.format("%s-%s-%s", phone.substring(0, 3), phone.substring(3, 7), phone.substring(7));
				requestEmployee.setEmployeePhone(formatPhone);
			}else {
				String formatPhone=String.format("%s-%s-%s", phone.substring(0, 3), phone.substring(3, 6), phone.substring(6));
				requestEmployee.setEmployeePhone(formatPhone);
			}
		}
		int result=service.updateEmployee(requestEmployee);
		if(result>0) {
			//세션에 담긴 로그인 유저 정보 변경해주기
			UserDetails updatedEmp=service.selectEmployeeById(p.getName());
			Authentication a=new UsernamePasswordAuthenticationToken(updatedEmp, updatedEmp.getPassword(), updatedEmp.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(a);
			return ResponseEntity.ok().body("업데이트 성공!");
		}else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업데이트 실패!");
		}
	}

	@GetMapping("/attendanceStatus")
	public String checkAttStatus(Principal p) {
		//출퇴근 여부 체크
		int result=service.checkAtt(p.getName());
		if(result==0) {
			//출근 안함
			return "no";
		}else if(result==1) {
			//출근하고 퇴근은 아직 안함
			return "go";
		}else {
			//퇴근함
			return "leave";
		}
	}

	@PostMapping("/goWork")
	public String goWork(@RequestBody Map<String, Integer> req) {
		Map<String, Object> param=new HashMap<>();
		param.put("employeeNo", req.get("no"));
		int result=service.insertCommuting(param);
		if(result>0) {
			return "출근 무사히 성공!";
		}else {
			return "출근 실패";
		}
	}

	@PostMapping("/leaveWork")
	public String leaveWork(@RequestBody Map<String, Integer> req) {
		Map<String, Object> param=new HashMap<>();
		param.put("employeeNo", req.get("no"));
		int result=service.updateCommuting(param);
		if(result>0) {
			return "퇴근 무사히 성공!";
		}else {
			return "퇴근 실패";
		}
	}

	@GetMapping("/selectAllEmployeeId")
	public boolean selectAllEmployeeId(@RequestParam String id) {
		List<String> empIds=service.selectAllEmployeeId();
		if(empIds.stream().anyMatch(e->e.equals(id))) {
			return true;
		}else {
			return false;
		}
	}
}
