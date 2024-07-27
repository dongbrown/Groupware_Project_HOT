package com.project.hot.email.model.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.dto.EmailAtt;
import com.project.hot.employee.model.dto.Employee;

public interface EmailService {

    List<Email> getInboxEmails(int employeeNo);

    List<Email> getTrashEmails(int employeeNo);

    Email getEmailByNo(int emailNo);

    Employee findEmployeeByEmployeeId(String employeeId);

    List<Employee> searchEmployees(String keyword);

    int moveEmailsToTrash(List<Integer> emailNos, int employeeNo);

    void saveEmail(Email email, MultipartFile[] attachments) throws IOException;

    List<Email> getSentEmails(int employeeNo);

    void deleteEmails(List<Integer> emailNos);

    byte[] downloadAttachment(int attachmentId) throws IOException;

    EmailAtt saveImage(MultipartFile file) throws IOException;

    List<Email> searchEmails(int employeeNo, String keyword);

    Email prepareReplyEmail(Email originalEmail);

    Email prepareForwardEmail(Email originalEmail);

    int getUnreadCount(int employeeNo);

    void markEmailAsRead(int emailNo, int employeeNo);

    boolean toggleImportantEmail(int emailNo, int employeeNo);

}