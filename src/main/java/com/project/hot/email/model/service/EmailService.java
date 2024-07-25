package com.project.hot.email.model.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.project.hot.email.model.dto.Email;
import com.project.hot.employee.model.dto.Employee;

public interface EmailService {

    // 받은 메일함
    List<Email> getInboxEmails(int employeeNo);

    // 휴지통
    List<Email> getTrashEmails(int employeeNo);

    // 이메일 상세 조회
    Email getEmailByNo(int emailNo);

    // 직원 ID로 직원 정보 조회
    Employee findEmployeeByEmployeeId(String employeeId);

    // 직원 검색
    List<Employee> searchEmployees(String keyword);

    // 이메일을 휴지통으로 이동
    int moveEmailsToTrash(List<Integer> emailNos, int employeeNo);

    // 이메일 저장 (SMTP 전송 대신 DB에 저장)
    void saveEmail(Email email, MultipartFile[] attachments) throws IOException;

    // 보낸 메일함 조회 (필요한 경우)
    List<Email> getSentEmails(int employeeNo);

    // 이메일 삭제 (필요한 경우)
    void deleteEmails(List<Integer> emailNos);

    // 첨부 파일 다운로드 (필요한 경우)
    byte[] downloadAttachment(int attachmentId) throws IOException;
}