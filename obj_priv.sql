create or replace view &pfx.obj_priv as
select
   &low tbp.grantee    &wol &ci                           grantee,
   &low tbp.owner      &wol &ci                           obj_own,
   &low tbp.table_name &wol &ci                           obj_nam,
   &low listagg(substr(tbp.privilege, 1, 3), ',') &wol    grants
from
   dba_tab_privs     tbp
where
   tbp.type not in ('USER')
group by
   tbp.grantee,
   tbp.type,
   tbp.owner,
   tbp.table_name;
