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
public class ExpenditureForm {

	private int expenditureFormNo;
	private String approvalNo;
	private Date expenditureDate;
	private int expenditureAmount;
	private String expenditureName;
	private String expenditureSpec;
	private String expenditureUnit;
	private int expenditureQuantity;
	private int expenditurePrice;
	private String expenditureRemark;
}
