package com.project.hot.approval.model.dto;

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
public class CommutingTimeForm {

	private int commutingTimeFormNo;
	private String approvalNo;
	private Date commutingWorkDate;
	private String commutingType;
	private LocalDateTime commutingEditTime;
}
