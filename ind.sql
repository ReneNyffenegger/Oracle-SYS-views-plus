create or replace view &pfx.ind as
select
   &low ind.index_name             &wol &ci nam,
   &low ind.owner                  &wol &ci own_ind,
   &low any_value(ind.table_name ) &wol &ci tab,
   &low any_value(ind.table_owner) &wol &ci own_tab,
   listagg(&low col.column_name &wol, ',' on overflow truncate '...' without count) cols,
   any_value(ind.uniqueness ) uq,
   any_value(case ind.table_type
              when 'TABLE'   then 'tab'
              when 'CLUSTER' then 'clus'
              else lower(ind.table_type)
            end) tab_typ,
   any_value(ind.index_type )               ind_typ
from
   dba_indexes     ind                                           left join
   dba_ind_columns col on ind.owner      = col.index_owner and
                          ind.index_name = col.index_name
group by
   ind.index_name ,
   ind.owner;
