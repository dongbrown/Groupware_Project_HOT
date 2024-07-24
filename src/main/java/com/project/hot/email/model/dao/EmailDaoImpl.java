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
        return email.getEmailNo();  // 자동 생성된 키 값 반환
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
    public List<Email> searchEmails(Map<String, Object> params, SqlSession session) {
        return session.selectList("email.searchEmails", params);
    }

    @Override
    public void updateEmailReadStatus(int emailNo, int employeeNo, SqlSession session) {
        Map<String, Object> params = Map.of("emailNo", emailNo, "employeeNo", employeeNo);
        session.update("email.updateEmailReadStatus", params);
    }

    @Override
    public void deleteEmails(List<Integer> emailNos, int employeeNo, SqlSession session) {
        Map<String, Object> params = Map.of("emailNos", emailNos, "employeeNo", employeeNo);
        session.update("email.deleteEmails", params);
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
    public void toggleImportantEmail(int emailNo, int employeeNo, SqlSession session) {
        Map<String, Object> params = Map.of("emailNo", emailNo, "employeeNo", employeeNo);
        session.update("email.toggleImportantEmail", params);
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


}