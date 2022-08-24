-- 将ODS层数据，进行清洗转换，并且将web_chat_ems主表和web_chat_text_ems附表的内容根据id合并在一起。数据粒度保持不变。
-- 数据清洗：空数据、不满足业务需求的数据处理。
-- 数据转换：数据格式和数据形式的转换，比如时间类型可以转换为同样的展现形式“yyyy-MM-dd HH:mm:ss”或者时间戳类型，
-- 金钱类型的数据可以统一转换为以元为单位或以分为单位的数值。
DROP DATABASE IF EXISTS `itcast_dwd` CASCADE;
CREATE DATABASE IF NOT EXISTS `itcast_dwd`;
create table if not exists itcast_dwd.visit_consult_dwd
(
    session_id           STRING comment '七陌sessionId',
    sid                  STRING comment '访客id',
    create_time          BIGINT comment '会话创建时间',
    seo_source           STRING comment '搜索来源',
    ip                   STRING comment 'IP地址',
    area                 STRING comment '地域',
    msg_count            INT comment '客户发送消息数',
    origin_channel       STRING COMMENT '来源渠道',
    referrer             STRING comment '上级来源页面',
    from_url             STRING comment '会话来源页面',
    landing_page_url     STRING comment '访客着陆页面',
    url_title            STRING comment '咨询页面title',
    platform_description STRING comment '客户平台信息',
    other_params         STRING comment '扩展字段中数据',
    history              STRING comment '历史访问记录',
    hour_info            STRING comment '小时',
    quarter_info         STRING comment '季度'
)
    comment '访问咨询DWD表'
    partitioned by (year_info String, month_info String, day_info string)
    row format delimited fields terminated by '\t'
    stored as textfile
    location '/user/hive/warehouse/itcast_dwd.db/visit_consult_dwd'
    tblproperties ('orc.compress' = 'SNAPPY');