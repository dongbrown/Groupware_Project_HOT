package com.project.hot.approval.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ExpenditureItem {

	private int expenditureItemNo;
	private int expenditureFormNo;
	private String expenditureName;
	private String expenditureSpec;
	private String expenditureUnit;
	private int expenditureQuantity;
	private long expenditurePrice;
	private String expenditureRemark;

}
