package com.project.hot.email.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.dto.EmailAtt;
import com.project.hot.email.model.dto.EmailReceiver;
import com.project.hot.email.model.service.EmailService;
import com.project.hot.employee.model.dto.Employee;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/email")
public class EmailController {

    @Autowired
    private EmailService service;

    // 이메일 페이지를 표시
    @GetMapping("/")
    public String showEmail() {
        return "email/email";
    }

    // 받은 편지함 목록을 표시
    @GetMapping("/inbox")
    public String inbox(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        List<Email> inboxEmails = service.getInboxEmails(loginEmployee.getEmployeeNo());
        model.addAttribute("emails", inboxEmails);
        return "email/inbox";
    }

    // 보낸메일함 목록을 표시
    @GetMapping("/sent")
    public String sent(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        List<Email> sentEmails = service.getSentEmails(loginEmployee.getEmployeeNo());
        model.addAttribute("emails", sentEmails);
        return "email/sent";
    }

    // 중요메일함 목록을 표시
    @GetMapping("/important")
    public String important(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        List<Email> importantEmails = service.getImportantEmails(loginEmployee.getEmployeeNo());
        model.addAttribute("emails", importantEmails);
        return "email/important";
    }

    // 내게쓴 메일함 목록을 표시
    @GetMapping("/self")
    public String self(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        List<Email> selfEmails = service.getSelfEmails(loginEmployee.getEmployeeNo());
        model.addAttribute("emails", selfEmails);
        return "email/self";
    }

    // 휴지통 목록을 표시
    @GetMapping("/trash")
    public String trash(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        List<Email> trashEmails = service.getTrashEmails(loginEmployee.getEmployeeNo());
        model.addAttribute("emails", trashEmails);
        return "email/trash";
    }

    // 특정 이메일을 표시
    @GetMapping("/view/{emailNo}")
    public String viewEmail(@PathVariable int emailNo, Model model) {
        Email email = service.getEmailByNo(emailNo);
        model.addAttribute("email", email);
        return "email/view";
    }

    // 이메일 작성 폼을 표시
    @GetMapping("/write")
    public String showWriteForm(Model model) {
        model.addAttribute("email", new Email());
        return "email/write";
    }

    //내게쓰기
    @GetMapping("/write-self")
    public String showWriteSelfForm(Model model) {
        model.addAttribute("email", new Email());
        return "email/write-self";
    }

