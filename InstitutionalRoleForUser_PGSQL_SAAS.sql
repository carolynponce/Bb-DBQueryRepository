-- Title:InstitutionalRoleForUser_PGSQL_SAAS.sql
-- Author: Dan Gioia, St. Louis Community College
-- Version: SaaS
-- Specific Blackboard Database: default
-- Description: list primary and secondary institution roles for a user

/* find primary role for a specific user */
select usr.USER_ID, replace(ir.ROLE_NAME, '.role_name', '') as "Primary Role"
from users usr
join INSTITUTION_ROLES ir on usr.INSTITUTION_ROLES_PK1=ir.PK1
where usr.USER_ID='[insert username]';

/* find secondary roles for a specific user */
select usr.USER_ID, replace(ir2.ROLE_NAME, '.role_name', '') as "Secondary Roles"
from USER_ROLES ur
join users usr on ur.USERS_PK1=usr.PK1
join INSTITUTION_ROLES ir2 on ur.INSTITUTION_ROLES_PK1=ir2.PK1
where usr.USER_ID='[insert username]'
ORDER BY ir2.role_name
;