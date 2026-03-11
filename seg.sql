create or replace view &pfx.seg as
select
   &low seg.owner           &wol &ci  own,
   &low seg.segment_name    &wol &ci  seg,
   decode(seg.segment_type,
      'CLUSTER'            , 'clus'   ,
      'INDEX'              , 'ind'    ,
      'INDEX PARTITION'    , 'indpart',
      'INDEX SUBPARTITION' , 'indpart',
      'LOB PARTITION'      , 'lobpart',
      'LOBINDEX'           , 'ind'    ,
      'LOBSEGMENT'         , 'lob'    ,
      'NESTED TABLE'       , 'nesttab',
      'ROLLBACK'           , 'rbk'    ,
      'SYSTEM STATISTICS'  , 'sysstat',
      'TABLE'              , 'tab'    ,
      'TABLE PARTITION'    , 'tabpart',
      'TABLE SUBPARTITION' , 'tabsubp',
      'TYPE2 UNDO'         , 'undo'   ,
      lower(seg.segment_type)
    )                                 typ,
    &low seg.tablespace_name &wol &ci ts,
    round(bytes/1024/1024)            mb,
    &low ind.table_name      &wol &ci tab,
    &low ind.table_owner     &wol &ci tab_own,
    obj.created,
    obj.last_ddl_time,
    obj.ora
from
    dba_segments seg                                                         left join
    dba_indexes  ind on seg.segment_type           = 'INDEX'           and
                        seg.segment_name           =  ind.index_name   and
                        seg.owner                  =  ind.owner              left join
    &pfx.obj     obj on &low seg.segment_name &wol =  obj.obj and
                        &low seg.owner        &wol =  obj.own and
                        obj.typ = decode(seg.segment_type,
                                        'CLUSTER'            , 'clus'   ,
                                        'INDEX'              , 'ind'    ,
                                        'INDEX PARTITION'    , 'indpart',
                                        'INDEX SUBPARTITION' , 'indpart',
                                        'LOB PARTITION'      , 'lobpart',
                                        'LOBINDEX'           , 'ind'    ,
                                        'LOBSEGMENT'         , 'lob'    ,
                                        'NESTED TABLE'       , 'nesttab',
                                        'ROLLBACK'           , 'rbk'    ,
                                        'SYSTEM STATISTICS'  , 'sysstat',
                                        'TABLE'              , 'tab'    ,
                                        'TABLE PARTITION'    , 'tabpart',
                                        'TABLE SUBPARTITION' , 'tabsubp',
                                        'TYPE2 UNDO'         , 'undo'   ,
                                        lower(seg.segment_type));
