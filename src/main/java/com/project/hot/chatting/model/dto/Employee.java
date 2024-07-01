package com.project.hot.chatting.model.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class Employee {
    private int employeeNo;
    private String departmentCode;
    private String positionCode;
    private String employeeName;
    private String employeePhone;
    private String employeePassword;
    private String employeeId;
    private String employeeAddress;
    private Date employeeBirthDay;
    private String employeeSsn;
    private Date employeeHireDate;
    private int employeeSalary;
    private String employeePhoto;
    private Date employeeResignDate;
    private int employeeTotalVacation;
}
