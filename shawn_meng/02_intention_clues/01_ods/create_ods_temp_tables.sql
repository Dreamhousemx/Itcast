-- 客户意向表
-- 第一步: 创建一张客户意向表的临时表
CREATE TABLE IF NOT EXISTS itcast_ods.`customer_relationship_temp`
(
    `id`                          int COMMENT '客户关系id',
    `create_date_time`            STRING COMMENT '创建时间',
    `update_date_time`            STRING COMMENT '最后更新时间',
    `deleted`                     int COMMENT '是否被删除（禁用）',
    `customer_id`                 int COMMENT '所属客户id',
    `first_id`                    int COMMENT '第一条客户关系id',
    `belonger`                    int COMMENT '归属人',
    `belonger_name`               STRING COMMENT '归属人姓名',
    `initial_belonger`            int COMMENT '初始归属人',
    `distribution_handler`        int COMMENT '分配处理人',
    `business_scrm_department_id` int COMMENT '归属部门',
    `last_visit_time`             STRING COMMENT '最后回访时间',
    `next_visit_time`             STRING COMMENT '下次回访时间',
    `origin_type`                 STRING COMMENT '数据来源',
    `itcast_school_id`            int COMMENT '校区Id',
    `itcast_subject_id`           int COMMENT '学科Id',
    `intention_study_type`        STRING COMMENT '意向学习方式',
    `anticipat_signup_date`       STRING COMMENT '预计报名时间',
    `level`                       STRING COMMENT '客户级别',
    `creator`                     int COMMENT '创建人',
    `current_creator`             int COMMENT '当前创建人：初始==创建人，当在公海拉回时为 拉回人',
    `creator_name`                STRING COMMENT '创建者姓名',
    `origin_channel`              STRING COMMENT '来源渠道',
    `comment`                     STRING COMMENT '备注',
    `first_customer_clue_id`      int COMMENT '第一条线索id',
    `last_customer_clue_id`       int COMMENT '最后一条线索id',
    `process_state`               STRING COMMENT '处理状态',
    `process_time`                STRING COMMENT '处理状态变动时间',
    `payment_state`               STRING COMMENT '支付状态',
    `payment_time`                STRING COMMENT '支付状态变动时间',
    `signup_state`                STRING COMMENT '报名状态',
    `signup_time`                 STRING COMMENT '报名时间',
    `notice_state`                STRING COMMENT '通知状态',
    `notice_time`                 STRING COMMENT '通知状态变动时间',
    `lock_state`                  STRING COMMENT '锁定状态',
    `lock_time`                   STRING COMMENT '锁定状态修改时间',
    `itcast_clazz_id`             int COMMENT '所属ems班级id',
    `itcast_clazz_time`           STRING COMMENT '报班时间',
    `payment_url`                 STRING COMMENT '付款链接',
    `payment_url_time`            STRING COMMENT '支付链接生成时间',
    `ems_student_id`              int COMMENT 'ems的学生id',
    `delete_reason`               STRING COMMENT '删除原因',
    `deleter`                     int COMMENT '删除人',
    `deleter_name`                STRING COMMENT '删除人姓名',
    `delete_time`                 STRING COMMENT '删除时间',
    `course_id`                   int COMMENT '课程ID',
    `course_name`                 STRING COMMENT '课程名称',
    `delete_comment`              STRING COMMENT '删除原因说明',
    `close_state`                 STRING COMMENT '关闭装填',
    `close_time`                  STRING COMMENT '关闭状态变动时间',
    `appeal_id`                   int COMMENT '申诉id',
    `tenant`                      int COMMENT '租户',
    `total_fee`                   DECIMAL COMMENT '报名费总金额',
    `belonged`                    int COMMENT '小周期归属人',
    `belonged_time`               STRING COMMENT '归属时间',
    `belonger_time`               STRING COMMENT '归属时间',
    `transfer`                    int COMMENT '转移人',
    `transfer_time`               STRING COMMENT '转移时间',
    `follow_type`                 int COMMENT '分配类型，0-自动分配，1-手动分配，2-自动转移，3-手动单个转移，4-手动批量转移，5-公海领取',
    `transfer_bxg_oa_account`     STRING COMMENT '转移到博学谷归属人OA账号',
    `transfer_bxg_belonger_name`  STRING COMMENT '转移到博学谷归属人OA姓名',
    `end_time`                    STRING COMMENT '有效截止时间'
)
    comment '客户关系表'
    PARTITIONED BY (start_time STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    stored as orc
    TBLPROPERTIES ('orc.compress' = 'ZLIB');

-- -- 第二步: 编写sqoop命令 将数据导入到临时表
-- sqoop import \
-- --connect jdbc:mysql://192.168.52.150:3306/scrm \
-- --username root \
-- --password 123456 \
-- --query 'SELECT
--   *, "9999-12-31" as end_time , "2021-09-27" AS start_time
-- FROM customer_relationship where 1=1 and $CONDITIONS' \
-- --hcatalog-database itcast_ods \
-- --hcatalog-table customer_relationship_temp \
-- -m 1
--
-- -- 第三步: 执行 insert into + select 导入到目标表
-- -- 动态分区配置
-- set hive.exec.dynamic.partition=true;
-- set hive.exec.dynamic.partition.mode=nonstrict;
-- -- hive压缩
-- set hive.exec.compress.intermediate=true;
-- set hive.exec.compress.output=true;
-- -- 写入时压缩生效
-- set hive.exec.orc.compression.strategy=COMPRESSION;
--
-- insert into table itcast_ods.customer_relationship partition(start_time)
-- select * from itcast_ods.customer_relationship_temp;


-- 第一步: 创建客户线索表的临时表
CREATE TABLE IF NOT EXISTS itcast_ods.customer_clue_temp
(
    id                       int COMMENT 'customer_clue_id',
    create_date_time         STRING COMMENT '创建时间',
    update_date_time         STRING COMMENT '最后更新时间',
    deleted                  STRING COMMENT '是否被删除（禁用）',
    customer_id              int COMMENT '客户id',
    customer_relationship_id int COMMENT '客户关系id',
    session_id               STRING COMMENT '七陌会话id',
    sid                      STRING COMMENT '访客id',
    status                   STRING COMMENT '状态（undeal待领取 deal 已领取 finish 已关闭 changePeer 已流转）',
    users                    STRING COMMENT '所属坐席',
    create_time              STRING COMMENT '七陌创建时间',
    platform                 STRING COMMENT '平台来源 （pc-网站咨询|wap-wap咨询|sdk-app咨询|weixin-微信咨询）',
    s_name                   STRING COMMENT '用户名称',
    seo_source               STRING COMMENT '搜索来源',
    seo_keywords             STRING COMMENT '关键字',
    ip                       STRING COMMENT 'IP地址',
    referrer                 STRING COMMENT '上级来源页面',
    from_url                 STRING COMMENT '会话来源页面',
    landing_page_url         STRING COMMENT '访客着陆页面',
    url_title                STRING COMMENT '咨询页面title',
    to_peer                  STRING COMMENT '所属技能组',
    manual_time              STRING COMMENT '人工开始时间',
    begin_time               STRING COMMENT '坐席领取时间 ',
    reply_msg_count          int COMMENT '客服回复消息数',
    total_msg_count          int COMMENT '消息总数',
    msg_count                int COMMENT '客户发送消息数',
    comment                  STRING COMMENT '备注',
    finish_reason            STRING COMMENT '结束类型',
    finish_user              STRING COMMENT '结束坐席',
    end_time                 STRING COMMENT '会话结束时间',
    platform_description     STRING COMMENT '客户平台信息',
    browser_name             STRING COMMENT '浏览器名称',
    os_info                  STRING COMMENT '系统名称',
    area                     STRING COMMENT '区域',
    country                  STRING COMMENT '所在国家',
    province                 STRING COMMENT '省',
    city                     STRING COMMENT '城市',
    creator                  int COMMENT '创建人',
    name                     STRING COMMENT '客户姓名',
    idcard                   STRING COMMENT '身份证号',
    phone                    STRING COMMENT '手机号',
    itcast_school_id         int COMMENT '校区Id',
    itcast_school            STRING COMMENT '校区',
    itcast_subject_id        int COMMENT '学科Id',
    itcast_subject           STRING COMMENT '学科',
    wechat                   STRING COMMENT '微信',
    qq                       STRING COMMENT 'qq号',
    email                    STRING COMMENT '邮箱',
    gender                   STRING COMMENT '性别',
    level                    STRING COMMENT '客户级别',
    origin_type              STRING COMMENT '数据来源渠道',
    information_way          STRING COMMENT '资讯方式',
    working_years            STRING COMMENT '开始工作时间',
    technical_directions     STRING COMMENT '技术方向',
    customer_state           STRING COMMENT '当前客户状态',
    valid                    STRING COMMENT '该线索是否是网资有效线索',
    anticipat_signup_date    STRING COMMENT '预计报名时间',
    clue_state               STRING COMMENT '线索状态',
    scrm_department_id       int COMMENT 'SCRM内部部门id',
    superior_url             STRING COMMENT '诸葛获取上级页面URL',
    superior_source          STRING COMMENT '诸葛获取上级页面URL标题',
    landing_url              STRING COMMENT '诸葛获取着陆页面URL',
    landing_source           STRING COMMENT '诸葛获取着陆页面URL来源',
    info_url                 STRING COMMENT '诸葛获取留咨页URL',
    info_source              STRING COMMENT '诸葛获取留咨页URL标题',
    origin_channel           STRING COMMENT '投放渠道',
    course_id                int COMMENT '课程编号',
    course_name              STRING COMMENT '课程名称',
    zhuge_session_id         STRING COMMENT 'zhuge会话id',
    is_repeat                int COMMENT '是否重复线索(手机号维度) 0:正常 1：重复',
    tenant                   int COMMENT '租户id',
    activity_id              STRING COMMENT '活动id',
    activity_name            STRING COMMENT '活动名称',
    follow_type              int COMMENT '分配类型，0-自动分配，1-手动分配，2-自动转移，3-手动单个转移，4-手动批量转移，5-公海领取',
    shunt_mode_id            int COMMENT '匹配到的技能组id',
    shunt_employee_group_id  int COMMENT '所属分流员工组',
    ends_time                STRING COMMENT '有效时间'
)
    comment '客户关系表'
    PARTITIONED BY (starts_time STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    stored as orc
    TBLPROPERTIES ('orc.compress' = 'ZLIB');

-- -- 第二步: 编写sqoop命令 将数据导入到临时表
-- sqoop import \
-- --connect jdbc:mysql://192.168.52.150:3306/scrm \
-- --username root \
-- --password 123456 \
-- --query 'SELECT
--   id,create_date_time,update_date_time,deleted,customer_id,customer_relationship_id,session_id,sid,status,user as users,create_time,platform,s_name,seo_source,seo_keywords,ip,referrer,from_url,landing_page_url,url_title,to_peer,manual_time,begin_time,reply_msg_count,total_msg_count,msg_count,comment,finish_reason,finish_user,end_time,platform_description,browser_name,os_info,area,country,province,city,creator,name,"-1" as idcard,"-1" as phone,itcast_school_id,itcast_school,itcast_subject_id,itcast_subject,"-1" as wechat,"-1" as qq,"-1" as email,gender,level,origin_type,information_way,working_years,technical_directions,customer_state,valid,anticipat_signup_date,clue_state,scrm_department_id,superior_url,superior_source,landing_url,landing_source,info_url,info_source,origin_channel,course_id,course_name,zhuge_session_id,is_repeat,tenant,activity_id,activity_name,follow_type,shunt_mode_id,shunt_employee_group_id, "9999-12-31" as ends_time , "2021-09-27" AS starts_time
-- FROM customer_clue where 1=1 and $CONDITIONS' \
-- --hcatalog-database itcast_ods \
-- --hcatalog-table customer_clue_temp \
-- -m 1
--
-- -- 第三步:  通过 insert into + select 导入到目标表
-- insert into table itcast_ods.customer_clue partition(starts_time)
-- select * from itcast_ods.customer_clue_temp;