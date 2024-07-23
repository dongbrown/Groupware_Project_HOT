package com.project.hot.email.model.dao;

import com.project.hot.email.model.dto.Email;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EmailDaoImpl implements EmailDao {


    @Override
    public List<Email> selectInboxEmails(int employeeNo, SqlSession session) {
        return session.selectList("email.selectInboxEmails", employeeNo);
    }


	@Override
	public Email getEmailByNo(int emailNo, SqlSession session) {
		return session.selectOne("email.selectEmailByNo", emailNo);
	}
}