-- Title: MissingGrades-PGSQL-SAAS.sql
-- Author: Chris Baca, SAGU
-- Version: SaaS
-- Description: Finds all grades for a student in a set of courses
--(if term is captured in course_id, will capture grades in a term or terms)
-- Display/Output: Student name, assignment title & type, due date, grade, possible points, attempt date

select
concat(u.lastname, ', ', u.firstname) as student_name
,cm.course_id
,gm.title as gradebook_title
,gt.name as gradebook_type
,gm.due_date
,case
	when gg.manual_grade is not null then gg.manual_grade
	else a.grade
end
,gm.possible
,a.attempt_date
from course_users cu
	inner join users u on u.pk1 = cu.users_pk1
	inner join course_main cm on cm.pk1 = cu.crsmain_pk1
	inner join gradebook_main gm on gm.crsmain_pk1 = cm.pk1
	left join gradebook_grade gg on gg.gradebook_main_pk1 = gm.pk1
		and gg.course_users_pk1 = cu.pk1
	left join attempt a on a.pk1 = gg.last_attempt_pk1
	inner join gradebook_type gt on gt.pk1 = gm.gradebook_type_pk1
where u.user_id = '[Insert student id]'
	and cm.course_id similar to '%([Insert course wildcard]|[Insert another course wildcard])%'
	and gm.due_date is not null
	and cu.role = 'S'
	and cu.row_status = '0'
order by course_id, due_date
