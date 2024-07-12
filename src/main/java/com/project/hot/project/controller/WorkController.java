package com.project.hot.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.service.ProjectService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/work")
@RequiredArgsConstructor
public class WorkController {

	private final ProjectService service;

	@GetMapping("/insertwork.do")
	public String insertWork (int projectNo,Model m) {
		Project project = service.selectProjectByNo(projectNo);
		m.addAttribute("project",project);
		 return "project/insertWorkDetail";
	}

}
