SELECT relname
FROM pg_class
WHERE oid in (pid1, pid2...);

select pg_locks.pid, pg_stat_activity.application_name, pg_locks.mode, pg_class.relname, pg_stat_activity.state, pg_locks.granted, pg_stat_activity.query
from pg_locks
join pg_class on pg_locks.relation = pg_class.oid
join pg_stat_activity on pg_stat_activity.pid = pg_locks.pid
where pg_class.relname = 'table_name'
order by granted asc;