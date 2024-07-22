package com.project.hot.hr.model.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrgData {
	private String id;
	private OrgContent data;
	private OrgOption options;
	private List<OrgData> children;
}
