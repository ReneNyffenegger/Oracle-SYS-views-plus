create or replace view &pfx.cols as
select
   &low col.owner      &wol &ci                 own,
   &low col.table_name &wol &ci                 tab,
    listagg(&low col.column_name &wol, ','
      on overflow truncate '...' without count) cols,
    listagg(
       &low col.column_name &wol || ' ' ||
       &low col.data_type   &wol ||
          case col.data_type
            when 'VARCHAR2' then '(' || col.data_length || ')'
          end,
       ','
      on overflow truncate '...' without count) cols_typ
from
   dba_tab_cols  col
group by
   col.owner,
   col.table_name;
