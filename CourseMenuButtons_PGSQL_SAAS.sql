-- Title: Search for Buttons on a Course Menu
-- Version: SaaS


select course_name, course_id, navigation_style, u.user_id
from course_main cm 
join course_users cu 
on cm.pk1 = cu.crsmain_pk1
join users u 
on cu.users_pk1 = u.pk1 
where navigation_style = 'BUTTON'
and cu.role = 'P'
and cu.row_status = '0'
-- and cm.data_src_pk1 in ([insert PK1 for specific terms to reduce search])
