--年,新老客户,线上线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    dayinfo            as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type, clue_state)
         select sum(customer_id1) as customer_id,
                'null'            as area,
                'null'            as xk_id,
                'null'            as xk_name,
                'null'            as xq_id,
                'null'            as xq_name,
                'null'            as origin_type,
                'null'            as tdepart_id,
                'null'            as tdepart_name,
                origin_type_stat,
                clue_state,
                yearinfo          as str_time,
                '4'               as time_type,
                '1'               as group_type,
                yearinfo,
                'null'            as monthinfo,
                'null'            as dayinfo,
                'null'            as hourinfo
         from t1_total_vis2its
         group by yearinfo, origin_type_stat, clue_state
     );

-- 年,月,新老客户,线上线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    'null'            as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type, clue_state)
         select sum(customer_id1)                    as customer_id,
                'null'                               as area,
                'null'                               as xk_id,
                'null'                               as xk_name,
                'null'                               as xq_id,
                'null'                               as xq_name,
                'null'                               as origin_type,
                'null'                               as tdepart_id,
                'null'                               as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo,'-' ,monthinfo) as str_time,
                '3'                                  as time_type,
                '1'                                  as group_type,
                yearinfo,
                monthinfo,
                'null'                               as dayinfo,
                'null'                               as hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, origin_type_stat, clue_state);
-- 年,月,日新老客户,线上线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    dayinfo            as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type, clue_state)
         select sum(customer_id1)                    as customer_id,
                'null'                               as area,
                'null'                               as xk_id,
                'null'                               as xk_name,
                'null'                               as xq_id,
                'null'                               as xq_name,
                'null'                               as origin_type,
                'null'                               as tdepart_id,
                'null'                               as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo,'-',monthinfo,'-',dayinfo) as str_time,
                '2'                                  as time_type,
                '1'                                  as group_type,
                yearinfo,
                monthinfo,
                dayinfo,
                'null'                               as hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, dayinfo, origin_type_stat, clue_state);

-- 年,月,日,小时,新老客户,线上线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    'null'             as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type, clue_state)
         select sum(customer_id1)                              as customer_id,
                'null'                                         as area,
                'null'                                         as xk_id,
                'null'                                         as xk_name,
                'null'                                         as xq_id,
                'null'                                         as xq_name,
                'null'                                         as origin_type,
                'null'                                         as tdepart_id,
                'null'                                         as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo,'-' ,monthinfo,'-' ,dayinfo,' ',hourinfo) as str_time,
                '1'                                            as time_type,
                '1'                                            as group_type,
                yearinfo,
                monthinfo,
                dayinfo,
                hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, dayinfo,hourinfo, origin_type_stat, clue_state);



--意向学员位置热力图
--年,地区,新老客户,线上线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    yearinfo           as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    'null'             as monthinfo,
                    'null'             as dayinfo,
                    'null'             as hourinfo
             from zh_dwm.itcast_intention_dwm
             group by customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type, clue_state)
         select sum(customer_id1) as customer_id,
                area,
                'null'            as xk_id,
                'null'            as xk_name,
                'null'            as xq_id,
                'null'            as xq_name,
                'null'            as origin_type,
                'null'            as tdepart_id,
                'null'            as tdepart_name,
                origin_type_stat,
                clue_state,
                yearinfo          as str_time,
                '4'               as time_type,
                '2'               as group_type,
                yearinfo,
                'null'            as monthinfo,
                'null'            as dayinfo,
                'null'            as hourinfo
         from t1_total_vis2its
         group by yearinfo, area, origin_type_stat, clue_state);
--年,月 地区,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    dayinfo            as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type, clue_state)
         select sum(customer_id1)           as customer_id,
                area,
                'null'                      as xk_id,
                'null'                      as xk_name,
                'null'                      as xq_id,
                'null'                      as xq_name,
                'null'                      as origin_type,
                'null'                      as tdepart_id,
                'null'                      as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo,'-', monthinfo) as str_time,
                '3'                         as time_type,
                '2'                         as group_type,
                yearinfo,
                monthinfo,
                'null'                      as dayinfo,
                'null'                      as hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, area, origin_type_stat, clue_state);
