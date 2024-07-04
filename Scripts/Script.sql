COMMIT;

ALTER TABLE EMPLOYEE
MODIFY (
    DEPARTMENT_CODE NUMBER,
    POSITION_CODE NUMBER
);

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM "POSITION" p;
UPDATE employee SET employee_photo='r1.jpg' WHERE employee_no=1000;
UPDATE EMPLOYEE SET employee_password='$2a$12$Y6n2GdbGFWlX4rAn9ZMyFOsVTRSeteZu2eYUjqVaoEBhTx1vSuEzK';
DELETE FROM EMPLOYEE;
INSERT INTO DEPARTMENT (DEPARTMENT_CODE, DEPARTMENT_HIGH_CODE, DEPARTMENT_TITLE, DEPARTMENT_AUTHORITY)
VALUES (SEQ_DEPARTMENT.NEXTVAL, 3, '개발2팀', 1);

INSERT INTO DEPARTMENT (DEPARTMENT_CODE, DEPARTMENT_HIGH_CODE, DEPARTMENT_TITLE, DEPARTMENT_AUTHORITY)
VALUES (SEQ_DEPARTMENT.NEXTVAL, 3, '개발3팀', 1);

INSERT INTO DEPARTMENT (DEPARTMENT_CODE, DEPARTMENT_HIGH_CODE, DEPARTMENT_TITLE, DEPARTMENT_AUTHORITY)
VALUES (SEQ_DEPARTMENT.NEXTVAL, 5, '홍보1팀', 1);

INSERT INTO DEPARTMENT (DEPARTMENT_CODE, DEPARTMENT_HIGH_CODE, DEPARTMENT_TITLE, DEPARTMENT_AUTHORITY)
VALUES (SEQ_DEPARTMENT.NEXTVAL, 4, '디자인1팀', 1);

INSERT INTO DEPARTMENT (DEPARTMENT_CODE, DEPARTMENT_HIGH_CODE, DEPARTMENT_TITLE, DEPARTMENT_AUTHORITY)
VALUES (SEQ_DEPARTMENT.NEXTVAL, 2, '인사1팀', 10);



----------------------
-- 인사1팀 (10명)
INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES
(SEQ_EMPLOYEE.NEXTVAL, 2, 2, '김인사', '010-1111-0001', 'pass001', 'hr001', '서울시 강남구', TO_DATE('1980-01-01', 'YYYY-MM-DD'), '800101-1234567', TO_DATE('2010-03-01', 'YYYY-MM-DD'), 6000000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 2, 3, '이인사', '010-1111-0002', 'pass002', 'hr002', '서울시 서초구', TO_DATE('1985-02-15', 'YYYY-MM-DD'), '850215-2345678', TO_DATE('2012-04-01', 'YYYY-MM-DD'), 5500000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 2, 4, '박인사', '010-1111-0003', 'pass003', 'hr003', '경기도 성남시', TO_DATE('1988-05-20', 'YYYY-MM-DD'), '880520-1456789', TO_DATE('2015-09-01', 'YYYY-MM-DD'), 5000000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 2, 5, '최인사', '010-1111-0004', 'pass004', 'hr004', '서울시 송파구', TO_DATE('1990-11-30', 'YYYY-MM-DD'), '901130-2567890', TO_DATE('2018-03-15', 'YYYY-MM-DD'), 4500000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 2, 6, '정인사', '010-1111-0005', 'pass005', 'hr005', '경기도 수원시', TO_DATE('1993-07-07', 'YYYY-MM-DD'), '930707-1678901', TO_DATE('2020-08-01', 'YYYY-MM-DD'), 3500000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 2, 6, '강인사', '010-1111-0006', 'pass006', 'hr006', '서울시 마포구', TO_DATE('1995-09-25', 'YYYY-MM-DD'), '950925-2789012', TO_DATE('2021-02-15', 'YYYY-MM-DD'), 3500000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 2, 6, '조인사', '010-1111-0007', 'pass007', 'hr007', '경기도 고양시', TO_DATE('1992-12-10', 'YYYY-MM-DD'), '921210-1890123', TO_DATE('2019-11-01', 'YYYY-MM-DD'), 3700000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 2, 6, '윤인사', '010-1111-0008', 'pass008', 'hr008', '서울시 영등포구', TO_DATE('1994-03-18', 'YYYY-MM-DD'), '940318-2901234', TO_DATE('2020-06-01', 'YYYY-MM-DD'), 3600000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 2, 6, '장인사', '010-1111-0009', 'pass009', 'hr009', '경기도 용인시', TO_DATE('1996-08-05', 'YYYY-MM-DD'), '960805-1012345', TO_DATE('2022-01-10', 'YYYY-MM-DD'), 3400000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 2, 6, '임인사', '010-1111-0010', 'pass010', 'hr010', '서울시 강서구', TO_DATE('1997-06-20', 'YYYY-MM-DD'), '970620-2123456', TO_DATE('2023-03-01', 'YYYY-MM-DD'), 3300000, NULL, NULL, 15);

