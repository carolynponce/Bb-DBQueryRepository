-- Title: All Items in specific course
-- Version: SaaS
-- Description: Searches for all items used in a specific Course ID
-- Display/Output: provides informaiton about all tools in a course. 

select cc.*
from course_contents cc 
join course_main cm
on cc.crsmain_pk1 = cm.pk1
where cm.course_id = '[Insert Course_ID]'