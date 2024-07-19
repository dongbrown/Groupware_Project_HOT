package com.project.hot.hr.model.dto;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ResponseCommuting {

	private int commutingNo;
	private int employeeNo;
	private LocalDateTime commutingGoWorkTime;
	private LocalDateTime commutingLeaveWorkTime;
	private String commutingStatus;
	private Date CommutingDate;
	private String departmentTitle;
	private String positionTitle;
	private String employeeName;
	private int totalExWorkTime; //총 연장근무 시간
	private int totalWorkTime; //총 근무 시간
}
