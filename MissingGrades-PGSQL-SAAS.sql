-- Title: MissingGrades-PGSQL-SAAS.sql
-- Author: Chris Baca, SAGU
-- Version: SaaS
-- Description: Finds students, professors, and courses with submitted assignments that have not been graded
-- Display/Output: Course_id & name, professer details, student info, assignment title & info

select
cm.course_id
,t.name
,p.professor
,p.prof_email
,concat(u.lastname, ', ', u.firstname) as student
,gm.title
,a.attempt_date
,gm.due_date
from attempt a
	inner join gradebook_grade gg on a.gradebook_grade_pk1 = gg.pk1
	inner join gradebook_main gm on gg.gradebook_main_pk1 = gm.pk1
	inner join course_users cu on gg.course_users_pk1 = cu.pk1
	inner join users u on cu.users_pk1 = u.pk1
	inner join course_main cm on gm.crsmain_pk1 = cm.pk1
	inner join course_term ct on ct.crsmain_pk1 = cm.pk1
	inner join term t on ct.term_pk1 = t.pk1
	left join (
		select
		cm.pk1
		,concat(u.lastname, ', ', u.firstname) as professor
		,u.email as prof_email
		from course_users cu
			inner join users u on cu.users_pk1 = u.pk1
			inner join course_main cm on cu.crsmain_pk1 = cm.pk1
		where cm.course_id like '%[Insert course_id wildcard]%'
			and cu.role = 'P'
				) p on cm.pk1 = p.pk1
where
	--filter student
	cu.role = 'S'
	and cu.row_status = '0'
	and u.user_id not like '%previewuser'

	--filter assignments
	and coalesce(a.grade, '') = ''
	and gg.highest_attempt_pk1 is null
	and gg.status = '2'
	and gg.manual_grade is null
	and gg.exempt_ind = 'N'
	and a.status = '6'

	--filter courses
	and cm.course_id like '%[Insert course_id wildcard]%'
	and t.name like '%[Insert term]%'

order by cm.course_id, u.lastname
