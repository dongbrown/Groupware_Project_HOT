package com.project.hot.approval.model.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ExpenditureItem {

	private Integer expenditureItemNo;
	private Integer expenditureFormNo;
	private String expenditureName;
	private String expenditureSpec;
	private String expenditureUnit;
	private Integer expenditureQuantity;
	private Long expenditurePrice;
	private String expenditureRemark;

	@JsonIgnore
	public boolean isEmpty() {
		return expenditureName.isEmpty() && expenditureSpec.isEmpty() && expenditureUnit.isEmpty() && expenditureRemark.isEmpty()
				&& expenditureQuantity==null && expenditurePrice==null;
	}
}
