package com.project.hot.hr.model.dto;

import lombok.Data;

@Data
public class RequestDepartment {
	private int deptCode; //부서 번호
	private String newTitle; //새 부서 이름
	private int highCode; //상위부서 코드번호
	private String auth; //권한
}