--年,月 ,日,地区,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    dayinfo            as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type, clue_state)
         select sum(customer_id1)           as customer_id,
                area,
                'null'                      as xk_id,
                'null'                      as xk_name,
                'null'                      as xq_id,
                'null'                      as xq_name,
                'null'                      as origin_type,
                'null'                      as tdepart_id,
                'null'                      as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo,'-', monthinfo,'-',dayinfo) as str_time,
                '2'                         as time_type,
                '2'                         as group_type,
                yearinfo,
                monthinfo,
                dayinfo,
                'null'                      as hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, dayinfo, area, origin_type_stat, clue_state);

--年,月 ,日,小时,地区,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    dayinfo            as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type, clue_state)
         select sum(customer_id1)                                             as customer_id,
                area,
                'null'                                                        as xk_id,
                'null'                                                        as xk_name,
                'null'                                                        as xq_id,
                'null'                                                        as xq_name,
                'null'                                                        as origin_type,
                'null'                                                        as tdepart_id,
                'null'                                                        as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo, '-', monthinfo, '-', dayinfo, ' ', hourinfo) as str_time,
                '1'                                                           as time_type,
                '2'                                                           as group_type,
                yearinfo,
                monthinfo,
                dayinfo,
                hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, dayinfo, hourinfo, area, origin_type_stat, clue_state);

--意向学科排名

--年,学科id,学科名称,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    'null'             as area,
                    itcast_subject_id  as xk_id,
                    name_xk            as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    yearinfo           as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    'null'             as monthinfo,
                    'null'             as dayinfo,
                    'null'             as hourinfo
             from zh_dwm.itcast_intention_dwm
             group by itcast_subject_id, name_xk, customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type,
                      area, origin_type, clue_state)
         select sum(customer_id1) as customer_id,
                'null'            as area,
                xk_id,
                xk_name,
                'null'            as xq_id,
                'null'            as xq_name,
                'null'            as origin_type,
                'null'            as tdepart_id,
                'null'            as tdepart_name,
                origin_type_stat,
                clue_state,
                yearinfo          as str_time,
                '4'               as time_type,
                '3'               as group_type,
                yearinfo,
                'null'            as monthinfo,
                'null'            as dayinfo,
                'null'            as hourinfo
         from t1_total_vis2its
         group by yearinfo, origin_type_stat, clue_state, xk_id, xk_name);

--年,月,学科id,学科名称,新老客户,线下线下

--意向校区排名
--年,学区id,学区名称,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    'null'             as area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    itcast_school_id   as xq_id,
                    itcast_school      as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    yearinfo           as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by itcast_school_id, itcast_school, customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type,
                      area, origin_type, clue_state)
         select sum(customer_id1) as customer_id,
                'null'            as area,
                'null'            as xk_id,
                'null'            as xk_name,
                xq_id,
                xq_name,
                'null'            as origin_type,
                'null'            as tdepart_id,
                'null'            as tdepart_name,
                origin_type_stat,
                clue_state,
                yearinfo          as str_time,
                '4'               as time_type,
                '4'               as group_type,
                yearinfo,
                'null'            as monthinfo,
                'null'            as dayinfo,
                'null'            as hourinfo
         from t1_total_vis2its
         group by yearinfo, origin_type_stat, clue_state, xq_id, xq_name);


--年,月,学区id,学区名称,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    'null'             as area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    itcast_school_id   as xq_id,
                    itcast_school      as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    yearinfo           as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by itcast_school_id, itcast_school, customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type,
                      area, origin_type, clue_state)
         select sum(customer_id1)                as customer_id,
                'null'                           as area,
                'null'                           as xk_id,
                'null'                           as xk_name,
                xq_id,
                xq_name,
                'null'                           as origin_type,
                'null'                           as tdepart_id,
                'null'                           as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo, '-', monthinfo) as str_time,
                '3'                              as time_type,
                '4'                              as group_type,
                yearinfo,
                monthinfo,
                'null'                           as dayinfo,
                'null'                           as hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, origin_type_stat, clue_state, xq_id, xq_name);
--年,月,日,学区id,学区名称,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    'null'             as area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    itcast_school_id   as xq_id,
                    itcast_school      as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    yearinfo           as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by itcast_school_id, itcast_school, customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type,
                      area, origin_type, clue_state)
         select sum(customer_id1)                as customer_id,
                'null'                           as area,
                'null'                           as xk_id,
                'null'                           as xk_name,
                xq_id,
                xq_name,
                'null'                           as origin_type,
                'null'                           as tdepart_id,
                'null'                           as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo, '-', monthinfo,'-',dayinfo) as str_time,
                '2'                              as time_type,
                '4'                              as group_type,
                yearinfo,
                monthinfo,
                dayinfo,
                'null'                           as hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, dayinfo, origin_type_stat, clue_state, xq_id, xq_name);

