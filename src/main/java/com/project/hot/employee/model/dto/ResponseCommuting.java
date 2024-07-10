package com.project.hot.employee.model.dto;

import java.time.LocalDateTime;

import lombok.Data;

// 출퇴근 페이지 응답용 클래스
@Data
public class ResponseCommuting {
	private LocalDateTime todayGoWorkTime; //오늘 출근시간
	private LocalDateTime todayLeaveWorkTime; //오늘 퇴근시간
	private int workDays; //근무 일수
	private int totalExWorkTime; //총 연장근무 시간
	private int totalWorkTime; //총 근무 시간
	private int tardy; // 지각 횟수
	private int	absence; //결근 횟수
	private int annual; //연차 횟수
}
