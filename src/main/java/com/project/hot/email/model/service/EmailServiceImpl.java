package com.project.hot.email.model.service;

import com.project.hot.email.model.dao.EmailDao;
import com.project.hot.email.model.dto.Email;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private EmailDao dao;

    @Autowired
    private SqlSession session;

    @Override
    public List<Email> getInboxEmails(int employeeNo) {
        return dao.selectInboxEmails(employeeNo, session);
    }

	@Override
	public Email getEmailByNo(int emailNo) {
		return dao.getEmailByNo(emailNo, session);
	}
}