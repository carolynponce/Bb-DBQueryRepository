-- Title: EnrollmentDetails-PGSQL-SAAS
-- Author: Dan Gioia, St. Louis Community College
-- Version: SaaS
-- Specific Blackboard Database: default
-- Description: Enrollment Details, including merge status, excluding preview users

select 
 case 
	when cu.ROW_STATUS=0 then 'Enabled'
	when cu.ROW_STATUS=2 then 'Disabled'
  end as "Enroll Status"
, case
	when cu.ROLE='P' then 'Instructor'
	when cu.ROLE='S' then 'Student'
	when cu.ROLE='T' then 'T A'
	else 'Other'
  end as "Course Role"
, case  
	when cu.AVAILABLE_IND='Y' then 'Yes'
	when cu.AVAILABLE_IND='N' then 'No'
  end as "Enroll Available"
, cu.pk1 as "Enroll Db Key" 
, cm.COURSE_NAME as "Course Name"
, cm.COURSE_ID as "Bb CRN"
, usr.USER_ID as "Username"
, cu.LAST_ACCESS_DATE AS "Last Access"
, usr.BATCH_UID AS "EPK"
, usr.FIRSTNAME as "First Name"
, usr.LASTNAME as "Last Name"
, case  
	when usr.ROW_STATUS=0 then 'Enabled'
	when usr.ROW_STATUS=2 then 'Disabled'
  end as "User Status"
, case usr.AVAILABLE_IND 
	when 'Y' then 'Yes'
	when 'N' then 'No'
  end as "User Available"
, ds.BATCH_UID as "Enroll Data Source"
, ds2.BATCH_UID as "User Data Source"
, cm2.COURSE_ID as "Child ID"
, cm3.course_id as "Parent ID"
, cu.dtmodified as "Enr Mod"
, cu.enrollment_date as "Enr Cre" 
from COURSE_USERS cu
join COURSE_MAIN cm on cu.CRSMAIN_PK1=cm.PK1
join USERS usr on cu.USERS_PK1=usr.PK1
join data_source ds on cu.DATA_SRC_PK1=ds.PK1
join data_source ds2 on usr.DATA_SRC_PK1=ds2.PK1
left outer join course_term ct ON cm.PK1 = ct.CRSMAIN_PK1 
left outer join term t ON ct.TERM_PK1 = t.PK1 
left outer join course_main cm2 on cu.child_crsmain_pk1=cm2.PK1
left outer join course_course cc on cm.pk1 = cc.crsmain_pk1
left outer join course_main cm3 on cc.crsmain_parent_pk1 = cm3.pk1
where 
cm.course_id = '[insert course_id]'
-- usr.user_id = '[insert username]'
and cu.ROW_STATUS = 0
and usr.row_status = 0
and usr.USER_ID NOT LIKE '%previewuser'
order by 
    usr.LASTNAME 
    -- cm.COURSE_ID
    -- usr.user_id
    -- cu.LAST_ACCESS_DATE
;