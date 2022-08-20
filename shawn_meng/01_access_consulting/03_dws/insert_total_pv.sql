-- 以时间为基准, 统计总访问量
-- 统计每年的总访问量
insert into table itcast_dws.visit_dws partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select count(distinct sid)        as sid_total,
       count(distinct session_id) as sessionid_total,
       count(distinct ip)         as ip_total,
       '-1'                       as area,
       '-1'                       as seo_source,
       '-1'                       as origin_channel,
       '-1'                       as hourinfo,
       yearinfo                   as time_str,
       '-1'                       as from_url,
       '5'                        as grouptype,
       '5'                        as time_type,
       yearinfo,
       '-1'                       as quarterinfo,
       '-1'                       as monthinfo,
       '-1'                       as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo;
-- 统计每年每季度的总访问量
insert into table itcast_dws.visit_dws partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select count(distinct sid)                as sid_total,
       count(distinct session_id)         as sessionid_total,
       count(distinct ip)                 as ip_total,
       '-1'                               as area,
       '-1'                               as seo_source,
       '-1'                               as origin_channel,
       '-1'                               as hourinfo,
       concat(yearinfo, '_', quarterinfo) as time_str,
       '-1'                               as from_url,
       '5'                                as grouptype,
       '4'                                as time_type,
       yearinfo,
       quarterinfo,
       '-1'                               as monthinfo,
       '-1'                               as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo;
-- 统计每年每季度每月的总访问量
insert into table itcast_dws.visit_dws partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select count(distinct sid)              as sid_total,
       count(distinct session_id)       as sessionid_total,
       count(distinct ip)               as ip_total,
       '-1'                             as area,
       '-1'                             as seo_source,
       '-1'                             as origin_channel,
       '-1'                             as hourinfo,
       concat(yearinfo, '-', monthinfo) as time_str,
       '-1'                             as from_url,
       '5'                              as grouptype,
       '3'                              as time_type,
       yearinfo,
       quarterinfo,
       monthinfo,
       '-1'                             as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo;
-- 统计每年每季度每月每天的总访问量
insert into table itcast_dws.visit_dws partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select count(distinct sid)                            as sid_total,
       count(distinct session_id)                     as sessionid_total,
       count(distinct ip)                             as ip_total,
       '-1'                                           as area,
       '-1'                                           as seo_source,
       '-1'                                           as origin_channel,
       '-1'                                           as hourinfo,
       concat(yearinfo, '-', monthinfo, '-', dayinfo) as time_str,
       '-1'                                           as from_url,
       '5'                                            as grouptype,
       '2'                                            as time_type,
       yearinfo,
       quarterinfo,
       monthinfo,
       dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo, dayinfo;
-- 统计每年每季度每月每天每小时的总访问量
insert into table itcast_dws.visit_dws partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select count(distinct sid)                                           as sid_total,
       count(distinct session_id)                                    as sessionid_total,
       count(distinct ip)                                            as ip_total,
       '-1'                                                          as area,
       '-1'                                                          as seo_source,
       '-1'                                                          as origin_channel,
       hourinfo,
       concat(yearinfo, '-', monthinfo, '-', dayinfo, ' ', hourinfo) as time_str,
       '-1'                                                          as from_url,
       '5'                                                           as grouptype,
       '1'                                                           as time_type,
       yearinfo,
       quarterinfo,
       monthinfo,
       dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo, dayinfo, hourinfo;