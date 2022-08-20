CREATE TABLE `customer_signup_app`
(
    `signup_num`          int(11) COMMENT '报名人数',
    `itcast_school_id`    varchar(32) COMMENT '学校id',
    `itcast_school_name`  varchar(32) COMMENT '学校name',
    `itcast_subject_id`   varchar(32) COMMENT '学科id',
    `itcast_subject_name` varchar(32) COMMENT '学科name',
    `tdepart_id`          int(11) COMMENT '咨询中心id',
    `tdepart_name`        varchar(32) COMMENT '咨询中心name',
    `origin_type`         varchar(32) COMMENT '来源渠道',
    `origin_type_stat`    varchar(32) COMMENT '数据来源:0.线下；1.线上',
    `payment_time_month`  varchar(32) COMMENT '月信息',
    `payment_time_day`    varchar(32) COMMENT '日信息',
    `payment_time_hour`   varchar(32) COMMENT '最后更新时间',
    `groupType`           varchar(32) COMMENT '统计分组类型：1：校区、学科组合分组；2：来源渠道分组；3：咨询中心分组；4:所有',
    `time_type`           varchar(32) COMMENT '聚合时间类型：1、按小时聚合(；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合。',
    `payment_time_year`   varchar(32) COMMENT '年信息'
);