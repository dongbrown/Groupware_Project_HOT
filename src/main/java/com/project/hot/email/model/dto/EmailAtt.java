package com.project.hot.email.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmailAtt {

	private int emailAttNo;
	private int emailNo;
	private String emailAttOriginalFilename;
	private String emailAttRenamedFilename;
}
