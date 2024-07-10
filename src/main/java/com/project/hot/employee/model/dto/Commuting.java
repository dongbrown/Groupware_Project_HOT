package com.project.hot.employee.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Commuting {

	private int commutingNo;
	private Employee employeeNo;
	private LocalDateTime commutingDate;
	private LocalDateTime commutingGoWorkTime;
	private LocalDateTime commutingLeaveWorkTime;
	private String commutingStatus;
}
