/*index stats*/
select * from pg_catalog.pg_stat_all_indexes
where relname = 'table_name';  

/*index types*/
SELECT tab.relname, cls.relname, am.amname
FROM pg_index idx 
JOIN pg_class cls ON cls.oid=idx.indexrelid
JOIN pg_class tab ON tab.oid=idx.indrelid
JOIN pg_am am ON am.oid=cls.relam
order by tab.relname desc;

/*index IO stats*/
select * from pg_catalog.pg_statio_all_indexes
where relname = 'table_name';  

/*index size*/
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