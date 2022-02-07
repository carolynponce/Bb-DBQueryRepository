-- Title: SystemRoleEntitlements_PGSQL_SAAS
-- Author: 
-- Version: SaaS
-- Specific Blackboard Database: default
-- Description: Report of all system roles and their respective entitlements

select replace(sr.name,'.name','') as "System Role"
, sre.entitlement_uid as "Entitlement"
, e."permission" as "Permission"
from system_roles sr 
join system_roles_entitlement sre on sr.system_role = sre.system_role 
join entitlement e on sre.entitlement_uid = e.entitlement_uid 
order by sr.name asc, sre.entitlement_uid asc
;