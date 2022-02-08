-- Title: InstitutionRole-WhoHasWhich_PGSQL-SAAS.SQL
-- Author: Richard Kline, University of Rochester
-- Version: SaaS
-- Specific Blackboard Database: 
-- Description: Lists user assigned institution roles and whether the assignment is primary or secondary
-- Display/Output: Display
-- Depricated/Information Only: (optional)
select ir.role_name
, ir.role_id 
, u.user_id 
, 'PrimaryRole' as RoleType
, u.available_ind as UserAvailableStatus
, to_char(u.dtCreated,'MM/DD/YYYY') as UserDateCreated
, coalesce(to_char(u.last_login_date,'MM/DD/YYYY'),'') as UserLastLoginDate
from institution_roles ir
inner join users u on ir.pk1 = u.institution_roles_pk1  
-- row below removes disabled user accounts
where u.row_status <> 2
-- row below is optional - used if one role should be included in the report
-- and role_id = '[Insert role_id]'
union ALL
select ir.role_name 
, ir.role_id 
, u.user_id 
, 'SecondaryRole' as RoleType
, u.available_ind as UserAvailableStatus
, to_char(u.dtCreated,'MM/DD/YYYY') as UserDateCreated
, coalesce(to_char(u.last_login_date,'MM/DD/YYYY'),'') as UserLastLoginDate
from institution_roles ir
inner join user_roles ur ON ur.institution_roles_pk1 = ir.pk1 
inner join users u on u.pk1 = ur.users_pk1 
-- row below removes disabled user accounts
where u.row_status <> 2
-- row below is optional - used if one role should be included in the report
-- and role_id = '[Insert role_id]'
order by role_name, roletype, user_id
