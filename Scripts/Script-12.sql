UPDATE APPROVER SET APPROVER_DATE=SYSDATE WHERE EMPLOYEE_NO=1005 AND APPROVAL_NO='3-2024-0802-035';
COMMIT;

SELECT * FROM APPROVAL WHERE APPROVAL_NO='5-2024-0801-018';
SELECT * FROM APPROVER WHERE APPROVAL_NO='3-2024-0731-017';

UPDATE APPROVAL SET APPROVAL_STATUS=3 WHERE APPROVAL_NO='3-2024-0731-017';