--年,月,日,小时,学区id,学区名称,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    'null'             as area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    itcast_school_id   as xq_id,
                    itcast_school      as xq_name,
                    'null'             as origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    yearinfo           as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by itcast_school_id, itcast_school, customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type,
                      area, origin_type, clue_state)
         select sum(customer_id1)                as customer_id,
                'null'                           as area,
                'null'                           as xk_id,
                'null'                           as xk_name,
                xq_id,
                xq_name,
                'null'                           as origin_type,
                'null'                           as tdepart_id,
                'null'                           as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo, '-', monthinfo,'-', dayinfo,'-', hourinfo) as str_time,
                '1'                              as time_type,
                '4'                              as group_type,
                yearinfo,
                monthinfo,
                dayinfo,
                hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, dayinfo, hourinfo, origin_type_stat, clue_state, xq_id, xq_name);


--
--来源渠道占比
--年,来源渠道,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    'null'             as area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    yearinfo           as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by origin_type, customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type,
                      clue_state)
         select sum(customer_id1) as customer_id,
                'null'            as area,
                'null'            as xk_id,
                'null'            as xk_name,
                'null'            as xq_id,
                'null '           as xq_name,
                origin_type,
                'null'            as tdepart_id,
                'null'            as tdepart_name,
                origin_type_stat,
                clue_state,
                yearinfo          as str_time,
                '4'               as time_type,
                '5'               as group_type,
                yearinfo,
                'null'            as monthinfo,
                'null'            as dayinfo,
                'null'            as hourinfo
         from t1_total_vis2its
         group by yearinfo, origin_type_stat, clue_state, origin_type);

--年,月,来源渠道,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    'null'             as area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    concat(yearinfo,'-',monthinfo)           as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by origin_type, customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type,
                      clue_state)
         select sum(customer_id1) as customer_id,
                'null'            as area,
                'null'            as xk_id,
                'null'            as xk_name,
                'null'            as xq_id,
                'null '           as xq_name,
                origin_type,
                'null'            as tdepart_id,
                'null'            as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo,'-',monthinfo)          as str_time,
                '3'               as time_type,
                '5'               as group_type,
                yearinfo,
                monthinfo,
                'null'            as dayinfo,
                'null'            as hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, origin_type_stat, clue_state, origin_type);

--年,月,日,来源渠道,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    'null'             as area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    yearinfo           as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by origin_type, customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type,
                      clue_state)
         select sum(customer_id1) as customer_id,
                'null'            as area,
                'null'            as xk_id,
                'null'            as xk_name,
                'null'            as xq_id,
                'null '           as xq_name,
                origin_type,
                'null'            as tdepart_id,
                'null'            as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo,'-',monthinfo,'-',dayinfo)          as str_time,
                '2'               as time_type,
                '5'               as group_type,
                yearinfo,
                monthinfo,
                dayinfo,
                'null'            as hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, dayinfo, origin_type_stat, clue_state, origin_type);

--年,月,日,小时,来源渠道,新老客户,线下线下
insert into table zh_dws.intent_dwsintention_dws partition (yearinfo, monthinfo, dayinfo, hourinfo)
select *
from (
         with t1_total_vis2its as (
             select count(customer_id) as customer_id1,
                    'null'             as area,
                    'null'             as xk_id,
                    'null'             as xk_name,
                    'null'             as xq_id,
                    'null'             as xq_name,
                    origin_type,
                    'null'             as tdepart_id,
                    'null'             as tdepart_name,
                    case
                        when origin_type = 1
                            then if(origin_type = 1, origin_type, null)
                        when origin_type = 2
                            then if(origin_type = 2, origin_type, null)
                        end            as origin_type_stat,
                    case
                        when clue_state = 'VALID_NEW_CLUES'
                            then 1
                        when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                            then 2
                        else 0
                        end            as clue_state,
                    yearinfo           as str_time,
                    '1'                as time_type,
                    'null'             as group_type,
                    yearinfo,
                    monthinfo,
                    dayinfo,
                    hourinfo
             from zh_dwm.itcast_intention_dwm
             group by origin_type, customer_id, yearinfo, monthinfo, dayinfo, hourinfo, origin_type, area, origin_type,
                      clue_state)
         select sum(customer_id1) as customer_id,
                'null'            as area,
                'null'            as xk_id,
                'null'            as xk_name,
                'null'            as xq_id,
                'null '           as xq_name,
                origin_type,
                'null'            as tdepart_id,
                'null'            as tdepart_name,
                origin_type_stat,
                clue_state,
                concat(yearinfo,'-',monthinfo,'-',dayinfo,' ',hourinfo)          as str_time,
                '1'               as time_type,
                '5'               as group_type,
                yearinfo,
                monthinfo,
                dayinfo,
                hourinfo
         from t1_total_vis2its
         group by yearinfo, monthinfo, hourinfo, dayinfo, origin_type_stat, clue_state, origin_type);



