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

import jakarta.mail.Session;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class EmailDaoImpl implements EmailDao {

    @Override
    public List<Email> selectInboxEmails(int employeeNo, SqlSession session) {
        return session.selectList("email.selectInboxEmails", employeeNo);
    }

    @Override
    public List<Email> selectTrashEmails(SqlSession session, int employeeNo) {
        return session.selectList("email.selectTrashEmails", employeeNo);
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
    public List<Email> searchEmails(int employeeNo, String keyword, SqlSession session) {
        Map<String, Object> params = new HashMap<>();
        params.put("employeeNo", employeeNo);
        params.put("keyword", keyword);
        return session.selectList("email.searchEmails", params);
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
    public List<Email> selectSentEmails(int employeeNo, SqlSession session) {
        return session.selectList("email.selectSentEmails", employeeNo);
    }

    @Override
    public EmailAtt getAttachmentById(int attachmentId, SqlSession session) {
        return session.selectOne("email.selectAttachment", attachmentId);
    }

    @Override
    public int getUnreadCount(int employeeNo, SqlSession session) {
        return session.selectOne("email.getUnreadCount", employeeNo);
    }
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
	public List<Email> getImportantEmails(int employeeNo, SqlSession session) {
		return session.selectList("email.selectImportantEmails", employeeNo);
	}

	@Override
	public List<Email> getSelfEmails(int employeeNo, SqlSession session) {
		return session.selectList("email.selectSelfEmails", employeeNo);
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


}