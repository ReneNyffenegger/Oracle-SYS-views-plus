create or replace view &pfx.tab as
select
   &low tab.owner      &wol &ci              own,
   &low tab.table_name &wol &ci              tab,
   tab.last_analyzed,
   to_char(tab.num_rows, '999,999,999,990') num_rows_,
   obj.created,
   obj.last_ddl_time,
   tab.sample_size,
   tab.num_rows,
   com.comments,
   obj.ora,
  'select * from ' || &low tab.owner &wol || '.' || &low tab.table_name &wol || ';' sel
from
   dba_tables        tab                                                    join
   &pfx.obj          obj on &low tab.table_name &wol =  obj.obj         and
                            &low tab.owner      &wol =  obj.own         and
                            obj.typ                  =  'tab'               join
   dba_tab_comments  com on tab.table_name           =  com.table_name  and
                            tab.owner                =  com.owner
order by
  obj.created desc;
