package com.project.hot.email.model.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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

    private final String fileUploadDir;
    private final EmailDao dao;
    private final SqlSession sqlSession;

    @Autowired
    public EmailServiceImpl(@Value("${image.upload.directory}") String fileUploadDir,
                            EmailDao dao, SqlSession sqlSession) {
        this.fileUploadDir = fileUploadDir;
        this.dao = dao;
        this.sqlSession = sqlSession;
        createUploadDirectory();
    }

    private void createUploadDirectory() {
        File directory = new File(fileUploadDir);
        if (!directory.exists()) {
            if (directory.mkdirs()) {
                log.info("Upload directory created: {}", fileUploadDir);
            } else {
                log.error("Failed to create upload directory: {}", fileUploadDir);
            }
        }
    }

    @Override
    public List<Email> getInboxEmails(int employeeNo) {
        return dao.selectInboxEmails(employeeNo, sqlSession);
    }

    @Override
    public List<Email> getTrashEmails(int employeeNo) {
        return dao.selectTrashEmails(sqlSession, employeeNo);
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
                receiver.setEmailReceiverIsRead("N");
                receiver.setEmailReceiverIsDelete("N");
                receiver.setEmailReceiverIsImportant("N");
                dao.saveEmailReceiver(receiver, sqlSession);
            }

            if (attachments != null) {
                for (MultipartFile attachment : attachments) {
                    if (attachment != null && !attachment.isEmpty()) {
                        EmailAtt emailAtt = saveImage(attachment);
                        emailAtt.setEmailNo(emailNo);
                        dao.saveAttachment(emailAtt, sqlSession);
                    }
                }
            }
        } catch (Exception e) {
            log.error("이메일 저장 실패", e);
            throw new RuntimeException("이메일 저장 중 오류 발생: " + e.getMessage(), e);
        }
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
    public List<Email> getSentEmails(int employeeNo) {
        return dao.selectSentEmails(employeeNo, sqlSession);
    }

    @Override
    @Transactional
    public void deleteEmails(List<Integer> emailNos) {
        dao.deleteEmails(emailNos, sqlSession);
    }

    @Override
    public byte[] downloadAttachment(int attachmentId) throws IOException {
        EmailAtt attachment = dao.getAttachmentById(attachmentId, sqlSession);
        if (attachment == null) {
            throw new IOException("Attachment not found");
        }
        // 실제 파일 시스템에서 파일을 읽어 byte[]로 변환하는 로직 구현 필요
        return new byte[0]; // 임시 반환값
    }


    @Override
    public EmailAtt saveImage(MultipartFile file) throws IOException {
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String savedFilename = UUID.randomUUID().toString() + extension;

        File destFile = new File(fileUploadDir, savedFilename);

        try {
            Files.copy(file.getInputStream(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            log.info("File saved successfully: {}", destFile.getAbsolutePath());
        } catch (IOException e) {
            log.error("Failed to save file: {}", destFile.getAbsolutePath(), e);
            throw new IOException("Failed to save file: " + destFile.getAbsolutePath(), e);
        }

        EmailAtt emailAtt = EmailAtt.builder()
                .emailAttOriginalFilename(originalFilename)
                .emailAttRenamedFilename(savedFilename)
                .build();

        dao.saveAttachment(emailAtt, sqlSession);

        return emailAtt;
    }


    @Override
    public List<Email> searchEmails(int employeeNo, String keyword) {
        return dao.searchEmails(employeeNo, keyword, sqlSession);
    }

    @Override
    public Email prepareReplyEmail(Email originalEmail) {
        Email replyEmail = new Email();
        replyEmail.setEmailTitle("Re: " + originalEmail.getEmailTitle());

        EmailReceiver originalSender = new EmailReceiver();
        originalSender.setEmployee(originalEmail.getSender());
        replyEmail.setReceivers(List.of(originalSender));

        replyEmail.setEmailContent("\n\n--- Original Message ---\n" + originalEmail.getEmailContent());
        return replyEmail;
    }

    @Override
    public Email prepareForwardEmail(Email originalEmail) {
        Email forwardEmail = new Email();
        forwardEmail.setEmailTitle("Fwd: " + originalEmail.getEmailTitle());
        forwardEmail.setEmailContent("\n\n--- Forwarded Message ---\n" + originalEmail.getEmailContent());
        return forwardEmail;
    }

    @Override
    public int getUnreadCount(int employeeNo) {
        return dao.getUnreadCount(employeeNo, sqlSession);
    }

    @Override
    @Transactional
    public void markEmailAsRead(int emailNo, int employeeNo) {
        dao.updateEmailReadStatus(emailNo, employeeNo, sqlSession);
    }

    @Override
    @Transactional
    public boolean toggleImportantEmail(int emailNo, int employeeNo) {
        return dao.toggleImportantEmail(emailNo, employeeNo, sqlSession);
    }


}