---json object
--json array
--json boolean

CREATE OR REPLACE PROCEDURE getall_emp_dept_list (p_employee OUT SYS_REFCURSOR) 
AS 

BEGIN 
OPEN 
p_employee 
FOR 
SELECT
    d.deptno   AS "Department Number",
    d.dname    AS "Department Name",
    cursor(
            SELECT
            e.empno   AS "Employee Number",
            e.ename   AS "Employee Name",
            e.job     AS "Job"
            FROM
            emp e
            WHERE
                d.deptno = e.deptno
            order BY d.deptno
            ) AS "Employees" 
from dept d 
order by d.deptno;

EXCEPTION
WHEN OTHERS THEN
p_employee := NULL; 
END;
