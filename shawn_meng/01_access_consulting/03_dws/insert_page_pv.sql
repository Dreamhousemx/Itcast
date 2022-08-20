-- 基于时间统计各个受访页面的访问量
-- 统计每年各个受访页面的访问量
insert into table itcast_dws.visit_dws partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select count(distinct sid)        as sid_total,
       count(distinct session_id) as sessionid_total,
       count(distinct ip)         as ip_total,
       '-1'                       as area,
       '-1'                       as seo_source,
       '-1'                       as origin_channel,
       '-1'                       as hourinfo,
       yearinfo                   as time_str,
       from_url,
       '4'                        as grouptype,
       '5'                        as time_type,
       yearinfo,
       '-1'                       as quarterinfo,
       '-1'                       as monthinfo,
       '-1'                       as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, from_url;

-- 统计每年,每季度各个受访页面的访问量
insert into table itcast_dws.visit_dws partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select count(distinct sid)                as sid_total,
       count(distinct session_id)         as sessionid_total,
       count(distinct ip)                 as ip_total,
       '-1'                               as area,
       '-1'                               as seo_source,
       '-1'                               as origin_channel,
       '-1'                               as hourinfo,
       concat(yearinfo, '_', quarterinfo) as time_str,
       from_url,
       '4'                                as grouptype,
       '4'                                as time_type,
       yearinfo,
       quarterinfo,
       '-1'                               as monthinfo,
       '-1'                               as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, from_url;

-- 统计每年,每季度,每月各个受访页面的访问量
insert into table itcast_dws.visit_dws partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select count(distinct sid)              as sid_total,
       count(distinct session_id)       as sessionid_total,
       count(distinct ip)               as ip_total,
       '-1'                             as area,
       '-1'                             as seo_source,
       '-1'                             as origin_channel,
       '-1'                             as hourinfo,
       concat(yearinfo, '-', monthinfo) as time_str,
       from_url,
       '4'                              as grouptype,
       '3'                              as time_type,
       yearinfo,
       quarterinfo,
       monthinfo,
       '-1'                             as dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo, from_url;

-- 统计每年,每季度,每月.每天各个受访页面的访问量
insert into table itcast_dws.visit_dws partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select count(distinct sid)                            as sid_total,
       count(distinct session_id)                     as sessionid_total,
       count(distinct ip)                             as ip_total,
       '-1'                                           as area,
       '-1'                                           as seo_source,
       '-1'                                           as origin_channel,
       '-1'                                           as hourinfo,
       concat(yearinfo, '-', monthinfo, '-', dayinfo) as time_str,
       from_url,
       '4'                                            as grouptype,
       '2'                                            as time_type,
       yearinfo,
       quarterinfo,
       monthinfo,
       dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo, dayinfo, from_url;
-- 统计每年,每季度,每月.每天,每小时各个受访页面的访问量
insert into table itcast_dws.visit_dws partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select count(distinct sid)                                           as sid_total,
       count(distinct session_id)                                    as sessionid_total,
       count(distinct ip)                                            as ip_total,
       '-1'                                                          as area,
       '-1'                                                          as seo_source,
       '-1'                                                          as origin_channel,
       hourinfo,
       concat(yearinfo, '-', monthinfo, '-', dayinfo, ' ', hourinfo) as time_str,
       from_url,
       '4'                                                           as grouptype,
       '1'                                                           as time_type,
       yearinfo,
       quarterinfo,
       monthinfo,
       dayinfo
from itcast_dwd.visit_consult_dwd
group by yearinfo, quarterinfo, monthinfo, dayinfo, hourinfo, from_url;