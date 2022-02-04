-- Title: InstitutionalRoleMembership
-- Author: Dan Gioia, St. Louis Community College
-- Version: SaaS
-- Specific Blackboard Database: default
-- Description: list members of an institution role

/* remember when searching that the built-in roles have .role_name appended to the 
name, example STAFF.role_name, probably for language pack support */

/* enumerate members of an institutional role (as secondary) */
select usr.USER_ID, REPLACE(ir1.ROLE_NAME,'.role_name','') "Members with Secondary Role"
from USER_ROLES ur, INSTITUTION_ROLES ir1, users usr
where ur.INSTITUTION_ROLES_PK1=ir1.PK1
and ur.USERS_PK1=usr.PK1
and ir1.ROLE_NAME = '[insert Role Name]'
order by usr.user_id;

/* enumerate members of an institutional role (as Primary) */
select usr.USER_ID, replace(ir.ROLE_NAME, '.role_name', '') as "Members as Primary Role"
from users usr
join INSTITUTION_ROLES ir on usr.INSTITUTION_ROLES_PK1=ir.PK1
where ir.Role_Name = '[insert Role Name]';
