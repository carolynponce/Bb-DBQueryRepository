-- Title: MostRecentAssignment-PGSQL-SAAS.sql
-- Author: Chris Baca, SAGU
-- Version: SaaS
-- Description: Finds most recent assignment submission for each enrolled student in each course in a term
-- Display/Output: Student info, professor info, course id, attempt date

select
concat(u.lastname, ', ', u.firstname) as student_name
,u.email as student_email
,prof.profs as prof_names
,prof.emails as prof_emails
,cm.course_id
,a.attempt_date as most_recent_attempt
from course_users cu
	inner join users u on u.pk1 = cu.users_pk1
	inner join course_main cm on cm.pk1 = cu.crsmain_pk1
	inner join course_term ct on ct.crsmain_pk1 = cm.pk1
	inner join term t on t.pk1 = ct.term_pk1

	--subquery for finding professors
	inner join (
					select
						cm.pk1
						,string_agg(concat(u.lastname, ', ', u.firstname), '; ') as profs
						,string_agg(u.email, ', ') as emails
					from course_users cu
						inner join course_main cm on cm.pk1 = cu.crsmain_pk1
						inner join users u on u.pk1 = cu.users_pk1
					where cu.role = 'P'
						and u.email is not null
			   		group by cm.pk1

				) prof on prof.pk1 = cm.pk1

	--subquery for finding most recent attempt
	left outer join (
						select gg.course_users_pk1
							,gm.crsmain_pk1
							,MAX(a.attempt_date) attempt_date
						from gradebook_grade gg
							inner join gradebook_main gm on gm.pk1 = gg.gradebook_main_pk1
							inner join attempt a on a.gradebook_grade_pk1 = gg.pk1
						group by gg.course_users_pk1, gm.crsmain_pk1

					) a on a.course_users_pk1 = cu.pk1 and cm.pk1 = a.crsmain_pk1
where
	--filter term
	t.name like '%[Insert term wildcard]%'

	--filter student
	and cu.role = 'S'
	and cu.row_status = '0'
	and u.lastname not like '%PreviewUser%'

	--remove child courses
	and cm.pk1 not in (
						select
							crsmain_pk1
						from course_course
						)

order by course_id, student_name
