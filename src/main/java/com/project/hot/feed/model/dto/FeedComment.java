package com.project.hot.feed.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class FeedComment {

	private int feedCommentNo;
	private String feedCommentContent;
	private Date feedCommentEnrolldate;
	private int feedNo;
	private int employeeNo;
	private int commentParentNo;

}
