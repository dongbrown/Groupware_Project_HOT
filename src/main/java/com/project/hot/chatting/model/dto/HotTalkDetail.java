package com.project.hot.chatting.model.dto;

import java.util.List;

import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class HotTalkDetail {
	HotTalk hotTalk;
	List<Employee> employees;
	List<HotTalkContent> hotTalkContents;
}
