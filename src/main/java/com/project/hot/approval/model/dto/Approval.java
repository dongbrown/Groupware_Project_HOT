package com.project.hot.approval.model.dto;

import java.sql.Date;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.dto.Position;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Approval {

	 private int  approvalNo; //결재고유번호에 따라 결재양식 가져오고
	 private String approvalTitle;//결재제목
	 private String approvalContent;//결재내용
	 private Date approvalDraftDate;//기안일
	 private Date approverDate; //결재일
	 private String status;//상태(진행,완료)
	 private Employee employeeNo;
	 private Department departmentCode;
	 private Employee employeeName;
	 private Position positionCode;

}
