package com.project.hot.approval.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ResponseApprovalsCount {

	private int waitCount; //대기
	private int processCount; //진행
	private int pendingCount; //예정
	private int completeCount; //완료
}
