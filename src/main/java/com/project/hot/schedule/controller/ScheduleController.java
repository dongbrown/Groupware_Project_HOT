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
	public String showMyCalendar() {
		return "schedule/schedule" ;
	}

	@GetMapping("/schedule")
    @ResponseBody
    public List<Map<String, Object>> getSchedules() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();
        List<Schedule> schedules = service.getSchedules(employeeNo);
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
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();
	    try {
	        System.out.println("Received schedule: " + schedule);
	        service.addSchedule(schedule, employeeNo);
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
    public ResponseEntity<String> deleteSchedule(@RequestParam("id") int id) {
        try {
        	// Schedule, ScheduleEmployee 테이블 데이터 삭제
            service.deleteSchedule(id);
                return ResponseEntity.ok("일정이 성공적으로 삭제되었습니다");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("일정 삭제 중 오류 발생: " + e.getMessage());
        }
    }


    @GetMapping("/selectEmpByDept")
    @ResponseBody
    public ResponseEntity<List<Employee>> selectEmpByDept(@RequestParam String deptCode) {
        try {
            List<Employee> employees = service.getEmployeesByDepartment(deptCode);
            return ResponseEntity.ok(employees);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }


    //내 캘린더 일정 리스트
    @GetMapping("/selectMyCalendar")
    @ResponseBody
    public ResponseEntity<List<Schedule>> getMySchedule(){
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();
        try {
        	List<Schedule> schedules = service.getMySchedule(employeeNo);
        	return ResponseEntity.ok(schedules);
        }catch(Exception e) {
        	e.printStackTrace();
        	return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    //공유 캘린더 일정 리스트
    @GetMapping("/selectShareCalendar")
    @ResponseBody
    public ResponseEntity<List<Schedule>> getShareSchedule(){
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();
        try {
        	List<Schedule> schedules = service.getShareSchedule(employeeNo);
        	return ResponseEntity.ok(schedules);
        }catch(Exception e) {
        	e.printStackTrace();
        	return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }







}