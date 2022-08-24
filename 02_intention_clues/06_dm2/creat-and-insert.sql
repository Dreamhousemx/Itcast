create database zh_dm;
create table zh_dm.itcast_clue_dm(
    time_type string comment '时间类型',
    -- 维度
    year_code string comment '年',
    month_code string comment '月',
    day_code string comment '日',
    hour_code string comment '小时',
    origin_type                 string comment '数据来源',-- 线上，线下('NETSERVICE') #线上（排除挖掘录入量） 其他'OTHER'都是线下
    clue_state                  string comment '线索状态', -- 新旧客户
    -- 指标
    new_effective_clue bigint comment '新客户有效线索',
    new_up_effective_clue bigint comment '新客户线上有效线索',
    new_down_effective_clue bigint comment '新客户线下有效线索',
    old_effective_clue bigint comment '老客户有效线索',
    old_up_effective_clue bigint comment '老客户线上有效线索',
    old_down_effective_clue bigint comment '老客户线下有效线索',
    all_effective_clue bigint comment '所有有效线索',
    all_clue bigint comment '所有线索',
    Effective_lead_conversion_rate decimal(27,4) comment '有效线索转化率'
)COMMENT '线索数据宽表'
row format delimited fields terminated by '\t'
stored as orc
tblproperties ('orc.compress' = 'SNAPPY');



create table zh_dm.hour_clue_dm(
    hour_code string comment '小时段',
    effective_clue bigint comment '有效线索',
    consultation bigint comment '咨询量',
    Conversion_rate decimal(27,4) comment '转化率'
)COMMENT '线索数据宽表'
row format delimited fields terminated by '\t'
stored as orc
tblproperties ('orc.compress' = 'SNAPPY');

insert into zh_dm.itcast_clue_dm
select  * from
(select
       -- 时间类型
       case when grouping(year_code,month_code,day_code,hour_code) = 0
                    then 'hour'
            when grouping(year_code,month_code,day_code) = 0
                    then 'day'
            when grouping(year_code,month_code) = 0
                    then 'month'
            when grouping(year_code) = 0
                    then 'year'
            end as time_type,
       -- 维度
       year_code ,
       month_code,
       day_code ,
       hour_code,
       case when origin_type in ('NETSERVICE') then '线上'
           else '线下'
           end as origin_type, -- 来源（线上，线下）
       case when clue_state in ('VALID_NEW_CLUES') then '新客户新线索'
           when clue_state in ('VALID_PUBLIC_NEW_CLUE') then '老客户新线索'
           else '无效线索'
           end as clue_state ,  -- 状态（新，旧）
       -- 指标
       count(new_effective_clue) ,
       count(new_up_effective_clue) ,
       count(new_down_effective_clue),
       count(old_effective_clue) ,
       count(old_up_effective_clue),
       count(old_down_effective_clue) ,
       count(all_effective_clue),
       count(customer_relationship_id),  -- 有效线索比所有线索
       count(all_effective_clue)/(count(customer_relationship_id)*1.0000)
from zh_dws.itcast_clue_dws
group by
grouping sets (
               -- 年
               (year_code),(year_code,origin_type),(year_code,clue_state),(year_code,origin_type,clue_state),
               -- 月
               (year_code,month_code),(year_code,month_code,origin_type),(year_code,month_code,clue_state),(year_code,month_code,origin_type,clue_state),
               -- 日
               (year_code,month_code,day_code),(year_code,month_code,day_code,origin_type),(year_code,month_code,day_code,clue_state),(year_code,month_code,day_code,origin_type,clue_state),
               -- 小时
               (year_code,month_code,day_code,hour_code),(year_code,month_code,day_code,hour_code,origin_type),(year_code,month_code,day_code,hour_code,clue_state),(year_code,month_code,day_code,hour_code,origin_type,clue_state)
)
);

insert into zh_dm.hour_clue_dm
with t1 as (
SELECT
hour_code,
count(1) as hour_code_num
FROM zh_dws.itcast_clue_dws
where clue_state in ('VALID_NEW_CLUES','VALID_PUBLIC_NEW_CLUE')
group by hour_code
),
t2 as (
select substring(create_time,12,2) as all_hour_code,
       count(1) as all_hour_code_num
from zh_ods.nev_web_chat_ems_2019_07
group by substring(create_time,12,2)
)
select  t2.all_hour_code,
        coalesce (hour_code_num,0) as hour_num_1,
        all_hour_code_num as hour_num_2,
        coalesce (hour_code_num,0)/(all_hour_code_num*1.0000)
from t2 left join t1 on t2.all_hour_code=t1.hour_code
order by t2.all_hour_code;



with t1 as (
select
substring (create_time,1,4) as year_code,
substring (create_time,6,2) as month_code,
substring (create_time,9,2) as day_code,
substring (create_time,12,2) as hour_code
from zh_ods.nev_web_chat_ems_2019_07
)
select
 t1.year_code,
 t1.month_code,
 t1.day_code,
 t1.hour_code,
count(1) as zixunshu from t1
group by
grouping sets (
year_code,
(year_code,month_code),
(year_code,month_code,day_code ),
(year_code,month_code,day_code,hour_code)
);