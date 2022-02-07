-- Title: Due Dates During a Timeframe
-- Author Chris Bray
-- Version: SaaS
-- Description: Which courses have due dates during a certain timeframe

select 
 distinct gm.TITLE, cm.COURSE_ID, cm.course_name, gm.DUE_DATE, u.USER_ID AS Email, ( u.FIRSTNAME || ' ' || u.LASTNAME)
from gradebook_main gm
INNER JOIN course_main cm on gm.CRSMAIN_PK1 = cm.PK1
inner join course_users cu on cm.pk1 = cu.crsmain_pk1 
INNER JOIN users u ON cu.users_pk1 = u.pk1
WHERE cm.COURSE_ID like '%[Insert CourseID identifyer]%'
--and gm.due_date is not NULL
and gm.due_date between '[Insert Date and Time]' and '[Insert Date and Time]' --MM/DD/YYYY HH:MM:SS
AND (cu.ROLE = 'P')
AND (cu.ROW_STATUS = '0')
AND (u.ROW_STATUS = '0')
AND (u.AVAILABLE_IND = 'Y')
AND (cm.ROW_STATUS = '0')
order by cm.course_id