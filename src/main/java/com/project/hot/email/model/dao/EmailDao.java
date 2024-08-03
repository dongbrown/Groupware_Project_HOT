package com.project.hot.email.model.dao;

import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.dto.EmailAtt;
import com.project.hot.email.model.dto.EmailReceiver;
import com.project.hot.employee.model.dto.Employee;
import org.apache.ibatis.session.SqlSession;
import java.util.List;
import java.util.Map;

public interface EmailDao {
    List<Email> selectInboxEmails(int employeeNo, int offset, int limit, SqlSession session);
    int countInboxEmails(int employeeNo, SqlSession session);

    List<Email> selectTrashEmails(int employeeNo, int offset, int limit, SqlSession session);
    int countTrashEmails(int employeeNo, SqlSession session);

    List<Email> selectSentEmails(int employeeNo, int offset, int limit, SqlSession session);
    int countSentEmails(int employeeNo, SqlSession session);

    List<Email> selectImportantEmails(int employeeNo, int offset, int limit, SqlSession session);
    int countImportantEmails(int employeeNo, SqlSession session);

    List<Email> selectSelfEmails(int employeeNo, int offset, int limit, SqlSession session);
    int countSelfEmails(int employeeNo, SqlSession session);

    Email getEmailByNo(int emailNo, SqlSession session);
    int saveEmail(Email email, SqlSession session);
    void saveEmailReceiver(EmailReceiver receiver, SqlSession session);
    void saveAttachment(EmailAtt attachment, SqlSession session);

    List<Email> searchEmails(int employeeNo, String keyword, int offset, int limit, SqlSession session);
    int countSearchEmails(int employeeNo, String keyword, SqlSession session);

    void updateEmailReadStatus(int emailNo, int employeeNo, SqlSession session);
    void deleteEmails(List<Integer> emailNos, SqlSession session);
    Employee findEmployeeByEmployeeId(String employeeId, SqlSession session);
    List<EmailAtt> selectEmailAttachments(int emailNo, SqlSession session);
    boolean toggleImportantEmail(int emailNo, int employeeNo, SqlSession session);
    List<Employee> searchEmployees(String keyword, SqlSession session);
    int moveEmailsToTrash(List<Integer> emailNos, int employeeNo, SqlSession session);
    EmailAtt getAttachmentById(int attachmentId, SqlSession session);
    int getUnreadCount(int employeeNo, SqlSession session);
    int markTrashAsRead(List<Integer> emailNos, SqlSession session);
    int deletePermanently(List<Integer> emailNos, int employeeNo, SqlSession session);
    int restoreFromTrash(List<Integer> emailNos, int employeeNo, SqlSession session);
    List<EmailAtt> getEmailAttachments(int emailNo, SqlSession sqlSession);
    void deleteAttachments(Integer emailNo, SqlSession sqlSession);
    Integer getInboxUnreadCount(int employeeNo, SqlSession sqlSession);
    Integer getSelfUnreadCount(int employeeNo, SqlSession sqlSession);
    Integer getImportantUnreadCount(int employeeNo, SqlSession sqlSession);
    Integer getTrashCount(int employeeNo, SqlSession sqlSession);

    void updateEmailContent(int emailNo, String newContent, SqlSession session);
    void updateEmailTitle(int emailNo, String newTitle, SqlSession session);
    void moveEmailToFolder(int emailNo, int folderId, int employeeNo, SqlSession session);
    List<Map<String, Object>> getEmailStatistics(int employeeNo, SqlSession session);
    void updateEmail(Email email, SqlSession session);
    List<Email> getRecentEmails(int employeeNo, int limit, SqlSession session);
	List<Email> selectRecentInboxEmails(int employeeNo, int limit, SqlSession sqlSession);
}