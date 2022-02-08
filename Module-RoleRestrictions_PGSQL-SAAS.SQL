-- Title: Module-RoleRestrictions_PGSQL-SAAS.SQL
-- Author: Richard Kline, University of Rochester
-- Version: SaaS
-- Specific Blackboard Database: 
-- Description: Lists modules and to which institution roles they are restricted
-- Display/Output: Display
-- Deprecated/Information Only: (optional)
SELECT     
m.TITLE
, coalesce(m.short_name,'') as ModuleShortName
, coalesce(m.description,'') as ModuleDescription
, m.ENABLED_IND
, coalesce(ir.ROLE_NAME,'') as RestrictedRoleName
, coalesce(ir.ROLE_ID,'') as RestrictedRoleID
FROM MODULE_GROUP mg 
left outer join
INSTITUTION_ROLES ir ON mg.INSTITUTION_ROLES_PK1 = ir.PK1 
INNER JOIN
MODULE_MODULE_GROUP mmg ON mmg.MODULE_GROUP_PK1 = mg.PK1 
INNER JOIN
MODULE m ON m.PK1 = mmg.MODULE_PK1
ORDER BY m.TITLE, RestrictedRoleName