    // 이메일을 전송
    @PostMapping("/send")
    public ResponseEntity<?> saveEmail(
            @RequestParam("receivers") String receivers,
            @RequestParam("emailTitle") String emailTitle,
            @RequestParam("emailContent") String emailContent,
            @RequestParam(value = "attachments", required = false) MultipartFile[] attachments) {

        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            Employee sender = (Employee) auth.getPrincipal();

            Email email = Email.builder()
                    .sender(sender)
                    .emailTitle(emailTitle)
                    .emailContent(emailContent)
                    .emailSendDate(new Date(System.currentTimeMillis()))
                    .emailIsDelete("N")
                    .build();

            List<EmailReceiver> emailReceivers = new ArrayList<>();
            String[] receiverEmails = receivers.split(",");

            for (String receiverEmail : receiverEmails) {
                String trimmedEmail = receiverEmail.trim();
                String employeeId = trimmedEmail.split("@")[0]; // '@hot.com' 제거

                if (!employeeId.isEmpty()) {
                    Employee receiver = service.findEmployeeByEmployeeId(employeeId);
                    if (receiver != null) {
                        EmailReceiver emailReceiver = EmailReceiver.builder().employee(receiver).build();
                        if (!emailReceivers.contains(emailReceiver)) { // 중복 체크
                            emailReceivers.add(emailReceiver);
                        }
                    }
                }
            }

            if (emailReceivers.isEmpty()) {
                log.warn("수신자 없음: {}", receivers);
                return ResponseEntity.badRequest().body("유효한 수신자가 없습니다.");
            }

            log.info("Processed receivers: {}", emailReceivers);
            email.setReceivers(emailReceivers);

            service.saveEmail(email, attachments);

            return ResponseEntity.ok().body("이메일 전송 성공");

        } catch (IOException e) {
            log.error("이메일 전송 실패", e);
            return ResponseEntity.badRequest().body("이메일 전송 실패 : " + e.getMessage());
        }
    }

    // 키워드를 이용해 직원 검색
    @GetMapping("/search-employees")
    public ResponseEntity<List<Map<String, String>>> searchEmployees(@RequestParam String keyword) {
        try {
            List<Employee> employees = service.searchEmployees(keyword);
            List<Map<String, String>> result = new ArrayList<>();

            for (Employee employee : employees) {
                if (employee != null) {
                    Map<String, String> employeeMap = new HashMap<>();
                    employeeMap.put("name", employee.getEmployeeName() != null ? employee.getEmployeeName() : "");
                    employeeMap.put("email", employee.getEmployeeId() != null ? employee.getEmployeeId() + "@hot.com" : "");
                    result.add(employeeMap);
                } else {
                    log.warn("Null employee object found in search results for keyword: {}", keyword);
                }
            }

            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.error("Error occurred while searching employees", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    // 이메일을 휴지통으로 이동
    @PostMapping("/move-to-trash")
    @ResponseBody
    public ResponseEntity<?> moveEmailsToTrash(@RequestBody List<Integer> emailNos) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();

        try {
            int movedCount = service.moveEmailsToTrash(emailNos, employeeNo);
            String message = movedCount > 1 ?
                movedCount + "개의 이메일이 휴지통으로 이동되었습니다." :
                "이메일이 휴지통으로 이동되었습니다.";
            return ResponseEntity.ok(message);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("이메일 이동 실패: " + e.getMessage());
        }
    }

    @GetMapping("/search")
    public String searchEmails(@RequestParam String keyword, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();

        List<Email> searchResults = service.searchEmails(employeeNo, keyword);
        model.addAttribute("emails", searchResults);

        return "email/inbox-list";
    }

    // 답장 이메일 작성 폼을 표시
    @GetMapping("/reply/{emailNo}")
    public String showReplyForm(@PathVariable int emailNo, Model model) {
        Email originalEmail = service.getEmailByNo(emailNo);
        Email replyEmail = service.prepareReplyEmail(originalEmail);
        model.addAttribute("email", replyEmail);
        return "email/write";
    }

    // 이메일 전달 작성 폼을 표시
    @GetMapping("/forward/{emailNo}")
    public String showForwardForm(@PathVariable int emailNo, Model model) {
        Email originalEmail = service.getEmailByNo(emailNo);
        Email forwardEmail = service.prepareForwardEmail(originalEmail);
        model.addAttribute("email", forwardEmail);
        return "email/write";
    }

    // 읽지 않은 이메일 수를 반환
    @GetMapping("/unread-count")
    @ResponseBody
    public ResponseEntity<Integer> getUnreadCount() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();

        int unreadCount = service.getUnreadCount(employeeNo);
        return ResponseEntity.ok(unreadCount);
    }

    // 이메일을 읽음으로 표시
    @PostMapping("/mark-as-read/{emailNo}")
    @ResponseBody
    public ResponseEntity<?> markAsRead(@PathVariable int emailNo) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();

        try {
            service.markEmailAsRead(emailNo, employeeNo);
            return ResponseEntity.ok("이메일이 읽음 상태로 변경되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("상태 변경 실패: " + e.getMessage());
        }
    }

    // 이메일 중요 표시를 토글
    @PostMapping("/toggle-important/{emailNo}")
    @ResponseBody
    public ResponseEntity<?> toggleImportant(@PathVariable int emailNo) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Employee loginEmployee = (Employee) auth.getPrincipal();
        int employeeNo = loginEmployee.getEmployeeNo();

        try {
            boolean isImportant = service.toggleImportantEmail(emailNo, employeeNo);
            String message = isImportant ? "중요 이메일로 변경되었습니다." : "이메일의 중요 표시가 해제되었습니다.";
            return ResponseEntity.ok(message);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("중요 표시 변경 실패: " + e.getMessage());
        }
    }

    @PostMapping("/trash/mark-as-read")
    @ResponseBody
    public ResponseEntity<?> markTrashAsRead(@RequestBody List<Integer> emailNos) {
        try {
            int updatedCount = service.markTrashAsRead(emailNos);
            return ResponseEntity.ok("성공적으로 " + updatedCount + "개의 이메일을 읽음 처리했습니다.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("읽음 처리 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    @PostMapping("/trash/delete-permanently")
    @ResponseBody
    public ResponseEntity<?> deletePermanently(@RequestBody List<Integer> emailNos) {
        try {
            int deletedCount = service.deletePermanently(emailNos);
            return ResponseEntity.ok("성공적으로 " + deletedCount + "개의 이메일을 영구 삭제했습니다.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("영구 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    @PostMapping("/trash/restore")
    @ResponseBody
    public ResponseEntity<?> restoreFromTrash(@RequestBody List<Integer> emailNos) {
        try {
            int restoredCount = service.restoreFromTrash(emailNos);
            return ResponseEntity.ok("성공적으로 " + restoredCount + "개의 이메일을 복구했습니다.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("복구 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
}