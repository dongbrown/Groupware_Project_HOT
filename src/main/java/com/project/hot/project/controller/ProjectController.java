package com.project.hot.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/project")
public class ProjectController {

	@RequestMapping("/projectUpdate.do")
	public String projectUpdate (int projectNo,Model m) {
		m.addAttribute("projectNo",projectNo);
		return "project/updateProject";
	};
}
