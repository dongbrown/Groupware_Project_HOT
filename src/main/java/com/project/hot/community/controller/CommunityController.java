package com.project.hot.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.dto.CommunityUser;
import com.project.hot.community.model.service.CommunityService;
import com.project.hot.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/community")
public class CommunityController {

    private final CommunityService service;

    @GetMapping("/")
    public String showCommunity(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();
        System.out.println(employeeNo);

        List<Community> communities = service.getCommunities(employeeNo);
        System.out.println(communities);
        model.addAttribute("communities", communities);
        model.addAttribute("loginEmployee", loginEmployee);
        return "community/community";
    }

    @PostMapping("/insert")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> insertCommunity(@RequestBody Community community) {
        Map<String, Object> response = new HashMap<>();
        try {
            if (community.getCommunityTitle() == null || community.getCommunityTitle().trim().isEmpty()) {
                throw new IllegalArgumentException("커뮤니티 이름은 필수입니다.");
            }

            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            Employee loginEmployee = (Employee) auth.getPrincipal();
            int employeeNo = loginEmployee.getEmployeeNo();

            // CommunityUser 객체 생성 및 설정
            CommunityUser communityUser = new CommunityUser();
            communityUser.setEmployeeNo(employeeNo);
            communityUser.setCommunityUserIsAccept("Y");
            communityUser.setCommunityUserBookmark("N");

            int result = service.insertCommunity(community, communityUser);
            if (result > 0) {
                response.put("success", true);
                response.put("message", "커뮤니티가 성공적으로 생성되었습니다.");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "커뮤니티 생성에 실패했습니다.");
                return ResponseEntity.badRequest().body(response);
            }
        } catch (IllegalArgumentException e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "커뮤니티 생성 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    @PostMapping("/toggleBookmark")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleBookmark(@RequestParam("communityNo") int communityNo) {
        System.out.println("Received communityNo: " + communityNo); // 디버깅용 로그
        Map<String, Object> response = new HashMap<>();
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            Employee loginEmployee = (Employee) auth.getPrincipal();
            int employeeNo = loginEmployee.getEmployeeNo();

            int result = service.toggleBookmark(communityNo, employeeNo);
            if (result > 0) {
                response.put("success", true);
                response.put("message", "북마크 상태가 변경되었습니다.");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "북마크 상태 변경에 실패했습니다.");
                return ResponseEntity.badRequest().body(response);
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "북마크 상태 변경 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }




}