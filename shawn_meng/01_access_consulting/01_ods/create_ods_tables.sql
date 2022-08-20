-- 从咨询系统OLTP数据库的web_chat_ems_20XX_XX等月表中抽取的原始数据；
-- 离线数仓大多数的场景都是T+1，为了便于后续的DW层清洗数据时，快速获取昨天的数据，
-- ODS模型要在原始mysql表的基础之上增加starts_time抽取日期字段，并且可以使用starts_time字段分区以提升查询的性能。
DROP DATABASE IF EXISTS `itcast_ods`;
CREATE DATABASE IF NOT EXISTS `itcast_ods`;
--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;

-- 访问咨询表
CREATE EXTERNAL TABLE IF NOT EXISTS itcast_ods.web_chat_ems
(
    id                           INT comment '主键',
    create_date_time             STRING comment '数据创建时间',
    session_id                   STRING comment 'sessionId',
    sid                          STRING comment '访客id',
    create_time                  STRING comment '会话创建时间',
    seo_source                   STRING comment '搜索来源',
    seo_keywords                 STRING comment '关键字',
    ip                           STRING comment 'IP地址',
    area                         STRING comment '地域',
    country                      STRING comment '所在国家',
    province                     STRING comment '省',
    city                         STRING comment '城市',
    origin_channel               STRING comment '投放渠道',
    user_match                   STRING comment '所属坐席',
    manual_time                  STRING comment '人工开始时间',
    begin_time                   STRING comment '坐席领取时间 ',
    end_time                     STRING comment '会话结束时间',
    last_customer_msg_time_stamp STRING comment '客户最后一条消息的时间',
    last_agent_msg_time_stamp    STRING comment '坐席最后一下回复的时间',
    reply_msg_count              INT comment '客服回复消息数',
    msg_count                    INT comment '客户发送消息数',
    browser_name                 STRING comment '浏览器名称',
    os_info                      STRING comment '系统名称'
)
    comment '访问会话信息表'
    PARTITIONED BY (starts_time STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    stored as orc
    location '/user/hive/warehouse/itcast_ods.db/web_chat_ems_ods'
    TBLPROPERTIES ('orc.compress' = 'ZLIB');

-- 访问咨询附属表
CREATE EXTERNAL TABLE IF NOT EXISTS itcast_ods.web_chat_text_ems
(
    id                   INT COMMENT '主键来自MySQL',
    referrer             STRING comment '上级来源页面',
    from_url             STRING comment '会话来源页面',
    landing_page_url     STRING comment '访客着陆页面',
    url_title            STRING comment '咨询页面title',
    platform_description STRING comment '客户平台信息',
    other_params         STRING comment '扩展字段中数据',
    history              STRING comment '历史访问记录'
) comment 'EMS-PV测试表'
    PARTITIONED BY (start_time STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    stored as orc
    location '/user/hive/warehouse/itcast_ods.db/web_chat_text_ems_ods'
    TBLPROPERTIES ('orc.compress' = 'ZLIB');