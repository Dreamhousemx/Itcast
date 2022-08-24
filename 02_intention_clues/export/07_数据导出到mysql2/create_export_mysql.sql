-- 总访问量
drop table if exists mysql.zh_olap.itcast_intention_app;
CREATE TABLE mysql.zh_olap.itcast_intention_app
(
    customer_id      varchar comment '总客户量',
    area             varchar comment '区域',
    xk_id            varchar comment '学科id',
    xk_name          varchar comment '学科名字',
    xq_id            varchar comment '校区id',
    xq_name          varchar comment '校区名称',
    origin_type      varchar comment '来源渠道',
    tdepart_id       varchar comment '咨询中心_id :创建者',
    tdepart_name     varchar comment '咨询中心_名称',
    origin_type_stat varchar comment '数据来源:1-线上2-线下',
    clue_state       varchar comment '客户类型: 1-新客户,2-旧客户',
    str_time         varchar comment '时间属性:年-月-日',
    time_type        varchar comment '时间标记: 1 小时  2 天 3月  4 年',
    group_type       varchar comment '产品属性维度标记: 1.总意向量 2.意向学员位置热力图 3.意向学科排名 4.意向校区排名 5.来源渠道占比 6.意向贡献中心占比',
    yearinfo         varchar comment '年信息',
    monthinfo        varchar comment '月信息',
    dayinfo          varchar comment '日信息',
    hourinfo         varchar comment '小时信息'
);
--
insert into mysql.zh_olap.itcast_intention_app
select *
from hive.zh_dws.intent_dwsintention_dws
where group_type = '1';


-- 2.意向学员位置热力图
CREATE TABLE mysql.zh_olap.intended_thermal_student
(
    customer_id      varchar comment '总客户量',
    area             varchar comment '区域',
    xk_id            varchar comment '学科id',
    xk_name          varchar comment '学科名字',
    xq_id            varchar comment '校区id',
    xq_name          varchar comment '校区名称',
    origin_type      varchar comment '来源渠道',
    tdepart_id       varchar comment '咨询中心_id :创建者',
    tdepart_name     varchar comment '咨询中心_名称',
    origin_type_stat varchar comment '数据来源:1-线上2-线下',
    clue_state       varchar comment '客户类型: 1-新客户,2-旧客户',
    str_time         varchar comment '时间属性:年-月-日',
    time_type        varchar comment '时间标记: 1 小时  2 天 3月  4 年',
    group_type       varchar comment '产品属性维度标记: 1.总意向量 2.意向学员位置热力图 3.意向学科排名 4.意向校区排名 5.来源渠道占比 6.意向贡献中心占比',
    yearinfo         varchar comment '年信息',
    monthinfo        varchar comment '月信息',
    dayinfo          varchar comment '日信息',
    hourinfo         varchar comment '小时信息'
);
--
insert into mysql.zh_olap.intended_thermal_student
select *
from hive.zh_dws.intent_dwsintention_dws
where group_type = '2';

