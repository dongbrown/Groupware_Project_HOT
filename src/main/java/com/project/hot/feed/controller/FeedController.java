package com.project.hot.feed.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.community.model.service.CommunityService;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.feed.model.dto.Feed;
import com.project.hot.feed.model.service.FeedService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/community/feed")
public class FeedController {

    private final FeedService service;
    private final CommunityService communityService;

    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getFeeds(@RequestParam Integer communityNo) {
        Map<String, Object> response = new HashMap<>();

        try {
            if (communityNo == null) {
                throw new IllegalArgumentException("커뮤니티 번호가 필요합니다.");
            }

            List<Feed> feeds = service.getFeeds(communityNo);
            log.info("Fetched {} feeds for community {}", feeds.size(), communityNo);

            response.put("success", true);
            response.put("feeds", feeds);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("피드 목록 조회 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "피드 목록을 불러오는 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    @PostMapping("/insert")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> insertFeed(
            @RequestParam("feedContent") String feedContent,
            @RequestParam("communityNo") int communityNo,
            @RequestParam(value = "file", required = false) MultipartFile file) {
        Map<String, Object> response = new HashMap<>();

        try {
            if (feedContent == null || feedContent.trim().isEmpty()) {
                throw new IllegalArgumentException("피드 내용은 필수입니다.");
            }

            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            Employee loginEmployee = (Employee) auth.getPrincipal();

            Feed feed = new Feed();
            feed.setFeedContent(feedContent);
            feed.setCommunityNo(communityNo);
            feed.setEmployeeNo(loginEmployee.getEmployeeNo());

            int result = service.insertFeed(feed, file);
            if (result > 0) {
                response.put("success", true);
                response.put("message", "피드가 성공적으로 작성되었습니다.");
                log.info("Feed inserted successfully: {}", feed.getFeedNo());
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "피드 작성에 실패했습니다.");
                log.warn("Failed to insert feed");
                return ResponseEntity.badRequest().body(response);
            }

        } catch (Exception e) {
            log.error("피드 생성 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "피드 생성 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    @PutMapping("/update")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateFeed(@RequestBody Feed feed) {
        Map<String, Object> response = new HashMap<>();

        try {
            if (feed.getFeedContent() == null || feed.getFeedContent().trim().isEmpty()) {
                throw new IllegalArgumentException("수정할 피드 내용은 필수입니다.");
            }

            int result = service.updateFeed(feed);
            if (result > 0) {
                response.put("success", true);
                response.put("message", "피드가 성공적으로 수정되었습니다.");
                log.info("Feed updated successfully: {}", feed.getFeedNo());
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "피드 수정에 실패했습니다.");
                log.warn("Failed to update feed: {}", feed.getFeedNo());
                return ResponseEntity.badRequest().body(response);
            }

        } catch (Exception e) {
            log.error("피드 수정 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "피드 수정 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    @DeleteMapping("/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteFeed(@RequestBody Feed feed) {
        Map<String, Object> response = new HashMap<>();

        try {
            int result = service.deleteFeed(feed.getFeedNo());
            if (result > 0) {
                response.put("success", true);
                response.put("message", "피드가 성공적으로 삭제되었습니다.");
                log.info("Feed deleted successfully: {}", feed.getFeedNo());
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "피드 삭제에 실패했습니다.");
                log.warn("Failed to delete feed: {}", feed.getFeedNo());
                return ResponseEntity.badRequest().body(response);
            }

        } catch (Exception e) {
            log.error("피드 삭제 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "피드 삭제 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    //커뮤니티 참석자 추가
    @PostMapping("/invite")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> inviteParticipants(@RequestBody Map<String, Object> requestBody) {
        Map<String, Object> response = new HashMap<>();

        try {
            int communityNo = (int) requestBody.get("communityNo");
            List<Map<String, Object>> participants = (List<Map<String, Object>>) requestBody.get("participants");

//          Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//          Employee loginEmployee = (Employee) auth.getPrincipal();

            int result = communityService.inviteParticipants(communityNo, participants);
            if (result > 0) {
                response.put("success", true);
                response.put("message", participants.size() + "명의 참석자가 성공적으로 초대되었습니다.");
                log.info("{} participants invited to community {}", participants.size(), communityNo);
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "참석자 초대에 실패했습니다.");
                log.warn("Failed to invite participants to community {}", communityNo);
                return ResponseEntity.badRequest().body(response);
            }

        } catch (Exception e) {
            log.error("참석자 초대 중 오류 발생", e);
            response.put("success", false);
            response.put("message", "참석자 초대 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    @GetMapping("/nonParticipants")
    public ResponseEntity<?> getNonParticipants(@RequestParam int communityNo) {
        try {
            List<Employee> nonParticipants = communityService.getNonParticipants(communityNo);
            System.out.println(nonParticipants);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("nonParticipants", nonParticipants);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "비참여 사원 목록을 불러오는 중 오류가 발생했습니다.");

            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }



}