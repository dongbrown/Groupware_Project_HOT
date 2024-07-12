package com.project.hot.scheduler;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.project.hot.employee.model.service.EmployeeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Component
@EnableScheduling
@Slf4j
public class CommutingScheduler {

	private final EmployeeService service;

	// 23시에 출근을 안한 사원들 COMMUTING테이블에 INSERT 작업
	// 결근, 연차, 출장 상태가 찍힘
	@Scheduled(cron = "* * 23 ? * MON-FRI")
	public void commutingScheduling() {
		int result=service.insertCommutingNoAtt();
		if(result>0) {
			log.debug("{}", result);
		}else {
			log.debug("{}", result);
		}
	}
}
