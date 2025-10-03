ALTER SYSTEM SET log_destination = 'stderr';
ALTER SYSTEM SET logging_collector = off;                    -- stdout via Docker
ALTER SYSTEM SET log_statement = 'all';
ALTER SYSTEM SET log_min_duration_statement = 0;
ALTER SYSTEM SET log_line_prefix = '%m [%p] %u@%d %r %a ';
ALTER SYSTEM SET log_connections = on;
ALTER SYSTEM SET log_disconnections = on;
ALTER SYSTEM SET log_lock_waits = on;
SELECT pg_reload_conf();
