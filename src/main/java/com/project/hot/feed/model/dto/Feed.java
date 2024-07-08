package com.project.hot.feed.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Feed {
	private int feedNo;
	private String feedContent;
	private Date feedEnrollDate;
	private int communityNo;
	private int employeeNo;
    private String originalFileName;
    private String renamedFileName;

	private String employeeName;


}
