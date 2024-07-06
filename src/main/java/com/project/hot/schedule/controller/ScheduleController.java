package com.project.hot.schedule.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.schedule.model.dto.Schedule;
import com.project.hot.schedule.model.service.ScheduleService;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	private ScheduleService service;

	@GetMapping("/")
	public String showCalendar() {
		return "schedule/schedule" ;
	}


	@GetMapping("/schedule")
    @ResponseBody
    public List<Map<String, Object>> getSchedules() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();
        List<Schedule> schedules = service.getSchedules();
        List<Map<String, Object>> events = new ArrayList<>();

        for (Schedule schedule : schedules) {
            Map<String, Object> event = new HashMap<>();
            event.put("id", schedule.getId());
            event.put("title", schedule.getTitle());
            event.put("location", schedule.getLocation());
            event.put("description", schedule.getDescription());
            event.put("type", schedule.getDescription());
            event.put("start", schedule.getStart());
            event.put("end", schedule.getEnd());
            event.put("allDay", schedule.isAllDay());
            event.put("color", schedule.getColor());

            events.add(event);
        }

        return events;
    }


	@PostMapping("/addSchedule")
	@ResponseBody
	public ResponseEntity<String> addSchedule(@RequestBody Schedule schedule) {
	    try {
	        System.out.println("Received schedule: " + schedule);
	        service.addSchedule(schedule);
	        return ResponseEntity.ok("일정이 성공적으로 추가되었습니다");
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body("일정 추가 중 오류 발생: " + e.getMessage());
	    }
	}

	// 일정 수정 메서드
    @PutMapping("/updateSchedule")
    @ResponseBody
    public ResponseEntity<String> updateSchedule(@RequestBody Schedule schedule) {
        try {
            System.out.println("수정할 일정 정보: " + schedule);
            service.updateSchedule(schedule);
            return ResponseEntity.ok("일정이 성공적으로 수정되었습니다");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("일정 수정 중 오류 발생: " + e.getMessage());
        }
    }

    // 일정 삭제 메서드
    @DeleteMapping("/deleteSchedule")
    @ResponseBody
    public ResponseEntity<String> deleteSchedule(@RequestParam("id") String id) {
        try {
            int deletedCount = service.deleteSchedule(id);
            if (deletedCount > 0) {
                return ResponseEntity.ok("일정이 성공적으로 삭제되었습니다");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("삭제할 일정을 찾을 수 없습니다");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("일정 삭제 중 오류 발생: " + e.getMessage());
        }
    }
}