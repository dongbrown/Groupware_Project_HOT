package com.project.hot.email.model.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.hot.email.model.dao.EmailDao;
import com.project.hot.email.model.dto.Email;
import com.project.hot.email.model.dto.EmailAtt;
import com.project.hot.email.model.dto.EmailReceiver;
import com.project.hot.employee.model.dto.Employee;

import jakarta.mail.Authenticator;
import jakarta.mail.BodyPart;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.internet.MimeUtility;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmailServiceImpl implements EmailService {

    private static final Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);

    @Autowired
    private EmailDao dao;


    @Autowired
    private SqlSession sqlSession;

    @Autowired
    private Environment env;

    @Value("${mail.username}")
    private String username;

    @Value("${mail.password}")
    private String password;

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
    public void sendEmail(Email email, MultipartFile[] attachments, String senderEmail) throws MessagingException, IOException {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", env.getProperty("mail.smtp.auth"));
            props.put("mail.smtp.starttls.enable", env.getProperty("mail.smtp.starttls.enable"));
            props.put("mail.smtp.host", env.getProperty("mail.smtp.host"));
            props.put("mail.smtp.port", env.getProperty("mail.smtp.port"));

            Session mailSession = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            Message message = createMessage(email, attachments, senderEmail, mailSession);
            Transport.send(message);

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
            logger.error("이메일 전송 실패", e);
            throw e;
        }
    }

    private Message createMessage(Email email, MultipartFile[] attachments, String senderEmail, Session mailSession)
            throws MessagingException, IOException {
        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(senderEmail));

        for (EmailReceiver receiver : email.getReceivers()) {
            String receiverEmail = receiver.getEmployee().getEmployeeId() + "@hot.com";
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiverEmail));
        }

        message.setSubject(email.getEmailTitle());

        Multipart multipart = new MimeMultipart();

        BodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(email.getEmailContent(), "text/html; charset=UTF-8");
        multipart.addBodyPart(messageBodyPart);

        if (attachments != null) {
            for (MultipartFile attachment : attachments) {
                if (attachment != null && !attachment.isEmpty()) {
                    MimeBodyPart attachmentPart = new MimeBodyPart();
                    attachmentPart.attachFile(convertMultipartFileToFile(attachment));
                    attachmentPart.setFileName(MimeUtility.encodeText(attachment.getOriginalFilename()));
                    multipart.addBodyPart(attachmentPart);
                }
            }
        }

        message.setContent(multipart);
        return message;
    }

    @Override
    public String uploadImage(MultipartFile file) {
        try {
            String uploadDir = env.getProperty("image.upload.directory", "uploads/images");
            Path uploadPath = Paths.get(uploadDir).toAbsolutePath().normalize();

            Files.createDirectories(uploadPath);

            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            Path targetLocation = uploadPath.resolve(fileName);

            Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);

            logger.info("Image uploaded successfully. File path: {}", targetLocation);

            String urlPath = env.getProperty("image.url.path", "/images/");
            String fileUrl = urlPath + fileName;

            logger.info("Image URL: {}", fileUrl);

            return fileUrl;
        } catch (IOException ex) {
            logger.error("Image upload failed", ex);
            throw new RuntimeException("Failed to upload image: " + ex.getMessage(), ex);
        }
    }

    private File convertMultipartFileToFile(MultipartFile file) throws IOException {
        File convFile = new File(System.getProperty("java.io.tmpdir") + "/" + file.getOriginalFilename());
        file.transferTo(convFile);
        return convFile;
    }

    private String saveAttachmentFile(MultipartFile file) throws IOException {
        String uploadDir = env.getProperty("attachment.upload.directory", "uploads/attachments");
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String newFileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        File dest = new File(dir, newFileName);
        file.transferTo(dest);

        return newFileName;
    }

    @Override
    public List<Employee> searchEmployees(String keyword) {
        log.debug("Searching employees with keyword: {}", keyword);
        List<Employee> employees = dao.searchEmployees(keyword, sqlSession);
        if (employees == null) {
            log.warn("Search returned null for keyword: {}", keyword);
            employees = new ArrayList<>();
        }
        log.debug("Found employees: {}", employees);
        return employees;
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

}