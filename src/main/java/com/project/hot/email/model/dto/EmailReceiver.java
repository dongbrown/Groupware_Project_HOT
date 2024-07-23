package com.project.hot.email.model.dto;

import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmailReceiver {

	private int emailReceiverNo;
	private int emailNo;

	private Employee employee;

	private int emailReceiverCategory;
	private String emailReceiverIsRead;
	private String emailReceiverIsDelete;
	private String emailReceiverIsImportant;
	private int emailCategoryNo;

	public String getEmail() {
        return employee != null ? employee.getEmployeeId() + "@hot.com" : null;
	}
}
