-- select * from dba_objects  where object_type = 'DATABASE LINK';
-- select * from dba_db_links;

create or replace view &pfx.dblink as
select
   obj.own,
   obj.obj               dblink,
   &low dbl.username     &wol &ci usr,
   &low dbl.host         &wol &ci host,
   obj.created,
-- obj.last_ddl_time,
-- obj.ts,
   obj.st,                -- Compare dbl.valid. Can it be invalid?
-- obj.ora,               -- Always 'n'?
-- obj.id,                -- Database links have no obj id.
   obj.stmt_drop
from
   dba_db_links  dbl                                              join
   &pfx.obj      obj on &low dbl.owner        &wol = obj.own and
                        &low dbl.db_link      &wol = obj.obj and
                        &low 'DBLINK'         &wol ='dblink';

