-- 在DWD层的基础上，按照业务的要求进行统计分析；时间和业务属性三个维度分类，可以在模型中增加对应的属性标识：
-- 时间维度：1.年、2.季度、3.月、4.天、5.小时
-- 业务属性维度：1.地区、2.来源渠道、3.搜索来源、4.会话来源页面、5.总访问量
DROP DATABASE IF EXISTS `itcast_dws`;
CREATE DATABASE IF NOT EXISTS `itcast_dws`;
-- 访问量统计结果表
CREATE TABLE IF NOT EXISTS itcast_dws.visit_dws
(
    sid_total       INT COMMENT '根据sid去重求count',
    sessionid_total INT COMMENT '根据sessionid去重求count',
    ip_total        INT COMMENT '根据IP去重求count',
    area            STRING COMMENT '区域信息',
    seo_source      STRING COMMENT '搜索来源',
    origin_channel  STRING COMMENT '来源渠道',
    hourinfo        STRING COMMENT '创建时间，统计至小时',
    time_str        STRING COMMENT '时间明细',
    from_url        STRING comment '会话来源页面',
    groupType       STRING COMMENT '产品属性类型：1.地区；2.搜索来源；3.来源渠道；4.会话来源页面；5.总访问量',
    time_type       STRING COMMENT '时间聚合类型：1、按小时聚合；2、按天聚合；3、按月聚合；4、按季度聚合；5、按年聚合；'
)
    comment 'EMS访客日志dws表'
    PARTITIONED BY (yearinfo STRING,quarterinfo STRING,monthinfo STRING,dayinfo STRING)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
    stored as orc
    location '/user/hive/warehouse/itcast_dws.db/visit_dws'
    TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- 咨询量统计结果表
CREATE TABLE IF NOT EXISTS itcast_dws.consult_dws
(
    sid_total       INT COMMENT '根据sid去重求count',
    sessionid_total INT COMMENT '根据sessionid去重求count',
    ip_total        INT COMMENT '根据IP去重求count',
    area            STRING COMMENT '区域信息',
    origin_channel  STRING COMMENT '来源渠道',
    hourinfo        STRING COMMENT '创建时间，统计至小时',
    time_str        STRING COMMENT '时间明细',
    groupType       STRING COMMENT '产品属性类型：1.地区；2.来源渠道',
    time_type       STRING COMMENT '时间聚合类型：1、按小时聚合；2、按天聚合；3、按月聚合；4、按季度聚合；5、按年聚合；'
)
    COMMENT '咨询量DWS宽表'
    PARTITIONED BY (yearinfo string,quarterinfo STRING, monthinfo STRING, dayinfo string)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    STORED AS ORC
    LOCATION '/user/hive/warehouse/itcast_dws.db/consult_dws'
    TBLPROPERTIES ('orc.compress' = 'SNAPPY');