package com.project.hot.employee.model.dto;

import java.sql.Date;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
	public class Employee implements UserDetails{

		private int employeeNo;
		private Department departmentCode;
		private Position positionCode;
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
		private Date employeeResignationDay;
		private int employeeTotalVacation;

		@JsonIgnore
		@Override
		public Collection<? extends GrantedAuthority> getAuthorities(){
			Set<GrantedAuthority> authorities = new HashSet<>();
			  // 부서 코드에 따른 권한 부여
	        if (departmentCode != null) {
	            authorities.add(new SimpleGrantedAuthority(departmentCode.getDepartmentAuthority()));
	        }

	        // 직급 코드에 따른 권한 부여
	        if (positionCode != null) {
	            authorities.add(new SimpleGrantedAuthority(positionCode.getPositionAuthority()));
	        }
	        if(authorities.isEmpty()) authorities.add(new SimpleGrantedAuthority("gen"));

	        return authorities;
		}

		@Override
		public String getUsername() {
			return this.employeeId;
		}
		@JsonIgnore
		@Override
		public boolean isAccountNonExpired() {
			return true;
		}
		@JsonIgnore
		@Override
		public boolean isAccountNonLocked() {
			return true;
		}
		@JsonIgnore
		@Override
		public boolean isCredentialsNonExpired() {
			return true;
		}
		@JsonIgnore
		@Override
		public boolean isEnabled() {
			return employeeResignationDay == null;
		}

		@Override
		public String getPassword() {
			return this.employeePassword;
		}
	}
