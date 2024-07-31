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
public class Project {

//	 private int projectNo;
//	 private int employeeNo;
//	 private String projectTitle;
//	 private String projectContent;
//	 private Date projectStartDate;
//	 private Date projectEndDate;
//	 private int projectRank;
//	 private int projectProgress;
//	 private int projectBudget;
//	 private String projectStatus;

	 	private int projectNo;
	 	private String projectTitle;
	 	private String projectEmployeeName;
	    private int employeeNo;
	    private Employee employeeCode;
	    private int projectRank;
	    private String projectContent;
	    private long projectBudget;
	    private Date projectStartDate;
	    private Date projectEndDate;
	    private int projectProgress;
	    private String projectStatus;
	    private String employeeName;
	    private String departmentTitle;
	    private String memberPhotos;
	    private String memberEmployeeNos;
	    private String projectRequestStatus;
	    private String projectRequestEmployee;
	    private String projectRefuseContent;
	    private List<ProjectEmployee> employee;
	    private RequestProject requestProject;

}
