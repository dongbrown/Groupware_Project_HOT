package com.project.hot.email.model.dao;

import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.dto.EmailAtt;
import com.project.hot.email.model.dto.EmailReceiver;
import com.project.hot.employee.model.dto.Employee;

import org.apache.ibatis.session.SqlSession;

import java.util.List;

public interface EmailDao {
    List<Email> selectInboxEmails(int employeeNo, SqlSession session);
    List<Email> selectTrashEmails(SqlSession session, int employeeNo);
    Email getEmailByNo(int emailNo, SqlSession session);
    int saveEmail(Email email, SqlSession session);
    void saveEmailReceiver(EmailReceiver receiver, SqlSession session);
    void saveAttachment(EmailAtt attachment, SqlSession session);
    List<Email> searchEmails(int employeeNo, String keyword, SqlSession session);
    void updateEmailReadStatus(int emailNo, int employeeNo, SqlSession session);
    void deleteEmails(List<Integer> emailNos, SqlSession session);
    Employee findEmployeeByEmployeeId(String employeeId, SqlSession session);
    List<EmailAtt> selectEmailAttachments(int emailNo, SqlSession session);
    boolean toggleImportantEmail(int emailNo, int employeeNo, SqlSession session);
    List<Employee> searchEmployees(String keyword, SqlSession session);
    int moveEmailsToTrash(List<Integer> emailNos, int employeeNo, SqlSession session);
    List<Email> selectSentEmails(int employeeNo, SqlSession session);
    EmailAtt getAttachmentById(int attachmentId, SqlSession session);
    int getUnreadCount(int employeeNo, SqlSession session);
	int markTrashAsRead(List<Integer> emailNos, SqlSession session);
    int deletePermanently(List<Integer> emailNos, int employeeNo, SqlSession session);
	int restoreFromTrash(List<Integer> emailNos, int employeeNo, SqlSession session);	List<Email> getImportantEmails(int employeeNo, SqlSession session);
	List<Email> getSelfEmails(int employeeNo, SqlSession session);
	List<EmailAtt> getEmailAttachments(int emailNo, SqlSession sqlSession);
	void deleteAttachments(Integer emailNo, SqlSession sqlSession);
}