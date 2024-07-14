package com.project.hot.project.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Work {

	private int projectWorkNo;
	private int projectNo;
	private int employeeNo;
	private String projectWorkTitle;
	private String projectWorkContent;
	private int projectWorkRank;
	private Date projectWorkStartDate;
	private Date projectWorkEndDate;
	private int projectWorkProgress;
	private int projectWorkStatus;
}
