create or replace view &pfx.syn as
select
   &low syn.owner        &wol &ci own,
   &low syn.synonym_name &wol &ci syn,
   &low syn.table_owner  &wol &ci tab_own,
   &low syn.table_name   &wol &ci tab,
   tab.typ,
   &low syn.db_link      &wol &ci dblnk,
   obj.created,
   obj.last_ddl_time,
   obj.ts,
   obj.st,
   obj.ora,
   obj.id
from
   dba_synonyms  syn                                              left join
   &pfx.obj      obj on &low syn.owner        &wol = obj.own and
                        &low syn.synonym_name &wol = obj.obj      left join
   &pfx.obj      tab on &low syn.table_owner  &wol = tab.own and
                        &low syn.table_name   &wol = tab.obj;
