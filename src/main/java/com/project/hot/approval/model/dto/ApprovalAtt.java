package com.project.hot.approval.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApprovalAtt {

	private int approvalAttNo;
	private String approvalNo;
	private String approvalAttOriginalFilename;
	private String approvalAttRenameFilename;
	private Date approvalAttDate;
}
