package com.project.hot.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/work")
public class WorkController {

	@GetMapping("/insertwork.do")
	public String insertWork (int projectNo) {
		 return "project/insertWorkDetail";
	}

}
