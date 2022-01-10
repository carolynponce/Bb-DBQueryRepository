-- Title: Course Enrollment by Username
-- Author: Chris Baca, SAGU
-- Version: SaaS
-- Description: Allows the user to search Course Enrollment by Username

select
cu.pk1
,concat(u.lastname, ', ', u.firstname) as student_name
,u.email as student_email
,cm.course_id
from course_users cu
	inner join users u on u.pk1 = cu.users_pk1
	inner join course_main cm on cm.pk1 = cu.crsmain_pk1
	inner join course_term ct on ct.crsmain_pk1 = cm.pk1
	inner join term t on t.pk1 = ct.term_pk1
where cu.role = 'S'
	and cu.row_status = '0'
	and u.user_id like '[Insert User_ID]'
	and cm.pk1 not in (
						select
							crsmain_pk1
						from course_course
						)
order by course_id, student_name
