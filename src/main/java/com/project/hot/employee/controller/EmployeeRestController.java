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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.SearchEmployeeData;
import com.project.hot.employee.model.service.EmployeeService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class EmployeeRestController {

	private final EmployeeService service;

	// 사원 정보를 담은 리스트 반환
	@GetMapping("/employeeList")
	public Map<String, Object> getEmployeeList(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(defaultValue = "12") int numPerpage,
			@ModelAttribute SearchEmployeeData sd) {
		Map<String, Object> param=new HashMap<>();
		if(sd.getTitle()!=null) {
			param.put("title", sd.getTitle().equals("부서선택")?"":sd.getTitle());
		}
		param.put("name", sd.getName()==null?"":sd.getName());
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
			String rename=LocalDateTime.now().toLocalDate().toString()+"_"+UUID.randomUUID().toString()+ext; // 변경 이름

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

}