-- 디자인1팀 (10명)
INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES
(SEQ_EMPLOYEE.NEXTVAL, 4, 2, '김디자인', '010-2222-0001', 'pass011', 'design001', '서울시 강남구', TO_DATE('1982-03-15', 'YYYY-MM-DD'), '820315-1234567', TO_DATE('2011-05-01', 'YYYY-MM-DD'), 5800000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 4, 3, '이디자인', '010-2222-0002', 'pass012', 'design002', '서울시 서초구', TO_DATE('1986-06-20', 'YYYY-MM-DD'), '860620-2345678', TO_DATE('2013-07-01', 'YYYY-MM-DD'), 5300000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 4, 4, '박디자인', '010-2222-0003', 'pass013', 'design003', '경기도 성남시', TO_DATE('1989-09-10', 'YYYY-MM-DD'), '890910-1456789', TO_DATE('2016-02-15', 'YYYY-MM-DD'), 4800000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 4, 5, '최디자인', '010-2222-0004', 'pass014', 'design004', '서울시 송파구', TO_DATE('1991-12-05', 'YYYY-MM-DD'), '911205-2567890', TO_DATE('2018-09-01', 'YYYY-MM-DD'), 4300000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 4, 6, '정디자인', '010-2222-0005', 'pass015', 'design005', '경기도 수원시', TO_DATE('1994-02-28', 'YYYY-MM-DD'), '940228-1678901', TO_DATE('2020-11-15', 'YYYY-MM-DD'), 3600000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 4, 6, '강디자인', '010-2222-0006', 'pass016', 'design006', '서울시 마포구', TO_DATE('1995-05-17', 'YYYY-MM-DD'), '950517-2789012', TO_DATE('2021-06-01', 'YYYY-MM-DD'), 3500000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 4, 6, '조디자인', '010-2222-0007', 'pass017', 'design007', '경기도 고양시', TO_DATE('1993-08-22', 'YYYY-MM-DD'), '930822-1890123', TO_DATE('2020-03-10', 'YYYY-MM-DD'), 3700000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 4, 6, '윤디자인', '010-2222-0008', 'pass018', 'design008', '서울시 영등포구', TO_DATE('1996-11-11', 'YYYY-MM-DD'), '961111-2901234', TO_DATE('2022-01-05', 'YYYY-MM-DD'), 3400000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 4, 6, '장디자인', '010-2222-0009', 'pass019', 'design009', '경기도 용인시', TO_DATE('1997-04-30', 'YYYY-MM-DD'), '970430-1012345', TO_DATE('2022-10-20', 'YYYY-MM-DD'), 3300000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 4, 6, '임디자인', '010-2222-0010', 'pass020', 'design010', '서울시 강서구', TO_DATE('1998-01-10', 'YYYY-MM-DD'), '980110-2123456', TO_DATE('2023-04-01', 'YYYY-MM-DD'), 3300000, NULL, NULL, 15);

