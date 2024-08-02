package com.project.hot.hr.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SearchVacationData {

	private Integer code;
	private String name;
	private String type;
	private Date startDate;
	private Date endDate;
}
