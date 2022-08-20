# 统计总意向量
-- 统计每年 线上线下 新老用户的总意向量
insert into table itcast_dws.itcast_intention_dws partition (yearinfo, monthinfo, dayinfo)
select count(distinct customer_id) as customer_total,
       '-1'                        as area,
       '-1'                        as itcast_school_id,
       '-1'                        as itcast_school_name,
       '-1'                        as origin_type,
       '-1'                        as itcast_subject_id,
       '-1'                        as itcast_subject_name,
       '-1'                        as hourinfo,
       origin_type_stat,
       clue_state_stat,
       '-1'                        as tdepart_id,
       '-1'                        as tdepart_name,
       yearinfo                    as time_str,
       '1'                         as grouptype,
       '5'                         as time_type,
       yearinfo,
       '-1'                        as monthinfo,
       '-1'                        as dayinfo
from itcast_dwm.itcast_intention_dwm
group by yearinfo, origin_type_stat, clue_state_stat;

-- 统计每年每月 线上线下 新老用户的总意向量
insert into table itcast_dws.itcast_intention_dws partition (yearinfo, monthinfo, dayinfo)
select count(distinct customer_id)      as customer_total,
       '-1'                             as area,
       '-1'                             as itcast_school_id,
       '-1'                             as itcast_school_name,
       '-1'                             as origin_type,
       '-1'                             as itcast_subject_id,
       '-1'                             as itcast_subject_name,
       '-1'                             as hourinfo,
       origin_type_stat,
       clue_state_stat,
       '-1'                             as tdepart_id,
       '-1'                             as tdepart_name,
       concat(yearinfo, '-', monthinfo) as time_str,
       '1'                              as grouptype,
       '4'                              as time_type,
       yearinfo,
       monthinfo,
       '-1'                             as dayinfo
from itcast_dwm.itcast_intention_dwm
group by yearinfo, monthinfo, origin_type_stat, clue_state_stat;
-- 统计每年每月每日 线上线下 新老用户的总意向量
insert into table itcast_dws.itcast_intention_dws partition (yearinfo, monthinfo, dayinfo)
select count(distinct customer_id)                    as customer_total,
       '-1'                                           as area,
       '-1'                                           as itcast_school_id,
       '-1'                                           as itcast_school_name,
       '-1'                                           as origin_type,
       '-1'                                           as itcast_subject_id,
       '-1'                                           as itcast_subject_name,
       '-1'                                           as hourinfo,
       origin_type_stat,
       clue_state_stat,
       '-1'                                           as tdepart_id,
       '-1'                                           as tdepart_name,
       concat(yearinfo, '-', monthinfo, '-', dayinfo) as time_str,
       '1'                                            as grouptype,
       '2'                                            as time_type,
       yearinfo,
       monthinfo,
       dayinfo
from itcast_dwm.itcast_intention_dwm
group by yearinfo, monthinfo, dayinfo, origin_type_stat, clue_state_stat;
-- 统计每年每月每日每小时 线上线下 新老用户的总意向量
insert into table itcast_dws.itcast_intention_dws partition (yearinfo, monthinfo, dayinfo)
select count(distinct customer_id)                                   as customer_total,
       '-1'                                                          as area,
       '-1'                                                          as itcast_school_id,
       '-1'                                                          as itcast_school_name,
       '-1'                                                          as origin_type,
       '-1'                                                          as itcast_subject_id,
       '-1'                                                          as itcast_subject_name,
       hourinfo,
       origin_type_stat,
       clue_state_stat,
       '-1'                                                          as tdepart_id,
       '-1'                                                          as tdepart_name,
       concat(yearinfo, '-', monthinfo, '-', dayinfo, ' ', hourinfo) as time_str,
       '1'                                                           as grouptype,
       '1'                                                           as time_type,
       yearinfo,
       monthinfo,
       dayinfo
from itcast_dwm.itcast_intention_dwm
group by yearinfo, monthinfo, dayinfo, hourinfo, origin_type_stat, clue_state_stat;