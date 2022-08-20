create database scrm_bi default character set utf8mb4 collate utf8mb4_general_ci;

-- 访问量的结果表:
CREATE TABLE IF NOT EXISTS scrm_bi.visit_dws
(
    sid_total       INT COMMENT '根据sid去重求count',
    sessionid_total INT COMMENT '根据sessionid去重求count',
    ip_total        INT COMMENT '根据IP去重求count',
    area            varchar(32) COMMENT '区域信息',
    seo_source      varchar(32) COMMENT '搜索来源',
    origin_channel  varchar(32) COMMENT '来源渠道',
    hourinfo        varchar(32) COMMENT '创建时间，统计至小时',
    time_str        varchar(32) COMMENT '时间明细',
    from_url        varchar(32) comment '会话来源页面',
    groupType       varchar(32) COMMENT '产品属性类型：1.地区；2.搜索来源；3.来源渠道；4.会话来源页面；5.总访问量',
    time_type       varchar(32) COMMENT '时间聚合类型：1、按小时聚合；2、按天聚合；3、按月聚合；4、按季度聚合；5、按年聚合；',
    yearinfo        varchar(32) COMMENT '年',
    quarterinfo     varchar(32) COMMENT '季度',
    monthinfo       varchar(32) COMMENT '月',
    dayinfo         varchar(32) COMMENT '天'
) comment 'EMS访客日志dws表';

-- 咨询量的结果表:
CREATE TABLE IF NOT EXISTS scrm_bi.consult_dws
(
    sid_total       INT COMMENT '根据sid去重求count',
    sessionid_total INT COMMENT '根据sessionid去重求count',
    ip_total        INT COMMENT '根据IP去重求count',
    area            varchar(32) COMMENT '区域信息',
    origin_channel  varchar(32) COMMENT '来源渠道',
    hourinfo        varchar(32) COMMENT '创建时间，统计至小时',
    time_str        varchar(32) COMMENT '时间明细',
    groupType       varchar(32) COMMENT '产品属性类型：1.地区；2.来源渠道',
    time_type       varchar(32) COMMENT '时间聚合类型：1、按小时聚合；2、按天聚合；3、按月聚合；4、按季度聚合；5、按年聚合；',
    yearinfo        varchar(32) COMMENT '年',
    quarterinfo     varchar(32) COMMENT '季度',
    monthinfo       varchar(32) COMMENT '月',
    dayinfo         varchar(32) COMMENT '天'
) COMMENT '咨询量DWS宽表';