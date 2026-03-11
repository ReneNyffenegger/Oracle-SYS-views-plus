create or replace view &pfx.view as
select
   &low vie.owner      &wol&ci    own,
   &low vie.view_name  &wol&ci    view_,
   obj.created,
   obj.last_ddl_time,
   com.comments,
   obj.ora,
  'select * from ' || &low vie.owner &wol || '.' || &low vie.view_name &wol || ';' sel,
   vie.text                                                                        txt
from
    dba_views         vie                                                       join
    &pfx.obj          obj on &low vie.view_name &wol =  obj.obj         and
                             &low vie.owner     &wol =  obj.own         and
                             obj.typ                 = 'view'                   join
    dba_tab_comments  com on vie.view_name           =  com.table_name  and
                             vie.owner               =  com.owner
order by
   obj.created desc;
