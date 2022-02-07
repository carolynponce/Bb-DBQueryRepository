-- Title: Activity Accumulator
-- Author: (insert developer name)
-- Version: SaaS
-- Description: Activity Accumulator query for a user in a course during a ceratin timeframe. 
-- Display/Output: PK1, Session ID, Timestamp, Event Type, User ID, course ID, Group, Discussion, Handle

SELECT aa.pk1, aa.session_id, to_char(aa.timestamp, 'yyyy-mm-dd HH24:MI:SS') as "date", aa.event_type, u.user_id, cm.course_id, cm.course_name, g.group_name, fm.name AS forum_name, aa.internal_handle, cc.title
-- case when t.label is not null then t.label
--when m.title is not null then m.title0--else aa.data end as DATA, aa.timestamp
FROM activity_accumulator aa
LEFT JOIN course_main cm ON aa.course_pk1 = cm.pk1
LEFT JOIN users u ON aa.user_pk1 = u.pk1
LEFT JOIN course_contents cc ON aa.content_pk1 = cc.pk1
LEFT JOIN groups g ON aa.group_pk1 = g.pk1
LEFT JOIN forum_main fm ON aa.forum_pk1 = fm.pk1
LEFT JOIN tab t on aa.data = '_'||t.pk1||'_1' and aa.event_type = 'TAB_ACCESS'
LEFT JOIN module m on aa.data = '_'||m.pk1||'_1' and aa.event_type = 'MODULE_ACCESS'
WHERE u.user_id = '[Insert User_ID' 
and cm.course_id = '[Insert Course-ID]'
AND timestamp between to_timestamp('[Insert Starting Date and Time]', 'YYYY-MM-DD HH24:MI:SS') AND to_timestamp('[Insert Ending Date and Time]', 'YYYY-MM-DD HH24:MI:SS')
ORDER BY aa.timestamp

-- pk1 = primary key, every table has a pk1

-- aa.data = _5000_1, t.pk1 = 5000
-- foreign key = refering to another table to link data, activity_accumulator.course_pk1  is to match up with course_main.pk1
