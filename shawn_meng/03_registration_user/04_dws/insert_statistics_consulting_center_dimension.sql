-- 统计每年线上线下, 新老用户产生各个咨询中心的意向量
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
       tdepart_id,
       tdepart_name,
       yearinfo                    as time_str,
       '5'                         as grouptype,
       '5'                         as time_type,
       yearinfo,
       '-1'                        as monthinfo,
       '-1'                        as dayinfo
from itcast_dwm.itcast_intention_dwm
group by yearinfo, origin_type_stat, clue_state_stat, tdepart_id, tdepart_name;