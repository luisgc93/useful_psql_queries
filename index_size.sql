SELECT
  c.relname AS index_name,
  pg_size_pretty(pg_relation_size(c.oid)) AS index_size
FROM
  pg_class c
  LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE
  c.relkind = 'i'
  AND n.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY
  pg_relation_size(c.oid) DESC;