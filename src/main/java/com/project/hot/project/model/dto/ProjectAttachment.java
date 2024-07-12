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
public class ProjectAttachment {
	private int attNo;
	private int projectWorkNo;
	private int employeeNo;
	private String attOriginalname;
	private String attRename;
	private Date attUploadDate;
}
