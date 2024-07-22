package com.project.hot.email.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.service.EmailService;
import com.project.hot.employee.model.dto.Employee;

@Controller
@RequestMapping("/email")
public class EmailController {

    @Autowired
    private EmailService service;

    @GetMapping("/")
    public String showEmail() {
        return "email/email";
    }


    @GetMapping("/inbox")
    public String showInbox(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();

        List<Email> inboxEmails = service.getInboxEmails(employeeNo);
        model.addAttribute("emails", inboxEmails);

        return "email/inbox";
    }

//    @PostMapping("/delete")
//    @ResponseBody
//    public String deleteEmails(@RequestBody List<Integer> emailNos) {
//        service.deleteEmails(emailNos);
//        return "success";
//    }
//
//    @GetMapping("/search")
//    public String searchEmails(@RequestParam String mailbox, @RequestParam String keyword, Model model) {
//        List<Email> searchResults = service.searchEmails(mailbox, keyword);
//        model.addAttribute("emails", searchResults);
//        return "email/inbox :: #mailItems";
//    }


//    @GetMapping("/sent")
//    public String showSentMails(Model model) {
//        List<Email> sentEmails = service.getSentEmails();
//        model.addAttribute("emails", sentEmails);
//        return "email/sent";
//    }
//
    @GetMapping("/view/{emailNo}")
    public String viewEmail(@PathVariable int emailNo, Model model) {
        Email email = service.getEmailByNo(emailNo);
        model.addAttribute("email", email);
        return "email/view";
    }
//
//    @GetMapping("/compose")
//    public String showComposeForm(Model model) {
//        model.addAttribute("email", new Email());
//        return "email/compose";
//    }
//
//    @PostMapping("/send")
//    public String sendEmail(@ModelAttribute Email email) {
//    	service.sendEmail(email);
//        return "redirect:/email/sent";
//    }
//
//
//    @GetMapping("/reply/{emailNo}")
//    public String showReplyForm(@PathVariable int emailNo, Model model) {
//        Email originalEmail = service.getEmailByNo(emailNo);
//        Email replyEmail = service.prepareReplyEmail(originalEmail);
//        model.addAttribute("email", replyEmail);
//        return "email/compose";
//    }
//
//    @GetMapping("/forward/{emailNo}")
//    public String showForwardForm(@PathVariable int emailNo, Model model) {
//        Email originalEmail = service.getEmailByNo(emailNo);
//        Email forwardEmail = service.prepareForwardEmail(originalEmail);
//        model.addAttribute("email", forwardEmail);
//        return "email/compose";
//    }
//
//    @GetMapping("/unread-count")
//    @ResponseBody
//    public int getUnreadCount() {
//        return service.getUnreadCount();
//    }
}