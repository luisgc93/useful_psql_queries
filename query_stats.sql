select pid, application_name, now() - query_start as time, state, query
from pg_catalog.pg_stat_activity
where query not in ('ROLLBACK;', 'ROLLBACK', 'COMMIT')
order by time desc nulls last;