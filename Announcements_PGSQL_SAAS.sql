-- Title: Announcements
-- Author: Chris Bray
-- Version: SaaS
-- Description: Searches for Announcements in a specific Course ID
-- Display/Output: Shows when the announcement was created 

SELECT cm.course_id, cm.pk1, u.USER_ID , aa.SUBJECT, aa.ANNOUNCEMENT, aa.DTCREATED, aa.DTMODIFIED
FROM course_main cm
JOIN announcements aa ON cm.pk1 = aa.crsmain_pk1
JOIN USERS u ON u.pk1 = aa.USERS_PK1
-- AND cm.row_status   ='0'
-- AND cm.available_ind ='Y'
where cm.course_id like '[InsertCourseID]'
ORDER BY  cm.course_id