-- 홍보1팀 (10명)
INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES
(SEQ_EMPLOYEE.NEXTVAL, 5, 2, '김홍보', '010-3333-0001', 'pass021', 'pr001', '서울시 강남구', TO_DATE('1981-07-20', 'YYYY-MM-DD'), '810720-1234567', TO_DATE('2010-08-01', 'YYYY-MM-DD'), 5900000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 5, 3, '이홍보', '010-3333-0002', 'pass022', 'pr002', '서울시 서초구', TO_DATE('1984-10-15', 'YYYY-MM-DD'), '841015-2345678', TO_DATE('2012-09-01', 'YYYY-MM-DD'), 5400000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 5, 4, '박홍보', '010-3333-0003', 'pass023', 'pr003', '경기도 성남시', TO_DATE('1987-03-25', 'YYYY-MM-DD'), '870325-1456789', TO_DATE('2015-01-15', 'YYYY-MM-DD'), 4900000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 5, 5, '최홍보', '010-3333-0004', 'pass024', 'pr004', '서울시 송파구', TO_DATE('1990-06-30', 'YYYY-MM-DD'), '900630-2567890', TO_DATE('2017-07-01', 'YYYY-MM-DD'), 4400000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 5, 6, '정홍보', '010-3333-0005', 'pass025', 'pr005', '경기도 수원시', TO_DATE('1993-09-12', 'YYYY-MM-DD'), '930912-1678901', TO_DATE('2020-02-15', 'YYYY-MM-DD'), 3700000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 5, 6, '강홍보', '010-3333-0006', 'pass026', 'pr006', '서울시 마포구', TO_DATE('1995-12-08', 'YYYY-MM-DD'), '951208-2789012', TO_DATE('2021-05-01', 'YYYY-MM-DD'), 3600000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 5, 6, '조홍보', '010-3333-0007', 'pass027', 'pr007', '경기도 고양시', TO_DATE('1992-02-14', 'YYYY-MM-DD'), '920214-1890123', TO_DATE('2019-10-10', 'YYYY-MM-DD'), 3800000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 5, 6, '윤홍보', '010-3333-0008', 'pass028', 'pr008', '서울시 영등포구', TO_DATE('1994-05-19', 'YYYY-MM-DD'), '940519-2901234', TO_DATE('2020-12-01', 'YYYY-MM-DD'), 3650000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 5, 6, '장홍보', '010-3333-0009', 'pass029', 'pr009', '경기도 용인시', TO_DATE('1996-08-23', 'YYYY-MM-DD'), '960823-1012345', TO_DATE('2022-03-15', 'YYYY-MM-DD'), 3450000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 5, 6, '임홍보', '010-3333-0010', 'pass030', 'pr010', '서울시 강서구', TO_DATE('1997-11-05', 'YYYY-MM-DD'), '971105-2123456', TO_DATE('2023-02-15', 'YYYY-MM-DD'), 3350000, NULL, NULL, 15);

-- 개발3팀 (10명)
INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES
(SEQ_EMPLOYEE.NEXTVAL, 3, 2, '김개발3', '010-4444-0001', 'pass031', 'dev301', '서울시 강남구', TO_DATE('1983-09-10', 'YYYY-MM-DD'), '830910-1234567', TO_DATE('2012-01-01', 'YYYY-MM-DD'), 6100000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 3, '이개발3', '010-4444-0002', 'pass032', 'dev302', '서울시 서초구', TO_DATE('1986-12-05', 'YYYY-MM-DD'), '861205-2345678', TO_DATE('2014-03-15', 'YYYY-MM-DD'), 5600000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 4, '박개발3', '010-4444-0003', 'pass033', 'dev303', '경기도 성남시', TO_DATE('1989-03-20', 'YYYY-MM-DD'), '890320-1456789', TO_DATE('2016-07-01', 'YYYY-MM-DD'), 5100000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 5, '최개발3', '010-4444-0004', 'pass034', 'dev304', '서울시 송파구', TO_DATE('1991-06-15', 'YYYY-MM-DD'), '910615-2567890', TO_DATE('2018-11-01', 'YYYY-MM-DD'), 4600000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '정개발3', '010-4444-0005', 'pass035', 'dev305', '경기도 수원시', TO_DATE('1994-09-30', 'YYYY-MM-DD'), '940930-1678901', TO_DATE('2021-01-15', 'YYYY-MM-DD'), 3800000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '강개발3', '010-4444-0006', 'pass036', 'dev306', '서울시 마포구', TO_DATE('1995-11-22', 'YYYY-MM-DD'), '951122-2789012', TO_DATE('2021-08-01', 'YYYY-MM-DD'), 3700000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '조개발3', '010-4444-0007', 'pass037', 'dev307', '경기도 고양시', TO_DATE('1993-02-14', 'YYYY-MM-DD'), '930214-1890123', TO_DATE('2020-05-01', 'YYYY-MM-DD'), 3900000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '윤개발3', '010-4444-0008', 'pass038', 'dev308', '서울시 영등포구', TO_DATE('1996-07-19', 'YYYY-MM-DD'), '960719-2901234', TO_DATE('2022-03-01', 'YYYY-MM-DD'), 3600000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '장개발3', '010-4444-0009', 'pass039', 'dev309', '경기도 용인시', TO_DATE('1997-10-08', 'YYYY-MM-DD'), '971008-1012345', TO_DATE('2022-11-15', 'YYYY-MM-DD'), 3500000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '임개발3', '010-4444-0010', 'pass040', 'dev310', '서울시 강서구', TO_DATE('1996-04-25', 'YYYY-MM-DD'), '960425-2123456', TO_DATE('2022-09-01', 'YYYY-MM-DD'), 3400000, NULL, NULL, 15);

