package com.project.hot.approval.model.dto;

import java.sql.Date;
import java.util.List;

import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Approval {

	 private String approvalNo; //결재고유번호  '양식종류-년도-월일-001'  ex) 1-2024-0711-011
	 private Employee employeeNo;//기안자
	 private Date approvalDate;//기안일
	 private Date approvalPeriod; //보존연한
	 private String approvalTitle;//결재제목
	 private String approvalContent;//결재내용
	 private int approvalStatus;//상태
	 private String approvalSecurity;//보안등급
	 private List<Approver> approvers; // 결재자
	 private VacationForm vacationForm;
}
