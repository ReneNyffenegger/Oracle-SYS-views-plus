@_defines.sql

select * from &pfx.obj;
select * from &pfx.obj where obj = '&pfx.ora_err';
select
   count(*),
   typ
from
   &pfx.obj
group by
   typ;
select * from &pfx.tab;
select * from &pfx.tab where tab = '&pfx.ora_err';
select * from &pfx.view;
select * from &pfx.view where ora = 'y';
select * from &pfx.ind;
select count(*), tab_typ from &pfx.ind group by tab_typ;
select * from &pfx.seg;
select * from &pfx.syn;
select count(*), typ from &pfx.syn group by typ;
select typ, count(*) from &pfx.seg group by typ;
select * from &pfx.col where ora = 'n';
select * from &pfx.cols order by length(cols) desc;
select * from &pfx.cols where own = 'sys' and tab = 'v_$session';
select * from &pfx.cons_;
select * from &pfx.cons_fk;
select * from &pfx.ts;
select * from &pfx.obj_priv;
select * from &pfx.sesstat;
