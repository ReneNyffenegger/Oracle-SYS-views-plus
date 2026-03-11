create or replace view &pfx.cons_ as
select
   &low cn.constraint_name   &wol &ci nam,
   &low cn.owner             &wol &ci own,
   &low cn.table_name        &wol &ci tab,
   cn.constraint_type                 typ,
   cn.status                          st,
   listagg(&low cl.column_name &wol, ',' on overflow truncate '...' without count) within group (order by cl.position) cols,
   cn.search_condition_vc             chk,
   &low cn.r_constraint_name &wol &ci nam_r,
   &low cn.r_owner           &wol &ci own_r
from
   dba_constraints  cn                                                left join
   dba_cons_columns cl on cn.owner           = cl.owner           and
                          cn.constraint_name = cl.constraint_name
group by
   cn.owner,
   cn.constraint_name,
   cn.table_name,
   cn.constraint_type,
   cn.status,
   cn.search_condition_vc,
   cn.r_constraint_name,
   cn.r_owner;
