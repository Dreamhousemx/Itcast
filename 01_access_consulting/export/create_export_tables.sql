create database scrm_bi default character set utf8mb4 collate utf8mb4_general_ci;
CREATE TABLE mysql.scrm_bi.itcast_visit
(
    sid_total       BIGINT COMMENT '根据sid去重求count',
    sessionid_total BIGINT COMMENT '根据sessionid去重求count',
    ip_total        BIGINT COMMENT '根据IP去重求count',
    area            varchar COMMENT '区域信息',
    seo_source      varchar COMMENT '搜索来源',
    origin_channel  varchar COMMENT '来源渠道',
    hour_info        varchar COMMENT '小时信息',
    quarter_info     varchar COMMENT '季度',
    time_detail        varchar COMMENT '时间明细',
    from_url        varchar COMMENT '会话来源页面',
    cic_type       varchar COMMENT '产品属性类型：1.地区；2.搜索来源；3.来源渠道；4.会话来源页面',
    time_type       varchar COMMENT '时间聚合类型：1、按小时聚合；2、按天聚合；3、按月聚合；4、按季度聚合；5、按年聚合；',
    year_info        varchar COMMENT '年信息',
    month_info       varchar COMMENT '月信息',
    day_info         varchar COMMENT '日信息'
) comment '访问咨询结果表';

CREATE TABLE mysql.scrm_bi.itcast_consult
(
    sid_total       BIGINT COMMENT '去重并聚合sid',
    sessionid_total BIGINT COMMENT '去重并聚合sessionid',
    ip_total        BIGINT COMMENT '去重并聚合ip',
    area            varchar COMMENT '区域信息',
    origin_channel  varchar COMMENT '来源渠道',
    hour_info        varchar COMMENT '创建时间，统计至小时',
    quarter_info     varchar COMMENT '季度',
    time_detail        varchar COMMENT '时间明细',
    cic_type       varchar COMMENT '产品属性类型：1.地区；2.来源渠道',
    time_type       varchar COMMENT '时间聚合类型：1、按小时聚合；2、按天聚合；3、按月聚合；4、按季度聚合；5、按年聚合；',
    year_info        varchar COMMENT '创建时间，统计至年',
    month_info       varchar COMMENT '创建时间，统计至月',
    day_info         varchar COMMENT '创建时间，统计至天'
) COMMENT '客户咨询统计数据';