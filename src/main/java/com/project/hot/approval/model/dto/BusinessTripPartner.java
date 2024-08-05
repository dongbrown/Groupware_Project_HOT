package com.project.hot.approval.model.dto;

import java.util.List;

import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BusinessTripPartner {

	private int businessTripFormNo;
	private List<Employee> employee;
}
