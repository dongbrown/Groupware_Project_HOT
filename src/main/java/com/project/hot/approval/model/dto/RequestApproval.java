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
public class RequestApproval {
	private String approvalNo;
	private int approvalEmpNo;
	private Date approvalDate;
	private int approvalStatus;
	private String title;
	private String content;
	private Date period;
	private String security;
	private int[] receiverNo;
	private int[] refererNo;
	private int middleApproverNo;
	private int finalApproverNo;
	private int type;
}
