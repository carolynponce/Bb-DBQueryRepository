-- Title: Authentication Count
-- Version: SaaS
-- Description: Gives authentication count. Set up for Central Time Zone. 10 day interval for SAAS.

SET TIMEZONE='America/Chicago';
--select to_char(h.date, 'mm/dd/yyyy') as date, to_char(h.date, 'Day') as day_of_week, h.hour::bigint, coalesce(logins,0) as logins
select to_char(h.date, 'Day') as day_of_week, h.hour::bigint, avg(coalesce(logins,0))::bigint as avg_logins
from
(
 select date(hour::timestamp), extract(hour from date_trunc('hour',hour::timestamp)) as hour
 from generate_series(NOW() - '10 day'::INTERVAL,
     now(),
     interval '1 hour') hour
        where hour >= NOW() - '10 day'::INTERVAL and hour < NOW()
 ) h
left join (
        SELECT  date(apl.log_date) as date, extract(hour from date_trunc('hour',apl.log_date)) as hour,
        COUNT(1) as logins
        from auth_provider_log apl
        join auth_provider ap on ap.pk1 = apl.auth_provider_pk1
        and ap.name = '[Insert Authentication Name]' and apl.event_type=0
        AND apl.log_date >= NOW() - '10 day'::INTERVAL
        group by date(apl.log_date), extract(hour from date_trunc('hour',apl.log_date))
        ) t on h.hour = t.hour and t.date = h.date
group by h.date, h.hour
order by h.date,h.hour

