-- Title: SystemRoleMembership_PGSQL_SAAS
-- Author: Dan Gioia, St. Louis Community College
-- Version: SaaS
-- Specific Blackboard Database: default
-- Description: list members having a system role

select usr.user_id,usr.email 
,usr.firstname,usr.lastname
,usr.row_status as "Enabled (0=yes,2=no)"
from users usr 
left outer join domain_admin da on usr.pk1 = da.user_pk1
left join system_roles sr on da.system_role = sr.system_role 
where (
    usr.system_role = '[insert system role name]' 
    or sr.system_role = '[insert system role name]'
)
;