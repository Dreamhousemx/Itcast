CREATE DATABASE zh_olap DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


create table mysql.zh_olap.clue_olap
(
    time_type               varchar   comment '时间类型',
    year_code                varchar comment '年',
    month_code               varchar comment '月',
    day_code                 varchar comment '日',
    hour_code                varchar comment '小时',
    origin_type              varchar comment '数据来源',
    clue_state               varchar comment '线索状态',
    new_effective_clue       bigint comment '新客户有效线索',
    new_up_effective_clue    bigint comment '新客户线上有效线索',
    new_down_effective_clue  bigint comment '新客户线下有效线索',
    old_effective_clue       bigint comment '老客户有效线索',
    old_up_effective_clue    bigint comment '老客户线上有效线索',
    old_down_effective_clue  bigint comment '老客户线下有效线索',
    all_effective_clue       bigint comment '所有有效线索',
    all_clue         bigint comment '所有线索',
    Effective_lead_conversion_rate decimal(27,4) comment '有效线索转化率'
)COMMENT '有效线索相关数据';


create table mysql.zh_olap.hour_clue_olap(
    hour_code varchar comment '小时段',
    effective_clue bigint comment '有效线索',
    consultation bigint comment '咨询量',
    Conversion_rate decimal(27,4) comment '转化率'
)COMMENT '小时段有效线索转化率';

insert into mysql.zh_olap.hour_clue_olap
select * from hive.zh_dm.hour_clue_dm;

insert into mysql.zh_olap.clue_olap
select * from hive.zh_dm.itcast_clue_dm;