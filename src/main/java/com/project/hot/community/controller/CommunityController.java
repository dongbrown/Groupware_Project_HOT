package com.project.hot.community.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.dto.CommunityUser;
import com.project.hot.community.model.service.CommunityService;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.feed.model.dto.Feed;
import com.project.hot.feed.model.service.FeedService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/community")
public class CommunityController {

    private final CommunityService communityService;
    private final FeedService feedService;

    @GetMapping("/")
    public String showCommunity(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();

        List<Community> communities = communityService.getCommunities(employeeNo);
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
            log.info("Inserting new community: {}", community);

            if (community.getCommunityTitle() == null || community.getCommunityTitle().trim().isEmpty()) {
                throw new IllegalArgumentException("커뮤니티 이름은 필수입니다.");
            }

            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            Employee loginEmployee = (Employee) auth.getPrincipal();
            int employeeNo = loginEmployee.getEmployeeNo();

            CommunityUser communityUser = new CommunityUser();
            communityUser.setEmployeeNo(employeeNo);
            communityUser.setCommunityUserIsAccept("Y");
            communityUser.setCommunityUserBookmark("N");

            communityService.insertCommunity(community, communityUser);

            response.put("success", true);
            response.put("message", "커뮤니티가 성공적으로 생성되었습니다.");
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            log.error("Error occurred while creating community", e);
            response.put("success", false);
            response.put("message", "커뮤니티 생성 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
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

            int result = communityService.toggleBookmark(communityNo, employeeNo);
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

    // 피드로 이동
    @GetMapping("/feed")
    public String showCommunityFeed(@RequestParam("communityNo") int communityNo, Model model) {
        try {
            log.info("Fetching community feed for communityNo: {}", communityNo);

            Community community = communityService.getCommunityByNo(communityNo);
            if (community == null) {
                log.warn("Community not found for communityNo: {}", communityNo);
                return "redirect:/error";
            }
            log.info("Community found: {}", community);

            List<Feed> feeds = feedService.getFeeds(communityNo);
            log.info("Fetched {} feeds for communityNo: {}", feeds.size(), communityNo);

            model.addAttribute("community", community);
            model.addAttribute("feeds", feeds);
            model.addAttribute("communityNo", communityNo);

            return "community/feed";
        } catch (Exception e) {
            log.error("communityNo " + communityNo, e);
            model.addAttribute("error", "커뮤니티 피드를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
            return "error/500";
        }
    }

    // 공개 커뮤니티 리스트로 이동
    @GetMapping("/communityList")
    public String openCommunityList(Model model) {
    	List<Community> communities = communityService.getCommunityList();
    	System.out.println(communities);
    	model.addAttribute("communities", communities);
    	return "community/communityList";
    }

    @PostMapping("/join")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> joinCommunity(@RequestParam("communityNo") int communityNo) {
        Map<String, Object> response = new HashMap<>();
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            Employee loginEmployee = (Employee) auth.getPrincipal();
            int employeeNo = loginEmployee.getEmployeeNo();

            CommunityUser communityUser = new CommunityUser();
            communityUser.setEmployeeNo(employeeNo);
            communityUser.setCommunityNo(communityNo);
            communityUser.setCommunityUserIsAccept("Y");
            communityUser.setCommunityUserBookmark("N");

            boolean result = communityService.joinCommunity(communityUser);

            if (result) {
                response.put("success", true);
                response.put("message", "커뮤니티에 성공적으로 가입되었습니다.");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "커뮤니티 가입에 실패했습니다.");
                return ResponseEntity.badRequest().body(response);
            }
        } catch (Exception e) {
            log.error("Error occurred while joining community", e);
            response.put("success", false);
            response.put("message", "커뮤니티 가입 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }




}