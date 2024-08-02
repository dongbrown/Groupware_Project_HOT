SELECT * FROM COMMUTING
WHERE EMPLOYEE_NO = 1000;
AND COMMUTING_DATE = SYSDATE;

SELECT COMMUTING_DATE, COMMUTING_GO_WORK_TIME, COMMUTING_LEAVE_WORK_TIME, COMMUTING_STATUS, o.OVERTIME_HOURS
		FROM COMMUTING c
			JOIN APPROVAL a ON c.EMPLOYEE_NO = a.EMPLOYEE_NO
			JOIN OVERTIME_FORM o ON a.APPROVAL_NO = o.APPROVAL_NO
		WHERE EMPLOYEE_NO=1000
		  AND COMMUTING_DATE >= TO_DATE('2024' || '-' || '07' || '-01', 'YYYY-MM-DD')
          AND COMMUTING_DATE < TO_DATE('2024' || '-' || '07' || '-01', 'YYYY-MM-DD') + INTERVAL '1' MONTH
        ORDER BY COMMUTING_DATE DESC;

SELECT SUM(o.OVERTIME_HOURS) FROM approval a JOIN OVERTIME_FORM o ON a.APPROVAL_NO=o.APPROVAL_NO WHERE a.EMPLOYEE_NO=1000 AND a.APPROVAL_STATUS = 3;

SELECT *
FROM APPROVAL a
	JOIN VACATION_FORM vf ON a.APPROVAL_NO = vf.APPROVAL_NO
WHERE a.EMPLOYEE_NO=1000
	AND a.APPROVAL_STATUS = 3
	AND TRUNC(vf.VACATION_START) >= TO_DATE('2024' || '-' || '07' || '-01', 'YYYY-MM-DD')
    AND TRUNC(vf.VACATION_START) < TO_DATE('2024' || '-' || '07' || '-01', 'YYYY-MM-DD') + INTERVAL '1' MONTH
ORDER BY vf.VACATION_START DESC;