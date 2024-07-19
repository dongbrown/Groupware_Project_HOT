package com.project.hot.project.model.dto;

import java.sql.Date;
import java.util.List;

import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RequestProject {
	private int projectRequestNo;
	private int projectNo;
	private int employeeNo;
	private int projectRequestEmployee;
	private Date projectRequestDate;
	private String projectStatus;
	private String projectRefuseContent;
	private Project project;
}
