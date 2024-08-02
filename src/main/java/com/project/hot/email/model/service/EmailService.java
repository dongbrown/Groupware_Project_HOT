package com.project.hot.email.model.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.dto.EmailAtt;
import com.project.hot.employee.model.dto.Employee;

public interface EmailService {
    Map<String, Object> getInboxEmails(int employeeNo, int page, int size);
    Map<String, Object> getTrashEmails(int employeeNo, int page, int size);
    Map<String, Object> getSentEmails(int employeeNo, int page, int size);
    Map<String, Object> getImportantEmails(int employeeNo, int page, int size);
    Map<String, Object> getSelfEmails(int employeeNo, int page, int size);

    Email getEmailByNo(int emailNo);
    Employee findEmployeeByEmployeeId(String employeeId);
    List<Employee> searchEmployees(String keyword);
    int moveEmailsToTrash(List<Integer> emailNos, int employeeNo);
    void saveEmail(Email email, MultipartFile[] attachments) throws IOException;
    void deleteEmails(List<Integer> emailNos);
    byte[] downloadAttachment(int attachmentId) throws IOException;
    EmailAtt saveImage(MultipartFile file) throws IOException;
    Map<String, Object> searchEmails(int employeeNo, String keyword, int page, int size);
    Email prepareReplyEmail(Email originalEmail);
    Email prepareForwardEmail(Email originalEmail);
    int getUnreadCount(int employeeNo);
    void markEmailAsRead(int emailNo, int employeeNo);
    boolean toggleImportantEmail(int emailNo, int employeeNo);
    int markTrashAsRead(List<Integer> emailNos);
    int deletePermanently(List<Integer> emailNos, int employeeNo);
    int restoreFromTrash(List<Integer> emailNos, int employeeNo);
    EmailAtt getAttachment(int attachmentId);
    List<EmailAtt> getEmailAttachments(int emailNo);
    Integer getInboxUnreadCount(int employeeNo);
    Integer getSelfUnreadCount(int employeeNo);
    Integer getImportantUnreadCount(int employeeNo);
    Integer getTrashCount(int employeeNo);
}