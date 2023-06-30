SELECT
  schemaname,
  relname,
  n_live_tup,
  n_dead_tup,
  last_autovacuum,
  (n_dead_tup::float / NULLIF(n_live_tup, 0)) AS scale_factor
FROM pg_stat_all_tables
ORDER BY n_dead_tup DESC, last_autovacuum ASC
LIMIT 100;