package com.project.hot.email.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/email")
public class EmailController {

	@GetMapping("/")
	public String showEmail() {
		return "email/email";
	}

}
