-- vim: foldmethod=marker foldmarker={,}

create or replace package &pfx.hlp authid current_user as -- {

     procedure exec_imm(stmt clob, ignore_errors ku$_vcnt := ku$_vcnt());

     function  exec_imm(stmt clob) return pls_integer;
     function  exec_imm_dml(stmt clob, commit_ char := 'n') return pls_integer;
     function  exec_imm_ddl(stmt clob, ignore_errors ku$_vcnt := ku$_vcnt()) return pls_integer;
     function  sel_scalar(stmt clob) return varchar2;

     function  exec_imm_gather_tab_stat(tab varchar2, own varchar2 := user) return pls_integer;

end &pfx.hlp;
/
-- }

create or replace package body &pfx.hlp as -- {

     procedure exec_imm(stmt clob, ignore_errors ku$_vcnt := ku$_vcnt()) is begin /* { */
        execute immediate stmt;
     exception when others then

        declare
           i pls_integer;
        begin
           for i in 1 .. ignore_errors.count loop
              if ignore_errors(i) = abs(sqlcode) then
                 return;
              end if;
           end loop;
        end;

        dbms_output.put_line(sqlerrm);
        dbms_output.put_line(stmt);
     end exec_imm; /* } */

     function exec_imm(stmt clob) return pls_integer -- {
     is
         pragma autonomous_transaction; -- Prevent ORA-14552: cannot perform a DDL, commit or rollback inside a query or DML
     begin
         exec_imm(stmt);
         commit;
         return 0;
     end exec_imm; -- }

     function exec_imm_dml(stmt clob, commit_ char := 'n') return pls_integer /* { */
     is
         cnt pls_integer;
     begin
         exec_imm(stmt);
         cnt := sql%rowcount;
         if lower(commit_) = 'y' then
            commit;
         end if;
         return cnt;
     end exec_imm_dml; /* } */

     function exec_imm_ddl(stmt clob, ignore_errors ku$_vcnt := ku$_vcnt()) return pls_integer /* { */
     is
         pragma autonomous_transaction;
     begin
         exec_imm(stmt, ignore_errors => ignore_errors);
         return 0;
     exception when others then
         return sqlcode;
     end exec_imm_ddl; /* } */

     function sel_scalar(stmt clob) return varchar2 is /* { */
        ret varchar2(32000);
     begin
        exec_imm(stmt);
        execute immediate stmt into ret;
        return ret;
     end sel_scalar; /* } */

     function exec_imm_gather_tab_stat(tab varchar2, own varchar2 := user) return pls_integer is /* { */
     begin

$if false $then

    select
       tab,
        created,
         &pfx.hlp.exec_imm_gather_tab_stat(tab)
    from
       &pfx.tab
    where
       last_analyzed is null and
       tab like '&pfx.trg%';

$end

         return exec_imm('begin dbms_stats.gather_table_stats(''' || own || ''', ''' || tab || '''); end;');

     end exec_imm_gather_tab_stat; /* } */

end &pfx.hlp;
/
-- }
