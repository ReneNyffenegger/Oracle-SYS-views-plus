create or replace view &pfx.ts as
select
  'Data'                                                      "Type"      ,
   &low fre.tablespace_name &wol &ci                           ts         ,
   to_char(usd.totalspace - fre.freespace     , '999,999')    "Used MB"   ,
   to_char(fre.freespace                      , '999,999')    "Free MB"   ,
   to_char(usd.totalspace                     , '999,999')    "Total MB"  ,
   round(100 * fre.freespace / usd.totalspace)                "Pct. Free"
from
   (select tablespace_name, round(sum(bytes) / 1024/1024) TotalSpace from dba_data_files group by tablespace_name) usd  join
   (select tablespace_name, round(sum(bytes) / 1024/1024) FreeSpace  from dba_free_space group by tablespace_name) fre on usd.tablespace_name = fre.tablespace_name
union all
select
  'Temp',
   tablespace_name,
   to_char(round((tablespace_size - free_space ) / 1024/1024), '999,999'),
   to_char(round( free_space                     / 1024/1024), '999,999'),
   to_char(round( tablespace_size                / 1024/1024), '999,999'),
   round(100 * free_space  / tablespace_size )
from
   dba_temp_free_space;
