package com.project.hot.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.service.CommunityService;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityService service;

    @GetMapping("/community")
    public String showCommunity(Model model) {
        List<Community> communities = service.getCommunities();
        model.addAttribute("communities", communities);
        return "community/community";
    }

    @PostMapping("/create")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createCommunity(@RequestBody Community community) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 필요한 유효성 검사 추가
            if (community.getCommunityTitle() == null || community.getCommunityTitle().trim().isEmpty()) {
                throw new IllegalArgumentException("커뮤니티 이름은 필수입니다.");
            }

            int result = service.createCommunity(community);
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
}
