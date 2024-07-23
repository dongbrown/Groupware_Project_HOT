package com.project.hot.email.model.dao;

import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.dto.EmailAtt;
import com.project.hot.email.model.dto.EmailReceiver;
import com.project.hot.employee.model.dto.Employee;

import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public interface EmailDao {
    List<Email> selectInboxEmails(int employeeNo, SqlSession session);
    Email getEmailByNo(int emailNo, SqlSession session);
    int saveEmail(Email email, SqlSession session);
    void saveEmailReceiver(EmailReceiver receiver, SqlSession session);
    void saveAttachment(EmailAtt attachment, SqlSession session);
    List<Email> searchEmails(Map<String, Object> params, SqlSession session);
    void updateEmailReadStatus(int emailNo, int employeeNo, SqlSession session);
    void deleteEmails(List<Integer> emailNos, int employeeNo, SqlSession session);
    Employee findEmployeeByEmployeeId(String employeeId, SqlSession session);
    List<EmailAtt> selectEmailAttachments(int emailNo, SqlSession session);
    void toggleImportantEmail(int emailNo, int employeeNo, SqlSession session);
}