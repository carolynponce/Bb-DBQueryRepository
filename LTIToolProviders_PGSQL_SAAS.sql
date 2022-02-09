-- Title: LTI Tool Providers
-- Author: Stefano Collovati
-- Version: SaaS
-- Description: List LTI Tool Providers and count placements

select 
case when bdc.lti_type = '1' then 'LTI 1.1'
else 'LTI 1.3'
end as "Tool Type"
, case when bdc.config_status = 'A'then 'Approved'
else 'Excluded'
end as "Status"
, bdh.domain_name as "Domain"
, bdc."name" as "Tool Name"
, bdc.grade_service_ind as "Grade Service Access"
, bdc.membership_service_ind as "Membership Service Access"
, bdc.custom_parameters as "Custom Parameters"
, lti_placement_count.count as "Placement count"
from blti_domain_config bdc
left join blti_domain_host bdh on bdc.pk1 = bdh.blti_domain_config_pk1
left join (
select blti_domain_config_pk1, count(*) from blti_placement
group by blti_domain_config_pk1
) as lti_placement_count on lti_placement_count.blti_domain_config_pk1 = bdc.pk1
where bdh.primary_ind = 'Y' -- I'm considering only the primary domain configured in the tool
order by 3
