SELECT SUM(VACATION_DAY) 
FROM APPROVAL 
	JOIN VACATION_FORM USING (APPROVAL_NO)
WHERE EMPLOYEE_NO=1000 
AND APPROVAL_STATUS = 3 
AND TO_CHAR(VACATION_START, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY')
AND (VACATION_TYPE = '연차' OR VACATION_TYPE = '반차');

UPDATE approver SET APPROVER_STATUS = 1, APPROVER_DATE = SYSDATE WHERE APPROVER_LEVEL = 2;
UPDATE approval SET APPROVAL_STATUS = 3 WHERE APPROVAL_NO = '2-2024-0801-030';

SELECT * FROM APPROVAL a WHERE EMPLOYEE_NO = 1000;