create table &pfx.ora_err (
   num   number(5,0)      not null primary key,
   msg   varchar2(512)
)
organization index
pctfree 0;

declare

   procedure ins(num number) is
      msg varchar2(512);
   begin
      msg := substr(sqlerrm(-num), 12);

      if msg != 'Message ' || num || ' not found;  product=RDBMS; facility=ORA' then
         insert into &pfx.ora_err values(num, msg);
      end if;
   end ins;

begin

   for i in 1 .. 99999 loop
       ins(i);
   end loop;

   insert into &pfx.ora_err values (0, 'ok');
   commit;

end;
/
