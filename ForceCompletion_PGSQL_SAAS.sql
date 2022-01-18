-- Title: Force Completion 
-- Author: Chris Bray, University of Arkansas
-- Version: SaaS
-- Description: Searches for tests with Force Completion turned on. 
-- Display/Output: Course ID, Name, Instructor, Email, and test settings, including name, timer, auto-submit, etc.

select cm.course_id as "Course ID", cm.course_name as "Course Name", u.user_id as "Username"
--,u.firstname || ' ' || u.lastname as Instructor
,u.lastname || ', ' ||u.firstname as "Instructor(LF)"
,u.email as "Email Address"
--,u.firstname as "First Name"
,cu.role
,ca.force_completion_ind
,ca.time_limit as "Time Limit"
--,ca.soft_time_limit
,ca.timer_completion as "Auto-Submit - H=On C=Off"
-- ca.qti_asi_data_pk1,
,qad.title as "Test Name"
from course_main CM
join course_assessment CA on cm.pk1 = CA.crsmain_pk1
join qti_asi_data QAD on qad.pk1 = ca.qti_asi_data_pk1
join course_users CU on cm.pk1 = CU.crsmain_pk1
left join users U on CU.USERS_PK1 = U.PK1
where 1=1 -- because it makes it easier to add criteria.
and cu.role = 'P' and cu.available_ind = 'Y' and cu.row_status = 0 -- choose only current instructors
-- and cu.data_src_pk1 <> 2 -- pick anyone that was added via snapshot and not GUI.
 and (CM.course_id like '%[Insert Course_ID]%')
 --and qad.title <> 'Syllabus Quiz Placeholder' -- remove a quiz stored in template
 and ca.force_completion_ind = 'Y' -- check for force completion
 -- and DELIVERY_TYPE_IND = 'O' --. A=All at once, Q=One question at a time.
 -- and NO_BACKTRACK_IND = 'Y' -- for no backtrack
 -- and TIME_LIMIT not NULL -- for time limit 
and qad.title is not null -- only tests/surveys have a title, questions do not
order by u.user_id, cm.course_id, qad.title 
desc
