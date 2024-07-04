package com.project.hot.project.model.dto;

import java.sql.Date;

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

	 	private String projectTitle;
	    private int employeeNo;
	    private int projectRank;
	    private String projectContent;
	    private int projectBudget;
	    private String projectEndDate;

}
