package com.project.hot.email.model.dao;

import com.project.hot.email.model.dto.Email;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

public interface EmailDao {
    List<Email> selectInboxEmails(int employeeNo, SqlSession session);

	Email getEmailByNo(int emailNo, SqlSession session);
}