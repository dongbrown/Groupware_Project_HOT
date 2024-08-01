package com.project.hot.common.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.project.hot.community.controller.CommunityController;
import com.project.hot.community.model.dto.Community;
import com.project.hot.community.model.service.CommunityService;
import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.service.EmailService;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.feed.model.service.FeedService;
import com.project.hot.project.model.dto.Project;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/index")
public class IndexController {

    private final CommunityService communityService;
    private final FeedService feedService;

    @Autowired
    private EmailService service;

	 // 메인 커뮤니티 리스트 출력
    @ResponseBody
    @GetMapping("/communityList.do")
    public List<Community> openCommunityList() {
	    	List<Community> communities = communityService.getCommunityList();
	    	return communities;
    }
    // 받은 편지함 목록을 표시
    @ResponseBody
    @GetMapping("/inbox.do")
    public List<Email> inbox() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        List<Email> inboxEmails = service.getInboxEmails(loginEmployee.getEmployeeNo());
        System.out.println("ddddddddddddddddddddddddddddddd"+inboxEmails);
        return inboxEmails;
    }
}
