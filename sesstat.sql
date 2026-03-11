create or replace view &pfx.sesstat as
select
   sest.sid,
   stat.name,
   case
      when stat.name like '%bytes%' then to_char(sest.value / 1024/1024, '999g990') || ' MB'
      else lpad(to_char(sest.value), 8)
   end                  val,
   sest.value
from
   v$sesstat  sest                                         join
   v$statname stat on sest.statistic# = stat.statistic#
where
   value <> 0;
