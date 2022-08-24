-- 在DWD层的基础上，按照业务的要求进行统计分析；时间和业务属性三个维度分类，可以在模型中增加对应的属性标识：
-- 时间维度：1.年、2.季度、3.月、4.天、5.小时
-- 业务属性维度：1.地区、2.来源渠道、3.搜索来源、4.会话来源页面、5.总访问量
DROP DATABASE IF EXISTS `itcast_dws` CASCADE ;
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
    hour_info       STRING COMMENT '创建时间，统计至小时',
    quarter_info    STRING COMMENT '季度',
    time_detail     STRING COMMENT '时间明细',
    from_url        STRING comment '会话来源页面',
    cic_type        STRING COMMENT '分类聚合：1.地区 2.搜索来源 3.来源渠道 4.会话来源页面 5.总访问量',
    time_type       STRING COMMENT '时间聚合：1.按小时聚合 2.按天聚合 3.按月聚合 4.按季度聚合 5.按年聚合；'
)
    comment 'EMS访客日志dws表'
    PARTITIONED BY (year_info STRING,month_info STRING,day_info STRING)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
    stored as textfile
    location '/user/hive/warehouse/itcast_dws.db/visit_dws'
    TBLPROPERTIES ('orc.compress' = 'SNAPPY');
-- 咨询客户量
-- 客户访问量指标中，DWS层我们增加了两个标识字段：时间和业务属性。
-- 在咨询客户量指标中，我们采用同样的方式来进行统计，最后在APP层或OLAP应用中再做进一步的分组取值。
CREATE TABLE IF NOT EXISTS itcast_dws.consult_dws
(
    sid_total       INT COMMENT '根据sid去重求count',
    sessionid_total INT COMMENT '根据sessionid去重求count',
    ip_total        INT COMMENT '根据IP去重求count',
    area            STRING COMMENT '区域信息',
    origin_channel  STRING COMMENT '来源渠道',
    hour_info       STRING COMMENT '创建时间，统计至小时',
    quarter_info    STRING COMMENT '季度',
    time_detail     STRING COMMENT '时间明细',
    cic_type        STRING COMMENT '分类聚合：1.地区 2.来源渠道 3.总咨询量',
    time_type       STRING COMMENT '时间聚合：1.按小时聚合 2.按天聚合 3.按月聚合 4.按季度聚合 5.按年聚合'
)
    COMMENT '咨询量DWS宽表'
    PARTITIONED BY (year_info string, month_info STRING, day_info string)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    STORED AS textfile
    LOCATION '/user/hive/warehouse/itcast_dws.db/consult_dws'
    TBLPROPERTIES ('orc.compress' = 'SNAPPY');