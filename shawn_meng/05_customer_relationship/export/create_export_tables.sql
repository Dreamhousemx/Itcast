CREATE TABLE IF NOT EXISTS scrm_bi.itcast_intention
(
    `customer_total`      INT COMMENT '聚合意向客户数',
    `area`                varchar(100) COMMENT '区域信息',
    `itcast_school_id`    varchar(100) COMMENT '校区id',
    `itcast_school_name`  varchar(100) COMMENT '校区名称',
    `origin_type`         varchar(100) COMMENT '来源渠道',
    `itcast_subject_id`   varchar(100) COMMENT '学科id',
    `itcast_subject_name` varchar(100) COMMENT '学科名称',
    `hourinfo`            varchar(100) COMMENT '小时信息',
    `origin_type_stat`    varchar(100) COMMENT '数据来源:0.线下；1.线上',
    `clue_state_stat`     varchar(100) COMMENT '客户属性：0.老客户；1.新客户',
    `tdepart_id`          varchar(100) COMMENT '创建者部门id',
    `tdepart_name`        varchar(100) COMMENT '咨询中心名称',
    `time_str`            varchar(100) COMMENT '时间明细',
    `groupType`           varchar(100) COMMENT '产品属性类别：1.总意向量；2.区域信息；3.校区、学科组合分组；4.来源渠道；5.咨询中心;',
    `time_type`           varchar(100) COMMENT '时间维度：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；',
    yearinfo              varchar(100) COMMENT '年',
    monthinfo             varchar(100) COMMENT '月',
    dayinfo               varchar(100) COMMENT '日'
)
    comment '客户意向dws表';