package com.project.hot.schedule.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ScheduleEmployee {

	private int scheduleEmployeeNo;
	private int employeeNo;
	private int scheduleNo;

}
