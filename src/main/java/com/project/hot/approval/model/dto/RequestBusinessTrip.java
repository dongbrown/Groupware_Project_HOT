package com.project.hot.approval.model.dto;

import java.sql.Date;

import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RequestBusinessTrip {

	private int businessTripFormNo;
	private String approvalNo;
	private Date businessTripStartDate;
	private Date businessTripEndDate;
	private String businessTripDestination;
	private String businessTripEmergency;
	private int[] partnerNo; //동행자
}
