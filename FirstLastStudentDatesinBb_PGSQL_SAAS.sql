-- Title: FirstLastStudentDatesinBb-PGSQL-SAAS.sql
-- Author: Chris Baca, SAGU
-- Version: SaaS
-- Description: Finds the first and last student dates of student enrollment in Bb courses.
-- Display/Output: Student Bb ID & user id, first and last Bb date.

select distinct
concat('_',u.pk1,'_1') --output user ID for use in API applications
,u.user_id
,first_bb_date
,last_bb_date
from users u
	inner join (select
				cu.users_pk1
				,min(t.start_date) as first_bb_date
				,max(t.end_date) as last_bb_date
				from course_users cu
					inner join course_main cm on cm.pk1 = cu.crsmain_pk1
					inner join course_term ct on ct.crsmain_pk1 = cm.pk1
					inner join term t on t.pk1 = ct.term_pk1
				group by cu.users_pk1
				) tinfo on tinfo.users_pk1 = u.pk1
where u.user_id in ([StudentID1]
                    ,[StudentID2]
				   )
order by user_id