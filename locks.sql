
/* Fetch all locks for a table and some stats  */
SELECT 
pg_locks.pid, pg_stat_activity.application_name, pg_locks.mode, pg_class.relname, 
pg_stat_activity.state, 
EXTRACT(epoch FROM (now() - pg_stat_activity.query_start)) AS time_in_seconds, 
pg_locks.granted, pg_stat_activity.query
FROM pg_locks
JOIN pg_class ON pg_locks.relation = pg_class.oid
JOIN pg_stat_activity ON pg_stat_activity.pid = pg_locks.pid
WHERE pg_class.relname = 'table_name'
AND query NOT IN ('ROLLBACK;', 'ROLLBACK', 'COMMIT', 'SELECT')
ORDER BY time_in_seconds DESC;

/* Terminate idle queries that are stopping the migration from acquiring the lock*/
select pg_terminate_backend(pid) from 
	(SELECT
pg_locks.pid
FROM pg_locks
JOIN pg_class ON pg_locks.relation = pg_class.oid
JOIN pg_stat_activity ON pg_stat_activity.pid = pg_locks.pid
WHERE pg_class.relname = 'table_name'
AND query NOT IN ('ROLLBACK;', 'ROLLBACK', 'COMMIT', 'SELECT')
and state = 'idle in transaction'
and pg_stat_activity.application_name in ('app_name')
and now() - pg_stat_activity.query_start > '2 second'::interval
) as pids;