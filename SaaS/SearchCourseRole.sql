--Searches for certain Course Roles. Displays Course Batch UID, Course ID, and User ID and DSK. 

select cm.batch_uid, cm.course_id, u.user_id as Email, cu.role, ds.batch_uid as DSK
from course_users cu
JOIN course_main cm on cu.crsmain_pk1 = cm.pk1
JOIN users u ON cu.users_pk1 = u.pk1
INNER JOIN DATA_SOURCE ds 
ON cu.data_src_pk1 = ds.pk1
WHERE cu.role = '[insert role_id]'
order by cm.course_id
