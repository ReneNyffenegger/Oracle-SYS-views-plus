create or replace view &pfx.cons_fk as
select
   pk.own                    own_pk,
   pk.tab                    tab_pk,
   fk.own                    own_fk,
   fk.tab                    tab_fk,
   pk.cols                   cols_pk,
   fk.cols                   cols_fk,
   pk.nam                    nam_pk,
   fk.nam                    nam_fk,
   fk.own || '.' || fk.nam   nam_fk_qual
from
   &pfx.cons_       fk                                                     join
   &pfx.cons_       pk on pk.own = fk.own_r and
                          pk.nam = fk.nam_r;