-- 意向贡献中心占比

--年, 咨询中心,新老客户,线下线下
insert into zh_dws.intent_dwsintention_dws
select * from(
with t1_total_vis2its as (
    select count(customer_id)                as customer_id1,
           'null'                                     as area,
           'null'                                     as xk_id,
           'null'                                     as xk_name,
           'null'                                     as xq_id,
           'null'                                     as xq_name,
           'null'                                     as origin_type,
           se.tdepart_id                              as tdepart_id,
           sd.name                                    as tdepart_name,
           case
               when origin_type = 1
                   then if(origin_type = 1, origin_type, null)
               when origin_type = 2
                   then if(origin_type = 2, origin_type, null)
               end                                    as origin_type_stat,
           case
               when clue_state = 'VALID_NEW_CLUES'
                   then 1
               when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                   then 2
               else 0
               end                                    as clue_state,
           `if`(yearinfo is not null, yearinfo, null) as str_time,
           '4'                                        as time_type,
           '6'                                        as group_type,
           yearinfo,
           monthinfo,
           dayinfo,
           hourinfo
    from zh_ods.scrm_department sd
             left join zh_ods.scrm_employee se
                       on sd.id = se.tdepart_id
             left join zh_dwm.itcast_intention_dwm iim on iim.id = se.tdepart_id
    where sd.deleted = 'false'
    group by yearinfo, yearinfo, monthinfo, dayinfo, hourinfo, customer_id, origin_type, clue_state, se.tdepart_id,
             sd.name
)
select
count(customer_id1) ,
'null'as area,
'null'as xk_id,
'null'as xk_name,
'null'as xq_id,
'null'as xq_name,
'null'as origin_type,
tdepart_id,
tdepart_name,
origin_type_stat,
clue_state,
yearinfo as str_time,
'4'as time_type,
 '6'  as group_type,
yearinfo,
'null'as monthinfo,
'null'as dayinfo,
'null'as hourinfo
from t1_total_vis2its
group by  yearinfo , tdepart_id,tdepart_name,origin_type_stat,clue_state);


--年,月, 咨询中心,新老客户,线下线下
insert into zh_dws.intent_dwsintention_dws
select  *from (
with t1_total_vis2its as (
    select count(customer_id)                as customer_id1,
           'null'                                     as area,
           'null'                                     as xk_id,
           'null'                                     as xk_name,
           'null'                                     as xq_id,
           'null'                                     as xq_name,
           'null'                                     as origin_type,
           se.tdepart_id                              as tdepart_id,
           sd.name                                    as tdepart_name,
           case
               when origin_type = 1
                   then if(origin_type = 1, origin_type, null)
               when origin_type = 2
                   then if(origin_type = 2, origin_type, null)
               end                                    as origin_type_stat,
           case
               when clue_state = 'VALID_NEW_CLUES'
                   then 1
               when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                   then 2
               else 0
               end                                    as clue_state,
           `if`(yearinfo is not null, yearinfo, null) as str_time,
           '3'                                        as time_type,
           '6'                                        as group_type,
           yearinfo,
           monthinfo,
           dayinfo,
           hourinfo
    from zh_ods.scrm_department sd
             left join zh_ods.scrm_employee se
                       on sd.id = se.tdepart_id
             left join zh_dwm.itcast_intention_dwm iim on iim.id = se.tdepart_id
    where sd.deleted = 'false'
    group by yearinfo, yearinfo, monthinfo, dayinfo, hourinfo, customer_id, origin_type, clue_state, se.tdepart_id,
             sd.name
)
select
count(customer_id1) ,
'null'as area,
'null'as xk_id,
'null'as xk_name,
'null'as xq_id,
'null'as xq_name,
'null'as origin_type,
tdepart_id,
tdepart_name,
origin_type_stat,
clue_state,
concat(yearinfo,'-',monthinfo) as str_time,
'3'as time_type,
 '6'  as group_type,
yearinfo,
monthinfo,
'null'as dayinfo,
'null'as hourinfo
from t1_total_vis2its
group by  yearinfo ,monthinfo, tdepart_id,tdepart_name,origin_type_stat,clue_state);


