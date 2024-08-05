SELECT	a.*
				, e.*
				, dept.*
				, att.*
				, ap.APPROVER_LEVEL AS APPROVER_APPROVER_LEVEL
				, ap.APPROVER_STATUS AS APPROVER_APPROVER_STATUS
				, ap.APPROVER_DATE AS APPROVER_APPROVER_DATE
				, ref_emp.EMPLOYEE_NO AS REFERENCE_EMPLOYEE_NO
				, ref_emp.EMPLOYEE_NAME AS REFERENCE_EMPLOYEE_NAME
				, ref_dept.DEPARTMENT_TITLE AS REFERENCE_DEPARTMENT_TITLE
				, approver.EMPLOYEE_NO AS APPROVER_EMPLOYEE_NO
				, approver.EMPLOYEE_NAME AS APPROVER_EMPLOYEE_NAME
				, approverdept.DEPARTMENT_TITLE AS APPROVER_DEPARTMENT_TITLE
				, ef.*
				, ei.*
	            FROM APPROVAL a
	                LEFT JOIN EXPENDITURE_FORM ef ON ef.APPROVAL_NO = a.APPROVAL_NO
	                LEFT JOIN EXPENDITURE_ITEM ei ON ei.EXPENDITURE_FORM_NO = ef.EXPENDITURE_FORM_NO
				LEFT JOIN
    		EMPLOYEE e ON e.EMPLOYEE_NO=a.EMPLOYEE_NO
		JOIN
			DEPARTMENT dept ON dept.DEPARTMENT_CODE=e.DEPARTMENT_CODE
		LEFT JOIN
		    APPROVAL_ATT att ON att.APPROVAL_NO=a.APPROVAL_NO
		LEFT JOIN
		    REFERENCE rf ON rf.APPROVAL_NO=a.APPROVAL_NO
		LEFT JOIN
			APPROVER ap ON ap.APPROVAL_NO=a.APPROVAL_NO
		LEFT JOIN
		    EMPLOYEE approver ON approver.EMPLOYEE_NO=ap.EMPLOYEE_NO
		LEFT JOIN
		    DEPARTMENT approverdept ON approverdept.DEPARTMENT_CODE=approver.DEPARTMENT_CODE
		LEFT JOIN
		    EMPLOYEE ref_emp ON ref_emp.EMPLOYEE_NO=rf.EMPLOYEE_NO
		LEFT JOIN
		    DEPARTMENT ref_dept ON ref_dept.DEPARTMENT_CODE=ref_emp.DEPARTMENT_CODE
		WHERE
		    a.APPROVAL_NO='4-2024-0802-033';
		   
		   
SELECT * FROM approval WHERE approval_no='4-2024-0804-039';
SELECT * FROM approver WHERE APPROVAL_NO='4-2024-0802-033';
SELECT * FROM APPROVAL_ATT WHERE APPROVAL_NO ='4-2024-0802-033';
SELECT * FROM reference WHERE approval_no='4-2024-0802-033';