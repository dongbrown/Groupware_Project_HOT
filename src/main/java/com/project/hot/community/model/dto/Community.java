package com.project.hot.community.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Community {

	private int communityNo;
	private String communityTitle;
 	private String communityIntroduce;
 	private String communityIsOpen;
}
