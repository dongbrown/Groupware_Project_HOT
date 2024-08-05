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
	private String employeeName;
	private String departmentTitle;
	private int projectEmployeeNo;
	private String projectTitle;
	private String projectRequestStatus;
	private int projectRequestEmployee;
	private Date projectRequestDate;
	private String projectStatus;
	private String projectRefuseContent;
	private String reqEmpName;
	private String reqEmpDeptTitle;
	private String memberPhotos;
	private String memberEmployeeNos;
	private Project project;
	private Employee employee;
}
