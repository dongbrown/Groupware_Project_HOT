package com.project.hot.email.model.service;

import java.util.List;

import com.project.hot.email.model.dto.Email;

public interface EmailService {

	List<Email> getInboxEmails(int employeeNo);

	Email getEmailByNo(int emailNo);

}
