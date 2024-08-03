package com.project.hot.email.model.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmailServiceImpl implements EmailService {

    private final String fileUploadDir;
    private final EmailDao dao;
    private final SqlSession sqlSession;

    @Value("${image.upload.path}")
    private String fileUploadPath;

    @PostConstruct
    public void init() {
        File uploadDir = new File(fileUploadPath);
        if (!uploadDir.exists()) {
            if (uploadDir.mkdirs()) {
                log.info("Upload directory created: {}", uploadDir.getAbsolutePath());
            } else {
                log.error("Failed to create upload directory: {}", uploadDir.getAbsolutePath());
            }
        }
        log.info("Upload directory: {}", uploadDir.getAbsolutePath());
    }

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
    public Map<String, Object> getInboxEmails(int employeeNo, int page, int size) {
        int offset = (page - 1) * size;
        List<Email> emails = dao.selectInboxEmails(employeeNo, offset, size, sqlSession);
        int totalEmails = dao.countInboxEmails(employeeNo, sqlSession);
        return createPaginatedResult(emails, page, size, totalEmails);
    }

    @Override
    public Map<String, Object> getTrashEmails(int employeeNo, int page, int size) {
        int offset = (page - 1) * size;
        List<Email> emails = dao.selectTrashEmails(employeeNo, offset, size, sqlSession);
        int totalEmails = dao.countTrashEmails(employeeNo, sqlSession);
        return createPaginatedResult(emails, page, size, totalEmails);
    }

    @Override
    public Map<String, Object> getSentEmails(int employeeNo, int page, int size) {
        int offset = (page - 1) * size;
        List<Email> emails = dao.selectSentEmails(employeeNo, offset, size, sqlSession);
        int totalEmails = dao.countSentEmails(employeeNo, sqlSession);
        return createPaginatedResult(emails, page, size, totalEmails);
    }

    @Override
    public Map<String, Object> getImportantEmails(int employeeNo, int page, int size) {
        int offset = (page - 1) * size;
        List<Email> emails = dao.selectImportantEmails(employeeNo, offset, size, sqlSession);
        int totalEmails = dao.countImportantEmails(employeeNo, sqlSession);
        return createPaginatedResult(emails, page, size, totalEmails);
    }

    @Override
    public Map<String, Object> getSelfEmails(int employeeNo, int page, int size) {
        int offset = (page - 1) * size;
        List<Email> emails = dao.selectSelfEmails(employeeNo, offset, size, sqlSession);
        int totalEmails = dao.countSelfEmails(employeeNo, sqlSession);
        return createPaginatedResult(emails, page, size, totalEmails);
    }

    private Map<String, Object> createPaginatedResult(List<Email> emails, int page, int size, int totalEmails) {
        Map<String, Object> result = new HashMap<>();
        result.put("emails", emails);
        result.put("currentPage", page);
        result.put("totalPages", (int) Math.ceil((double) totalEmails / size));
        result.put("totalEmails", totalEmails);
        return result;
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
    public void saveEmail(Email email, MultipartFile[] attachments) throws IOException {
        try {
            boolean hasAttachment = attachments != null && attachments.length > 0;
            email.setHasAttachment(hasAttachment);

            int emailNo = dao.saveEmail(email, sqlSession);
            email.setEmailNo(emailNo);

            for (EmailReceiver receiver : email.getReceivers()) {
                receiver.setEmailNo(emailNo);
                receiver.setEmailReceiverIsRead("N");
                receiver.setEmailReceiverIsDelete("N");
                receiver.setEmailReceiverIsImportant("N");
                dao.saveEmailReceiver(receiver, sqlSession);
            }

            if (hasAttachment) {
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
        Path filePath = Paths.get(fileUploadPath, attachment.getEmailAttRenamedFilename());
        return Files.readAllBytes(filePath);
    }

    @Override
    public EmailAtt saveImage(MultipartFile file) throws IOException {
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String savedFilename = UUID.randomUUID().toString() + extension;

        Path destPath = Paths.get(fileUploadPath, savedFilename);

        try {
            Files.copy(file.getInputStream(), destPath, StandardCopyOption.REPLACE_EXISTING);
            log.info("File saved successfully: {}", destPath.toString());
        } catch (IOException e) {
            log.error("Failed to save file: {}", destPath.toString(), e);
            throw new IOException("Failed to save file: " + destPath.toString(), e);
        }

        EmailAtt emailAtt = EmailAtt.builder()
                .emailAttOriginalFilename(originalFilename)
                .emailAttRenamedFilename(savedFilename)
                .build();

        return emailAtt;
    }

    @Override
    public Map<String, Object> searchEmails(int employeeNo, String keyword, int page, int size) {
        int offset = (page - 1) * size;
        List<Email> emails = dao.searchEmails(employeeNo, keyword, offset, size, sqlSession);
        int totalEmails = dao.countSearchEmails(employeeNo, keyword, sqlSession);
        return createPaginatedResult(emails, page, size, totalEmails);
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

    @Override
    public int markTrashAsRead(List<Integer> emailNos) {
        return dao.markTrashAsRead(emailNos, sqlSession);
    }

    @Override
    @Transactional
    public int deletePermanently(List<Integer> emailNos, int employeeNo) {
        int deletedCount = dao.deletePermanently(emailNos, employeeNo, sqlSession);
        if (deletedCount > 0) {
            deleteAttachments(emailNos);
        }
        return deletedCount;
    }

    private void deleteAttachments(List<Integer> emailNos) {
        for (Integer emailNo : emailNos) {
            List<EmailAtt> attachments = dao.getEmailAttachments(emailNo, sqlSession);
            if (attachments != null) {
                for (EmailAtt attachment : attachments) {
                    if (attachment != null && attachment.getEmailAttRenamedFilename() != null) {
                        File file = new File(fileUploadDir, attachment.getEmailAttRenamedFilename());
                        if (file.exists()) {
                            file.delete();
                        }
                    }
                }
                dao.deleteAttachments(emailNo, sqlSession);
            }
        }
    }
    @Override
    @Transactional
    public int restoreFromTrash(List<Integer> emailNos, int employeeNo) {
        return dao.restoreFromTrash(emailNos, employeeNo, sqlSession);
    }

    @Override
    public EmailAtt getAttachment(int attachmentId) {
        return dao.getAttachmentById(attachmentId, sqlSession);
    }

    @Override
    public List<EmailAtt> getEmailAttachments(int emailNo) {
        return dao.getEmailAttachments(emailNo, sqlSession);
    }

    @Override
    public Integer getInboxUnreadCount(int employeeNo) {
        return dao.getInboxUnreadCount(employeeNo, sqlSession);
    }

    @Override
    public Integer getSelfUnreadCount(int employeeNo) {
        return dao.getSelfUnreadCount(employeeNo, sqlSession);
    }

    @Override
    public Integer getImportantUnreadCount(int employeeNo) {
        return dao.getImportantUnreadCount(employeeNo, sqlSession);
    }

    @Override
    public Integer getTrashCount(int employeeNo) {
        return dao.getTrashCount(employeeNo, sqlSession);
    }

    // 추가적인 유틸리티 메서드

    private void ensureDirectoryExists(String path) {
        File directory = new File(path);
        if (!directory.exists()) {
            if (directory.mkdirs()) {
                log.info("Directory created: {}", path);
            } else {
                log.error("Failed to create directory: {}", path);
            }
        }
    }

    private String generateUniqueFilename(String originalFilename) {
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        return UUID.randomUUID().toString() + extension;
    }

    // 페이징 관련 유틸리티 메서드
    private int calculateTotalPages(int totalItems, int pageSize) {
        return (int) Math.ceil((double) totalItems / pageSize);
    }

    private int calculateOffset(int page, int size) {
        return (page - 1) * size;
    }

    // 에러 처리 메서드
    private void handleDatabaseError(Exception e, String operation) {
        log.error("Database error during {}: {}", operation, e.getMessage());
        throw new RuntimeException("Database operation failed: " + operation, e);
    }

    private void handleFileOperationError(Exception e, String operation, String filename) {
        log.error("File operation error during {} for file {}: {}", operation, filename, e.getMessage());
        throw new RuntimeException("File operation failed: " + operation, e);
    }

    // 추가적인 비즈니스 로직 메서드
    public void updateEmailContent(int emailNo, String newContent) {
        try {
            dao.updateEmailContent(emailNo, newContent, sqlSession);
        } catch (Exception e) {
            handleDatabaseError(e, "updating email content");
        }
    }

    public void updateEmailTitle(int emailNo, String newTitle) {
        try {
            dao.updateEmailTitle(emailNo, newTitle, sqlSession);
        } catch (Exception e) {
            handleDatabaseError(e, "updating email title");
        }
    }

    @Transactional
    public void moveEmailToFolder(int emailNo, int folderId, int employeeNo) {
        try {
            dao.moveEmailToFolder(emailNo, folderId, employeeNo, sqlSession);
        } catch (Exception e) {
            handleDatabaseError(e, "moving email to folder");
        }
    }

    public List<Map<String, Object>> getEmailStatistics(int employeeNo) {
        try {
            return dao.getEmailStatistics(employeeNo, sqlSession);
        } catch (Exception e) {
            handleDatabaseError(e, "fetching email statistics");
            return null;
        }
    }

    @Transactional
    public void batchUpdateEmails(List<Email> emails) {
        try {
            for (Email email : emails) {
                dao.updateEmail(email, sqlSession);
            }
        } catch (Exception e) {
            handleDatabaseError(e, "batch updating emails");
        }
    }

    public List<Email> getRecentEmails(int employeeNo, int limit) {
        try {
            return dao.getRecentEmails(employeeNo, limit, sqlSession);
        } catch (Exception e) {
            handleDatabaseError(e, "fetching recent emails");
            return null;
        }
    }

    @Override
    public List<Email> getRecentInboxEmails(int employeeNo, int limit) {
        return dao.selectRecentInboxEmails(employeeNo, limit, sqlSession);
    }

}