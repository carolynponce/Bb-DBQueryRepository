-- Running Course Copy Tasks
-- from Chris Bray, University of Arkansas 

SELECT QT.PK1, QT.DTCREATED, QT.DTMODIFIED, QT.TITLE, QT.TASK_TYPE,
    CASE
    WHEN QT.STATUS = 'C' THEN 'Completed'
    WHEN QT.STATUS = 'R' THEN 'Running'
    WHEN QT.STATUS = 'W' THEN 'Waiting'
    ELSE 'OTHER'
    END AS STATUS,
    U.user_id
from QUEUED_TASKS QT
JOIN users u ON QT.users_pk1 = u.pk1
WHERE QT.TASK_TYPE = 'C'
AND STATUS NOT LIKE 'C'