--年,月,日, 咨询中心,新老客户,线下线下
insert into zh_dws.intent_dwsintention_dws
select * from  (
with t1_total_vis2its as (
    select count(customer_id)                as customer_id1,
           'null'                                     as area,
           'null'                                     as xk_id,
           'null'                                     as xk_name,
           'null'                                     as xq_id,
           'null'                                     as xq_name,
           'null'                                     as origin_type,
           se.tdepart_id                              as tdepart_id,
           sd.name                                    as tdepart_name,
           case
               when origin_type = 1
                   then if(origin_type = 1, origin_type, null)
               when origin_type = 2
                   then if(origin_type = 2, origin_type, null)
               end                                    as origin_type_stat,
           case
               when clue_state = 'VALID_NEW_CLUES'
                   then 1
               when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                   then 2
               else 0
               end                                    as clue_state,
           'null'  as str_time,
           '2'                                        as time_type,
           '6'                                        as group_type,
           yearinfo,
           monthinfo,
           dayinfo,
           hourinfo
    from zh_ods.scrm_department sd
             left join zh_ods.scrm_employee se
                       on sd.id = se.tdepart_id
             left join zh_dwm.itcast_intention_dwm iim on iim.id = se.tdepart_id
    where sd.deleted = 'false'
    group by yearinfo, yearinfo, monthinfo, dayinfo, hourinfo, customer_id, origin_type, clue_state, se.tdepart_id,
             sd.name
)
select
count(customer_id1) ,
'null'as area,
'null'as xk_id,
'null'as xk_name,
'null'as xq_id,
'null'as xq_name,
'null'as origin_type,
tdepart_id,
tdepart_name,
origin_type_stat,
clue_state,
concat(yearinfo,'-',monthinfo,'-',dayinfo) as str_time,
'2'as time_type,
 '6'  as group_type,
yearinfo,
monthinfo,
dayinfo,
'null'as hourinfo
from t1_total_vis2its
group by  yearinfo ,monthinfo,dayinfo, tdepart_id,tdepart_name,origin_type_stat,clue_state);


--年,月,日,小时,咨询中心,新老客户,线下线下
insert into zh_dws.intent_dwsintention_dws
select *
from (
with t1_total_vis2its as (
    select count(customer_id)                as customer_id1,
           'null'                                     as area,
           'null'                                     as xk_id,
           'null'                                     as xk_name,
           'null'                                     as xq_id,
           'null'                                     as xq_name,
           'null'                                     as origin_type,
           se.tdepart_id                              as tdepart_id,
           sd.name                                    as tdepart_name,
           case
               when origin_type = 1
                   then if(origin_type = 1, origin_type, null)
               when origin_type = 2
                   then if(origin_type = 2, origin_type, null)
               end                                    as origin_type_stat,
           case
               when clue_state = 'VALID_NEW_CLUES'
                   then 1
               when clue_state = 'VALID_PUBLIC_NEW_CLUE'
                   then 2
               else 0
               end                                    as clue_state,
           'null'  as str_time,
           '2'                                        as time_type,
           '6'                                        as group_type,
           yearinfo,
           monthinfo,
           dayinfo,
           hourinfo
    from zh_ods.scrm_department sd
             left join zh_ods.scrm_employee se
                       on sd.id = se.tdepart_id
             left join zh_dwm.itcast_intention_dwm iim on iim.id = se.tdepart_id
    where sd.deleted = 'false'
    group by yearinfo, yearinfo, monthinfo, dayinfo, hourinfo, customer_id, origin_type, clue_state, se.tdepart_id,
             sd.name
)
select
count(customer_id1) ,
'null'as area,
'null'as xk_id,
'null'as xk_name,
'null'as xq_id,
'null'as xq_name,
'null'as origin_type,
tdepart_id,
tdepart_name,
origin_type_stat,
clue_state,
concat(yearinfo,'-',monthinfo,'-',dayinfo,' ',hourinfo) as str_time,
'1'as time_type,
 '6'  as group_type,
yearinfo,
monthinfo,
dayinfo,
hourinfo
from t1_total_vis2its
group by  yearinfo ,monthinfo,dayinfo,hourinfo, tdepart_id,tdepart_name,origin_type_stat,clue_state);