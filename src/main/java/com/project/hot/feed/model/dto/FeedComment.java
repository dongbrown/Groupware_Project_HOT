package com.project.hot.feed.model.dto;

import java.time.LocalDateTime;

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
	private LocalDateTime feedCommentEnrolldate;

	private int feedNo;
	private int employeeNo;
	private int feedCommentParentNo;
	private String employeeName;
}
