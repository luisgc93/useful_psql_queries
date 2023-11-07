SELECT relname
FROM pg_class
WHERE oid in (16714, 16843);

select pg_locks.mode, pg_class.relname from pg_locks
join pg_class on relation = oid
where pg_class.relname = 'network'
and pg_locks.mode != 'AccessShareLock' 