-- 개발2팀 (10명)
INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES
(SEQ_EMPLOYEE.NEXTVAL, 3, 2, '김개발2', '010-5555-0001', 'pass041', 'dev201', '서울시 강남구', TO_DATE('1984-11-05', 'YYYY-MM-DD'), '841105-1234567', TO_DATE('2013-03-01', 'YYYY-MM-DD'), 6000000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 3, '이개발2', '010-5555-0002', 'pass042', 'dev202', '서울시 서초구', TO_DATE('1987-02-20', 'YYYY-MM-DD'), '870220-2345678', TO_DATE('2015-05-15', 'YYYY-MM-DD'), 5500000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 4, '박개발2', '010-5555-0003', 'pass043', 'dev203', '경기도 성남시', TO_DATE('1990-05-10', 'YYYY-MM-DD'), '900510-1456789', TO_DATE('2017-09-01', 'YYYY-MM-DD'), 5000000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 5, '최개발2', '010-5555-0004', 'pass044', 'dev204', '서울시 송파구', TO_DATE('1992-08-15', 'YYYY-MM-DD'), '920815-2567890', TO_DATE('2019-12-01', 'YYYY-MM-DD'), 4500000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '정개발2', '010-5555-0005', 'pass045', 'dev205', '경기도 수원시', TO_DATE('1994-11-30', 'YYYY-MM-DD'), '941130-1678901', TO_DATE('2021-03-15', 'YYYY-MM-DD'), 3900000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '강개발2', '010-5555-0006', 'pass046', 'dev206', '서울시 마포구', TO_DATE('1996-01-25', 'YYYY-MM-DD'), '960125-2789012', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 3800000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '조개발2', '010-5555-0007', 'pass047', 'dev207', '경기도 고양시', TO_DATE('1993-06-10', 'YYYY-MM-DD'), '930610-1890123', TO_DATE('2020-08-15', 'YYYY-MM-DD'), 4000000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '윤개발2', '010-5555-0008', 'pass048', 'dev208', '서울시 영등포구', TO_DATE('1997-09-05', 'YYYY-MM-DD'), '970905-2901234', TO_DATE('2022-05-01', 'YYYY-MM-DD'), 3700000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '장개발2', '010-5555-0009', 'pass049', 'dev209', '경기도 용인시', TO_DATE('1998-12-20', 'YYYY-MM-DD'), '981220-1012345', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 3600000, NULL, NULL, 15),
(SEQ_EMPLOYEE.NEXTVAL, 3, 6, '임개발2', '010-5555-0010', 'pass050', 'dev210', '서울시 강서구', TO_DATE('1995-02-15', 'YYYY-MM-DD'), '950215-2123456', TO_DATE('2022-07-15', 'YYYY-MM-DD'), 3450000, NULL, NULL, 15);


INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 4, 2, '김디자인', '010-2222-0001', 'pass011', 'design001', '서울시 강남구', TO_DATE('1982-03-15', 'YYYY-MM-DD'), '820315-1234567', TO_DATE('2011-05-01', 'YYYY-MM-DD'), 5800000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 4, 3, '이디자인', '010-2222-0002', 'pass012', 'design002', '서울시 서초구', TO_DATE('1986-06-20', 'YYYY-MM-DD'), '860620-2345678', TO_DATE('2013-07-01', 'YYYY-MM-DD'), 5300000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 4, 4, '박디자인', '010-2222-0003', 'pass013', 'design003', '경기도 성남시', TO_DATE('1989-09-10', 'YYYY-MM-DD'), '890910-1456789', TO_DATE('2016-02-15', 'YYYY-MM-DD'), 4800000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 4, 5, '최디자인', '010-2222-0004', 'pass014', 'design004', '서울시 송파구', TO_DATE('1991-11-30', 'YYYY-MM-DD'), '911130-2567890', TO_DATE('2019-05-01', 'YYYY-MM-DD'), 4300000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 4, 6, '정디자인', '010-2222-0005', 'pass015', 'design005', '경기도 수원시', TO_DATE('1994-12-01', 'YYYY-MM-DD'), '941201-1678901', TO_DATE('2021-08-01', 'YYYY-MM-DD'), 3800000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 4, 6, '강디자인', '010-2222-0006', 'pass016', 'design006', '서울시 마포구', TO_DATE('1996-02-25', 'YYYY-MM-DD'), '960225-2789012', TO_DATE('2022-09-15', 'YYYY-MM-DD'), 3700000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 4, 6, '조디자인', '010-2222-0007', 'pass017', 'design007', '경기도 고양시', TO_DATE('1993-10-10', 'YYYY-MM-DD'), '931010-1890123', TO_DATE('2020-12-01', 'YYYY-MM-DD'), 3900000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 4, 6, '윤디자인', '010-2222-0008', 'pass018', 'design008', '서울시 영등포구', TO_DATE('1995-03-28', 'YYYY-MM-DD'), '950328-2901234', TO_DATE('2021-06-01', 'YYYY-MM-DD'), 3800000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 4, 6, '장디자인', '010-2222-0009', 'pass019', 'design009', '경기도 용인시', TO_DATE('1997-05-25', 'YYYY-MM-DD'), '970525-1012345', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 3600000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 4, 6, '임디자인', '010-2222-0010', 'pass020', 'design010', '서울시 강서구', TO_DATE('1998-06-20', 'YYYY-MM-DD'), '980620-2123456', TO_DATE('2023-03-01', 'YYYY-MM-DD'), 3500000, NULL, NULL, 15);


INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 2, 2, '김인사', '010-1111-0001', 'pass001', 'hr001', '서울시 강남구', TO_DATE('1980-01-01', 'YYYY-MM-DD'), '800101-1234567', TO_DATE('2010-03-01', 'YYYY-MM-DD'), 6000000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 2, 3, '이인사', '010-1111-0002', 'pass002', 'hr002', '서울시 서초구', TO_DATE('1985-02-15', 'YYYY-MM-DD'), '850215-2345678', TO_DATE('2012-04-01', 'YYYY-MM-DD'), 5500000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 2, 4, '박인사', '010-1111-0003', 'pass003', 'hr003', '경기도 성남시', TO_DATE('1988-05-20', 'YYYY-MM-DD'), '880520-1456789', TO_DATE('2015-09-01', 'YYYY-MM-DD'), 5000000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 2, 5, '최인사', '010-1111-0004', 'pass004', 'hr004', '서울시 송파구', TO_DATE('1990-11-30', 'YYYY-MM-DD'), '901130-2567890', TO_DATE('2018-03-15', 'YYYY-MM-DD'), 4500000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 2, 6, '정인사', '010-1111-0005', 'pass005', 'hr005', '경기도 수원시', TO_DATE('1993-07-07', 'YYYY-MM-DD'), '930707-1678901', TO_DATE('2020-08-01', 'YYYY-MM-DD'), 3500000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 2, 6, '강인사', '010-1111-0006', 'pass006', 'hr006', '서울시 마포구', TO_DATE('1995-09-25', 'YYYY-MM-DD'), '950925-2789012', TO_DATE('2021-02-15', 'YYYY-MM-DD'), 3500000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 2, 6, '조인사', '010-1111-0007', 'pass007', 'hr007', '경기도 고양시', TO_DATE('1992-12-10', 'YYYY-MM-DD'), '921210-1890123', TO_DATE('2019-11-01', 'YYYY-MM-DD'), 3700000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 2, 6, '윤인사', '010-1111-0008', 'pass008', 'hr008', '서울시 영등포구', TO_DATE('1994-03-18', 'YYYY-MM-DD'), '940318-2901234', TO_DATE('2020-06-01', 'YYYY-MM-DD'), 3600000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 2, 6, '장인사', '010-1111-0009', 'pass009', 'hr009', '경기도 용인시', TO_DATE('1996-08-05', 'YYYY-MM-DD'), '960805-1012345', TO_DATE('2022-01-10', 'YYYY-MM-DD'), 3400000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 2, 6, '임인사', '010-1111-0010', 'pass010', 'hr010', '서울시 강서구', TO_DATE('1997-06-20', 'YYYY-MM-DD'), '970620-2123456', TO_DATE('2023-03-01', 'YYYY-MM-DD'), 3300000, NULL, NULL, 15);


INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 5, 2, '김홍보', '010-3333-0001', 'pass021', 'pr001', '서울시 강남구', TO_DATE('1981-07-20', 'YYYY-MM-DD'), '810720-1234567', TO_DATE('2010-08-01', 'YYYY-MM-DD'), 5900000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 5, 3, '이홍보', '010-3333-0002', 'pass022', 'pr002', '서울시 서초구', TO_DATE('1984-10-15', 'YYYY-MM-DD'), '841015-2345678', TO_DATE('2012-09-01', 'YYYY-MM-DD'), 5400000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 5, 4, '박홍보', '010-3333-0003', 'pass023', 'pr003', '경기도 성남시', TO_DATE('1987-03-25', 'YYYY-MM-DD'), '870325-1456789', TO_DATE('2015-01-15', 'YYYY-MM-DD'), 4900000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 5, 5, '최홍보', '010-3333-0004', 'pass024', 'pr004', '서울시 송파구', TO_DATE('1990-06-30', 'YYYY-MM-DD'), '900630-2567890', TO_DATE('2017-07-01', 'YYYY-MM-DD'), 4400000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 5, 6, '정홍보', '010-3333-0005', 'pass025', 'pr005', '경기도 수원시', TO_DATE('1993-09-12', 'YYYY-MM-DD'), '930912-1678901', TO_DATE('2020-02-15', 'YYYY-MM-DD'), 3700000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 5, 6, '강홍보', '010-3333-0006', 'pass026', 'pr006', '서울시 마포구', TO_DATE('1995-12-08', 'YYYY-MM-DD'), '951208-2789012', TO_DATE('2021-05-01', 'YYYY-MM-DD'), 3600000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 5, 6, '조홍보', '010-3333-0007', 'pass027', 'pr007', '경기도 고양시', TO_DATE('1992-02-14', 'YYYY-MM-DD'), '920214-1890123', TO_DATE('2019-10-10', 'YYYY-MM-DD'), 3800000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 5, 6, '윤홍보', '010-3333-0008', 'pass028', 'pr008', '서울시 영등포구', TO_DATE('1994-05-19', 'YYYY-MM-DD'), '940519-2901234', TO_DATE('2020-12-01', 'YYYY-MM-DD'), 3650000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 5, 6, '장홍보', '010-3333-0009', 'pass029', 'pr009', '경기도 용인시', TO_DATE('1996-08-23', 'YYYY-MM-DD'), '960823-1012345', TO_DATE('2022-03-15', 'YYYY-MM-DD'), 3450000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 5, 6, '임홍보', '010-3333-0010', 'pass030', 'pr010', '서울시 강서구', TO_DATE('1997-11-05', 'YYYY-MM-DD'), '971105-2123456', TO_DATE('2023-02-15', 'YYYY-MM-DD'), 3350000, NULL, NULL, 15);


INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 2, '김개발3', '010-4444-0001', 'pass031', 'dev301', '서울시 강남구', TO_DATE('1983-09-10', 'YYYY-MM-DD'), '830910-1234567', TO_DATE('2012-01-01', 'YYYY-MM-DD'), 6100000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 3, '이개발3', '010-4444-0002', 'pass032', 'dev302', '서울시 서초구', TO_DATE('1986-12-05', 'YYYY-MM-DD'), '861205-2345678', TO_DATE('2014-03-15', 'YYYY-MM-DD'), 5600000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 4, '박개발3', '010-4444-0003', 'pass033', 'dev303', '경기도 성남시', TO_DATE('1989-03-20', 'YYYY-MM-DD'), '890320-1456789', TO_DATE('2016-07-01', 'YYYY-MM-DD'), 5100000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 5, '최개발3', '010-4444-0004', 'pass034', 'dev304', '서울시 송파구', TO_DATE('1991-06-15', 'YYYY-MM-DD'), '910615-2567890', TO_DATE('2018-11-01', 'YYYY-MM-DD'), 4600000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '정개발3', '010-4444-0005', 'pass035', 'dev305', '경기도 수원시', TO_DATE('1994-09-30', 'YYYY-MM-DD'), '940930-1678901', TO_DATE('2021-01-15', 'YYYY-MM-DD'), 3800000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '강개발3', '010-4444-0006', 'pass036', 'dev306', '서울시 마포구', TO_DATE('1995-11-22', 'YYYY-MM-DD'), '951122-2789012', TO_DATE('2021-08-01', 'YYYY-MM-DD'), 3700000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '조개발3', '010-4444-0007', 'pass037', 'dev307', '경기도 고양시', TO_DATE('1993-02-14', 'YYYY-MM-DD'), '930214-1890123', TO_DATE('2020-05-01', 'YYYY-MM-DD'), 3900000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '윤개발3', '010-4444-0008', 'pass038', 'dev308', '서울시 영등포구', TO_DATE('1996-07-19', 'YYYY-MM-DD'), '960719-2901234', TO_DATE('2022-03-01', 'YYYY-MM-DD'), 3600000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '장개발3', '010-4444-0009', 'pass039', 'dev309', '경기도 용인시', TO_DATE('1997-10-08', 'YYYY-MM-DD'), '971008-1012345', TO_DATE('2022-11-15', 'YYYY-MM-DD'), 3500000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '임개발3', '010-4444-0010', 'pass040', 'dev310', '서울시 강서구', TO_DATE('1996-04-25', 'YYYY-MM-DD'), '960425-2123456', TO_DATE('2022-09-01', 'YYYY-MM-DD'), 3400000, NULL, NULL, 15);


INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 2, '김개발2', '010-5555-0001', 'pass041', 'dev201', '서울시 강남구', TO_DATE('1984-11-05', 'YYYY-MM-DD'), '841105-1234567', TO_DATE('2013-03-01', 'YYYY-MM-DD'), 6000000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 3, '이개발2', '010-5555-0002', 'pass042', 'dev202', '서울시 서초구', TO_DATE('1987-02-20', 'YYYY-MM-DD'), '870220-2345678', TO_DATE('2015-05-15', 'YYYY-MM-DD'), 5500000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 4, '박개발2', '010-5555-0003', 'pass043', 'dev203', '경기도 성남시', TO_DATE('1990-05-10', 'YYYY-MM-DD'), '900510-1456789', TO_DATE('2017-09-01', 'YYYY-MM-DD'), 5000000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 5, '최개발2', '010-5555-0004', 'pass044', 'dev204', '서울시 송파구', TO_DATE('1992-08-15', 'YYYY-MM-DD'), '920815-2567890', TO_DATE('2019-12-01', 'YYYY-MM-DD'), 4500000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '정개발2', '010-5555-0005', 'pass045', 'dev205', '경기도 수원시', TO_DATE('1994-11-30', 'YYYY-MM-DD'), '941130-1678901', TO_DATE('2021-03-15', 'YYYY-MM-DD'), 3900000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '강개발2', '010-5555-0006', 'pass046', 'dev206', '서울시 마포구', TO_DATE('1996-01-25', 'YYYY-MM-DD'), '960125-2789012', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 3800000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '조개발2', '010-5555-0007', 'pass047', 'dev207', '경기도 고양시', TO_DATE('1993-06-10', 'YYYY-MM-DD'), '930610-1890123', TO_DATE('2020-08-15', 'YYYY-MM-DD'), 4000000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '윤개발2', '010-5555-0008', 'pass048', 'dev208', '서울시 영등포구', TO_DATE('1997-09-05', 'YYYY-MM-DD'), '970905-2901234', TO_DATE('2022-05-01', 'YYYY-MM-DD'), 3700000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '장개발2', '010-5555-0009', 'pass049', 'dev209', '경기도 용인시', TO_DATE('1998-12-20', 'YYYY-MM-DD'), '981220-1012345', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 3600000, NULL, NULL, 15);

INSERT INTO Employee (employeeNo, departmentCode, positionCode, employeeName, employeePhone, employeePassword, employeeId, employeeAddress, employeeBirthDay, employeeSsn, employeeHireDate, employeeSalary, employeePhoto, employeeResignationDay, employeeTotalVacation)
VALUES (SEQ_EMPLOYEE.NEXTVAL, 3, 6, '임개발2', '010-5555-0010', 'pass050', 'dev210', '서울시 강서구', TO_DATE('1995-02-15', 'YYYY-MM-DD'), '950215-2123456', TO_DATE('2022-07-15', 'YYYY-MM-DD'), 3450000, NULL, NULL, 15);
