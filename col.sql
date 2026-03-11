create or replace view &pfx.col as
select
   &low col.table_name  &wol&ci tab,
   &low col.column_name &wol&ci col,
   &low col.owner       &wol&ci own,
   case
        when col.data_type like 'TIMESTAMP%' then 'ts'
        when col.data_type =    'NUMBER'     then 'num'
        when col.data_type =    'VARCHAR2'   then 'vc'
        when col.data_type =    'DATE'       then 'dt'
        when col.data_type =    'CHAR'       then 'c'
        when col.data_type =    'RAW'        then 'raw'
        else  col.data_type
   end                                                              dt_,
   case
      when col.data_type in ('VARCHAR2', 'CHAR') then
           lpad(col.data_length, 5)
      when col.data_type = 'NUMBER' then
           case when col.data_precision is not null then
                lpad(col.data_precision, 5) ||
                case when col.data_scale != 0 then
                   '.' || col.data_scale
                end
           end
   end                                                              len,
   col.data_default                                                 def,
   tab.num_rows_,
   tab.sample_size,
   to_char(100/nullif(tab.num_rows, 0) * tab.sample_size, '990.0')  pct,
   col.num_distinct,
   case when tab.num_rows = col.num_distinct then 'uq' end          uq_stat,
   col.nullable nul_,
   col.num_nulls,
   tab.last_analyzed,
   col.global_stats, col.user_stats,
   col.histogram,
   tcm.comments                                                     comment_tab,
   ccm.comments                                                     comment_col,
   col.hidden_column                                                hid,
   col.virtual_column                                               virt,
   obj.typ                                                          object_type,
   obj.ora,
   cast(null as varchar2(30))                                       subobject_name
from
    dba_tab_cols     col                                                          left join
    &pfx.obj         obj  on &low col.owner      &wol  = obj.own          and
                             &low col.table_name &wol  = obj.obj          and
                             obj.typ in ('tab', 'view')                           left join
    dba_col_comments ccm  on col.owner                  = ccm.owner       and
                             col.table_name             = ccm.table_name  and
                             col.column_name            = ccm.column_name         left join
    dba_tab_comments tcm  on col.owner                  = tcm.owner       and
                             col.table_name             = tcm.table_name          left join
    &pfx.tab         tab  on &low col.owner       &wol  = tab.own         and
                             &low col.table_name  &wol  = tab.tab
order by
   case
      when obj.typ not in ('view', 'tab') then   99
      when col.table_name like 'BIN$%'    then  999
      else 0
   end,
   col.table_name;
