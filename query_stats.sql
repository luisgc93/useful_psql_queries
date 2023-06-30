select query_start, state_change, state, backend_xmin, query
from pg_catalog.pg_stat_activity 
order by query_start;