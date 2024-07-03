package com.project.hot.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/project")
public class ProjectController {

	@GetMapping("/projectupdate.do")
	public String projectUpdate () {
//		m.addAttribute("projectNo",projectNo);
		return "project/projectUpdate";
	};
}
