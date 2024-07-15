package com.project.hot.hr.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ResponseDepartment {
	private int departmentCode;
	private String departmentHighTitle; //상위 부서 이름
	private String departmentTitle; //부서 이름
	private String departmentHeadName; //부서 책임자 이름
	private int totalDepartmentCount; //부서 사원수
}
