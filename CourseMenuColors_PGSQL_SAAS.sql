-- Title: Search for use of Colors on a Course Menu
-- Version: SaaS


select course_name, course_id, navigation_style, u.user_id
from course_main cm 
join course_users cu 
on cm.pk1 = cu.crsmain_pk1
join users u 
on cu.users_pk1 = u.pk1 
where navigation_style = 'Text'
and background_color not like '#333333'