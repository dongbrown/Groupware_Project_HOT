package com.project.hot.email.model.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.project.hot.email.model.dto.Email;
import com.project.hot.employee.model.dto.Employee;

import jakarta.mail.MessagingException;

public interface EmailService {

	//받은 메일함
    List<Email> getInboxEmails(int employeeNo);

    //휴지통
    List<Email> getTrashEmails(int employeeNo);

    Email getEmailByNo(int emailNo);

    void sendEmail(Email email, MultipartFile[] attachments, String senderEmail) throws MessagingException, IOException;

    String uploadImage(MultipartFile file) throws IOException;

    Employee findEmployeeByEmployeeId(String employeeId);

	List<Employee> searchEmployees(String keyword);

	int moveEmailsToTrash(List<Integer> emailNos, int employeeNo);


}