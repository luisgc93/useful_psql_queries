
/* Fetch all locks for a table and some stats  */
SELECT 
pg_locks.pid, pg_stat_activity.application_name, pg_locks.mode, pg_class.relname, 
pg_stat_activity.state, now() - pg_stat_activity.query_start AS time, pg_locks.granted, pg_stat_activity.query
FROM pg_locks
JOIN pg_class ON pg_locks.relation = pg_class.oid
JOIN pg_stat_activity ON pg_stat_activity.pid = pg_locks.pid
WHERE pg_class.relname = 'network'
AND query NOT IN ('ROLLBACK;', 'ROLLBACK', 'COMMIT', 'SELECT')
ORDER BY granted ASC;