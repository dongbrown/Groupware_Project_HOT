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
public class RequestExpenditure {

	private int expenditureFormNo;
	private String approvalNo;
	private Date expenditureDate;
	private Integer expenditureAmount;
	private List<ExpenditureItem> items;

}