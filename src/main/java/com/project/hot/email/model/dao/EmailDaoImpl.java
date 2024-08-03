package com.project.hot.email.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.dto.EmailAtt;
import com.project.hot.email.model.dto.EmailReceiver;
import com.project.hot.employee.model.dto.Employee;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class EmailDaoImpl implements EmailDao {

    @Override
    public List<Email> selectInboxEmails(int employeeNo, int offset, int limit, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("employeeNo", employeeNo);
        params.put("offset", offset);
        params.put("limit", limit);
        return session.selectList("email.selectInboxEmails", params);
    }

    @Override
    public int countInboxEmails(int employeeNo, SqlSession session) {
        return session.selectOne("email.countInboxEmails", employeeNo);
    }

    @Override
    public List<Email> selectTrashEmails(int employeeNo, int offset, int limit, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("employeeNo", employeeNo);
        params.put("offset", offset);
        params.put("limit", limit);
        return session.selectList("email.selectTrashEmails", params);
    }

    @Override
    public int countTrashEmails(int employeeNo, SqlSession session) {
        return session.selectOne("email.countTrashEmails", employeeNo);
    }

    @Override
    public Email getEmailByNo(int emailNo, SqlSession session) {
        return session.selectOne("email.selectEmailByNo", emailNo);
    }

    @Override
    public int saveEmail(Email email, SqlSession session) {
        session.insert("email.insertEmail", email);
        return email.getEmailNo();
    }

    @Override
    public void saveEmailReceiver(EmailReceiver receiver, SqlSession session) {
        session.insert("email.insertEmailReceiver", receiver);
    }

    @Override
    public void saveAttachment(EmailAtt attachment, SqlSession session) {
        session.insert("email.insertAttachment", attachment);
    }

    @Override
    public List<Email> searchEmails(int employeeNo, String keyword, int offset, int limit, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("employeeNo", employeeNo);
        params.put("keyword", keyword);
        params.put("offset", offset);
        params.put("limit", limit);
        return session.selectList("email.searchEmails", params);
    }

    @Override
    public int countSearchEmails(int employeeNo, String keyword, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("employeeNo", employeeNo);
        params.put("keyword", keyword);
        return session.selectOne("email.countSearchEmails", params);
    }

    @Override
    public void updateEmailReadStatus(int emailNo, int employeeNo, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("emailNo", emailNo);
        params.put("employeeNo", employeeNo);
        session.update("email.updateEmailReadStatus", params);
    }

    @Override
    public void deleteEmails(List<Integer> emailNos, SqlSession session) {
        session.update("email.deleteEmails", emailNos);
    }

    @Override
    public Employee findEmployeeByEmployeeId(String employeeId, SqlSession session) {
        return session.selectOne("email.findEmployeeByEmployeeId", employeeId);
    }

    @Override
    public List<EmailAtt> selectEmailAttachments(int emailNo, SqlSession session) {
        return session.selectList("email.selectEmailAttachments", emailNo);
    }

    @Override
    public boolean toggleImportantEmail(int emailNo, int employeeNo, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("emailNo", emailNo);
        params.put("employeeNo", employeeNo);
        int result = session.update("email.toggleImportantEmail", params);
        return result > 0;
    }

    @Override
    public List<Employee> searchEmployees(String keyword, SqlSession session) {
        log.debug("Executing searchEmployees with keyword: {}", keyword);
        List<Employee> employees = session.selectList("email.searchEmployees", keyword);
        log.debug("Result of searchEmployees: {}", employees);
        return employees;
    }

    @Override
    public int moveEmailsToTrash(List<Integer> emailNos, int employeeNo, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("emailNos", emailNos);
        params.put("employeeNo", employeeNo);
        return session.update("email.moveEmailsToTrash", params);
    }

    @Override
    public List<Email> selectSentEmails(int employeeNo, int offset, int limit, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("employeeNo", employeeNo);
        params.put("offset", offset);
        params.put("limit", limit);
        return session.selectList("email.selectSentEmails", params);
    }

    @Override
    public int countSentEmails(int employeeNo, SqlSession session) {
        return session.selectOne("email.countSentEmails", employeeNo);
    }

    @Override
    public EmailAtt getAttachmentById(int attachmentId, SqlSession session) {
        return session.selectOne("email.selectAttachment", attachmentId);
    }

    @Override
    public int getUnreadCount(int employeeNo, SqlSession session) {
        return session.selectOne("email.getUnreadCount", employeeNo);
    }

    @Override
    public int markTrashAsRead(List<Integer> emailNos, SqlSession session) {
        return session.update("email.markTrashAsRead", emailNos);
    }

    @Override
    public int deletePermanently(List<Integer> emailNos, int employeeNo, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("emailNos", emailNos);
        params.put("employeeNo", employeeNo);
        return session.delete("email.deletePermanently", params);
    }

    @Override
    public int restoreFromTrash(List<Integer> emailNos, int employeeNo, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("emailNos", emailNos);
        params.put("employeeNo", employeeNo);
        return session.update("email.restoreFromTrash", params);
    }

    @Override
    public List<Email> selectImportantEmails(int employeeNo, int offset, int limit, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("employeeNo", employeeNo);
        params.put("offset", offset);
        params.put("limit", limit);
        return session.selectList("email.selectImportantEmails", params);
    }

    @Override
    public int countImportantEmails(int employeeNo, SqlSession session) {
        return session.selectOne("email.countImportantEmails", employeeNo);
    }

    @Override
    public List<Email> selectSelfEmails(int employeeNo, int offset, int limit, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("employeeNo", employeeNo);
        params.put("offset", offset);
        params.put("limit", limit);
        return session.selectList("email.selectSelfEmails", params);
    }

    @Override
    public int countSelfEmails(int employeeNo, SqlSession session) {
        return session.selectOne("email.countSelfEmails", employeeNo);
    }

    @Override
    public List<EmailAtt> getEmailAttachments(int emailNo, SqlSession session) {
        List<EmailAtt> attachments = session.selectList("email.selectEmailAttachments", emailNo);
        log.info("DAO - Attachments for email {}: {}", emailNo, attachments);
        return attachments;
    }

    @Override
    public void deleteAttachments(Integer emailNo, SqlSession session) {
        session.delete("email.deleteAttachments", emailNo);
    }

    @Override
    public Integer getInboxUnreadCount(int employeeNo, SqlSession session) {
        return session.selectOne("email.getInboxUnreadCount", employeeNo);
    }

    @Override
    public Integer getSelfUnreadCount(int employeeNo, SqlSession session) {
        return session.selectOne("email.getSelfUnreadCount", employeeNo);
    }

    @Override
    public Integer getImportantUnreadCount(int employeeNo, SqlSession session) {
        return session.selectOne("email.getImportantUnreadCount", employeeNo);
    }

    @Override
    public Integer getTrashCount(int employeeNo, SqlSession session) {
        return session.selectOne("email.getTrashCount", employeeNo);
    }

    @Override
    public void updateEmailContent(int emailNo, String newContent, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("emailNo", emailNo);
        params.put("content", newContent);
        session.update("email.updateEmailContent", params);
    }

    @Override
    public void updateEmailTitle(int emailNo, String newTitle, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("emailNo", emailNo);
        params.put("title", newTitle);
        session.update("email.updateEmailTitle", params);
    }

    @Override
    public void moveEmailToFolder(int emailNo, int folderId, int employeeNo, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("emailNo", emailNo);
        params.put("folderId", folderId);
        params.put("employeeNo", employeeNo);
        session.update("email.moveEmailToFolder", params);
    }

    @Override
    public List<Map<String, Object>> getEmailStatistics(int employeeNo, SqlSession session) {
        return session.selectList("email.getEmailStatistics", employeeNo);
    }
    @Override
    public void updateEmail(Email email, SqlSession session) {
        session.update("email.updateEmail", email);
    }

    @Override
    public List<Email> getRecentEmails(int employeeNo, int limit, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("employeeNo", employeeNo);
        params.put("limit", limit);
        return session.selectList("email.getRecentEmails", params);
    }

    // 추가적인 유틸리티 메서드

    private Map<String, Object> createPagingParams(int employeeNo, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("employeeNo", employeeNo);
        params.put("offset", offset);
        params.put("limit", limit);
        return params;
    }

    // 에러 처리 메서드
    private void handleSqlException(Exception e, String operation) {
        log.error("SQL error during {}: {}", operation, e.getMessage());
        throw new RuntimeException("Database operation failed: " + operation, e);
    }


    public void batchInsertEmails(List<Email> emails, SqlSession session) {
        try {
            for (Email email : emails) {
                session.insert("email.insertEmail", email);
            }
        } catch (Exception e) {
            handleSqlException(e, "batch inserting emails");
        }
    }

    public void batchUpdateEmailStatuses(List<Integer> emailNos, String status, SqlSession session) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("emailNos", emailNos);
            params.put("status", status);
            session.update("email.batchUpdateEmailStatuses", params);
        } catch (Exception e) {
            handleSqlException(e, "batch updating email statuses");
        }
    }

    public List<Email> getEmailsByFolder(int folderId, int employeeNo, int offset, int limit, SqlSession session) {
        try {
            Map<String, Object> params = createPagingParams(employeeNo, offset, limit);
            params.put("folderId", folderId);
            return session.selectList("email.getEmailsByFolder", params);
        } catch (Exception e) {
            handleSqlException(e, "getting emails by folder");
            return null;
        }
    }

    public int countEmailsByFolder(int folderId, int employeeNo, SqlSession session) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("folderId", folderId);
            params.put("employeeNo", employeeNo);
            return session.selectOne("email.countEmailsByFolder", params);
        } catch (Exception e) {
            handleSqlException(e, "counting emails by folder");
            return 0;
        }
    }

    public void createFolder(String folderName, int employeeNo, SqlSession session) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("folderName", folderName);
            params.put("employeeNo", employeeNo);
            session.insert("email.createFolder", params);
        } catch (Exception e) {
            handleSqlException(e, "creating folder");
        }
    }

    public void deleteFolder(int folderId, int employeeNo, SqlSession session) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("folderId", folderId);
            params.put("employeeNo", employeeNo);
            session.delete("email.deleteFolder", params);
        } catch (Exception e) {
            handleSqlException(e, "deleting folder");
        }
    }

    public List<Map<String, Object>> getFolders(int employeeNo, SqlSession session) {
        try {
            return session.selectList("email.getFolders", employeeNo);
        } catch (Exception e) {
            handleSqlException(e, "getting folders");
            return null;
        }
    }

}
