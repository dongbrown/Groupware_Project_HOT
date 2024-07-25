package com.project.hot.email.model.service;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.email.model.dao.EmailDao;
import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.dto.EmailAtt;
import com.project.hot.email.model.dto.EmailReceiver;
import com.project.hot.employee.model.dto.Employee;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private EmailDao dao;

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Email> getInboxEmails(int employeeNo) {
        return dao.selectInboxEmails(employeeNo, sqlSession);
    }

    @Override
    public Email getEmailByNo(int emailNo) {
        return dao.getEmailByNo(emailNo, sqlSession);
    }

    @Override
    public Employee findEmployeeByEmployeeId(String employeeId) {
        return dao.findEmployeeByEmployeeId(employeeId, sqlSession);
    }

    @Override
    @Transactional
    public void saveEmail(Email email, MultipartFile[] attachments) throws IOException {
        try {
            int emailNo = dao.saveEmail(email, sqlSession);
            email.setEmailNo(emailNo);

            for (EmailReceiver receiver : email.getReceivers()) {
                receiver.setEmailNo(emailNo);
                dao.saveEmailReceiver(receiver, sqlSession);
            }

            if (attachments != null) {
                for (MultipartFile attachment : attachments) {
                    if (attachment != null && !attachment.isEmpty()) {
                        EmailAtt emailAtt = EmailAtt.builder()
                            .emailNo(emailNo)
                            .emailAttOriginalFilename(attachment.getOriginalFilename())
                            .emailAttRenamedFilename(saveAttachmentFile(attachment))
                            .build();
                        dao.saveAttachment(emailAtt, sqlSession);
                    }
                }
            }
        } catch (Exception e) {
            log.error("이메일 저장 실패", e);
            throw new RuntimeException("이메일 저장 중 오류 발생: " + e.getMessage(), e);
        }
    }

    private String saveAttachmentFile(MultipartFile file) throws IOException {
        // 첨부 파일 저장 로직 구현
        // 파일 시스템에 저장하고 저장된 파일명 반환
        return "saved_" + file.getOriginalFilename(); // 예시 구현
    }

    @Override
    public List<Employee> searchEmployees(String keyword) {
        return dao.searchEmployees(keyword, sqlSession);
    }

    @Override
    @Transactional
    public int moveEmailsToTrash(List<Integer> emailNos, int employeeNo) {
        return dao.moveEmailsToTrash(emailNos, employeeNo, sqlSession);
    }

    @Override
    public List<Email> getTrashEmails(int employeeNo) {
        return dao.selectTrashEmails(sqlSession, employeeNo);
    }

	@Override
	public List<Email> getSentEmails(int employeeNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteEmails(List<Integer> emailNos) {
		// TODO Auto-generated method stub

	}

	@Override
	public byte[] downloadAttachment(int attachmentId) throws IOException {
		// TODO Auto-generated method stub
		return null;
	}
}