--  3.意向学科排名
CREATE TABLE mysql.zh_olap.intended_subject_ranking
(
    customer_id      varchar comment '总客户量',
    area             varchar comment '区域',
    xk_id            varchar comment '学科id',
    xk_name          varchar comment '学科名字',
    xq_id            varchar comment '校区id',
    xq_name          varchar comment '校区名称',
    origin_type      varchar comment '来源渠道',
    tdepart_id       varchar comment '咨询中心_id :创建者',
    tdepart_name     varchar comment '咨询中心_名称',
    origin_type_stat varchar comment '数据来源:1-线上2-线下',
    clue_state       varchar comment '客户类型: 1-新客户,2-旧客户',
    str_time         varchar comment '时间属性:年-月-日',
    time_type        varchar comment '时间标记: 1 小时  2 天 3月  4 年',
    group_type       varchar comment '产品属性维度标记: 1.总意向量 2.意向学员位置热力图 3.意向学科排名 4.意向校区排名 5.来源渠道占比 6.意向贡献中心占比',
    yearinfo         varchar comment '年信息',
    monthinfo        varchar comment '月信息',
    dayinfo          varchar comment '日信息',
    hourinfo         varchar comment '小时信息'
);
insert into mysql.zh_olap.intended_subject_ranking
select *
from hive.zh_dws.intent_dwsintention_dws
where group_type = '3';
-- 4..意向校区排名
CREATE TABLE mysql.zh_olap.intended_campus_ranking
(
    customer_id      varchar comment '总客户量',
    area             varchar comment '区域',
    xk_id            varchar comment '学科id',
    xk_name          varchar comment '学科名字',
    xq_id            varchar comment '校区id',
    xq_name          varchar comment '校区名称',
    origin_type      varchar comment '来源渠道',
    tdepart_id       varchar comment '咨询中心_id :创建者',
    tdepart_name     varchar comment '咨询中心_名称',
    origin_type_stat varchar comment '数据来源:1-线上2-线下',
    clue_state       varchar comment '客户类型: 1-新客户,2-旧客户',
    str_time         varchar comment '时间属性:年-月-日',
    time_type        varchar comment '时间标记: 1 小时  2 天 3月  4 年',
    group_type       varchar comment '产品属性维度标记: 1.总意向量 2.意向学员位置热力图 3.意向学科排名 4.意向校区排名 5.来源渠道占比 6.意向贡献中心占比',
    yearinfo         varchar comment '年信息',
    monthinfo        varchar comment '月信息',
    dayinfo          varchar comment '日信息',
    hourinfo         varchar comment '小时信息'
);
insert into mysql.zh_olap.intended_campus_ranking
select *
from hive.zh_dws.intent_dwsintention_dws
where group_type = '4';

-- 5.来源渠道占比
CREATE TABLE mysql.zh_olap.proportion_source_channels
(
    customer_id      varchar comment '总客户量',
    area             varchar comment '区域',
    xk_id            varchar comment '学科id',
    xk_name          varchar comment '学科名字',
    xq_id            varchar comment '校区id',
    xq_name          varchar comment '校区名称',
    origin_type      varchar comment '来源渠道',
    tdepart_id       varchar comment '咨询中心_id :创建者',
    tdepart_name     varchar comment '咨询中心_名称',
    origin_type_stat varchar comment '数据来源:1-线上2-线下',
    clue_state       varchar comment '客户类型: 1-新客户,2-旧客户',
    str_time         varchar comment '时间属性:年-月-日',
    time_type        varchar comment '时间标记: 1 小时  2 天 3月  4 年',
    group_type       varchar comment '产品属性维度标记: 1.总意向量 2.意向学员位置热力图 3.意向学科排名 4.意向校区排名 5.来源渠道占比 6.意向贡献中心占比',
    yearinfo         varchar comment '年信息',
    monthinfo        varchar comment '月信息',
    dayinfo          varchar comment '日信息',
    hourinfo         varchar comment '小时信息'
);
insert into mysql.zh_olap.proportion_source_channels
select *
from hive.zh_dws.intent_dwsintention_dws
where group_type = '5';
--6.意向贡献中心占比
CREATE TABLE mysql.zh_olap.proportion_intentional_contribution_centers
(
    customer_id      varchar comment '总客户量',
    area             varchar comment '区域',
    xk_id            varchar comment '学科id',
    xk_name          varchar comment '学科名字',
    xq_id            varchar comment '校区id',
    xq_name          varchar comment '校区名称',
    origin_type      varchar comment '来源渠道',
    tdepart_id       varchar comment '咨询中心_id :创建者',
    tdepart_name     varchar comment '咨询中心_名称',
    origin_type_stat varchar comment '数据来源:1-线上2-线下',
    clue_state       varchar comment '客户类型: 1-新客户,2-旧客户',
    str_time         varchar comment '时间属性:年-月-日',
    time_type        varchar comment '时间标记: 1 小时  2 天 3月  4 年',
    group_type       varchar comment '产品属性维度标记: 1.总意向量 2.意向学员位置热力图 3.意向学科排名 4.意向校区排名 5.来源渠道占比 6.意向贡献中心占比',
    yearinfo         varchar comment '年信息',
    monthinfo        varchar comment '月信息',
    dayinfo          varchar comment '日信息',
    hourinfo         varchar comment '小时信息'
);
insert into mysql.zh_olap.proportion_intentional_contribution_centers
select *
from hive.zh_dws.intent_dwsintention_dws
where group_type = '6';