-- Title: InstitutionalRoleList_PGSQL_SAAS
-- Author: Dan Gioia, St. Louis Community College
-- Version: SaaS
-- Specific Blackboard Database: default
-- Description: list of institution roles

/* enumerate roles */
select pk1, role_name, role_id, row_status
from institution_roles
order by role_name asc
;