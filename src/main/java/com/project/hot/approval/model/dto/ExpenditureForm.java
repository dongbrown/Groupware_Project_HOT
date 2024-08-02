package com.project.hot.approval.model.dto;

import java.sql.Date;
import java.util.List;

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
}
