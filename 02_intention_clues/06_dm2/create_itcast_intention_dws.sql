drop table if exists zh_dws.itcast_intention_dws;
create table IF NOT EXISTS zh_dws.itcast_intention_dws
(
    id                          string,
    create_date_time            string,
    update_date_time            string comment '最后更新时间',
    deleted                     string comment '是否被删除（禁用） : 0-为删除 1-为未删除',
    customer_id                 string comment '所属客户id',
    first_id                    string comment '第一条客户关系id',
    belonger                    string comment '归属人',
    belonger_name               string comment '归属人姓名',
    initial_belonger            string comment '初始归属人',
    distribution_handler        string comment '分配处理人',
    business_scrm_department_id string comment '归属部门',
    last_visit_time             string comment '最后回访时间',
    next_visit_time             string comment '下次回访时间',
    origin_type                 string comment '数据来源: 线上: NETSERVICE 或者 PRESIGNUP  就是线上 线上1  否则就是线下 ,线下为2 ',
    itcast_school_id            string comment '校区Id',
    itcast_subject_id           string comment '学科Id',
    intention_study_type        string comment '意向学习方式',
    anticipat_signup_date       string comment '预计报名时间',
    level                       string comment '客户级别',
    creator                     string comment '创建人',
    current_creator             string comment '当前创建人：初始==创建人，当在公海拉回时为 拉回人',
    creator_name                string comment '创建者姓名',
    origin_channel              string comment '来源渠道',
    first_customer_clue_id      string comment '第一条线索id : 如果值为 1-则无线索  2-则为有线索 ',
    last_customer_clue_id       string comment '最后一条线索id: 如果值为 1-则无线索  2-则为有线索',
    process_state               string comment '处理状态',
    process_time                string comment '处理状态变动时间',
    signup_state                string comment '报名状态',
    signup_time                 string comment '报名时间',
    notice_state                string comment '通知状态',
    notice_time                 string comment '通知状态变动时间',
    itcast_clazz_time           string comment '报班时间',
    ems_student_id              string comment 'ems的学生id',
    course_id                   string comment '课程ID',
    course_name                 string comment '课程名称',
    belonged_time               string comment '归属时间',
    belonger_time               string comment '归属时间',
    customer_relationship_id    string comment '客户关系id',
    sid                         string comment '访客id',
    area                        string comment '区域',
    country                     string comment '所在国家',
    province                    string comment '省',
    city                        string comment '城市',
    name                        string comment '客户姓名',
    itcast_school               string comment '校区',
    itcast_subject              string comment '学科',
    gender                      string comment '性别',
    working_years               string comment '开始工作时间',
    technical_directions        string comment '技术方向',
    customer_state              string comment '当前客户状态',
    is_repeat                   string comment '是否重复线索(手机号维度) 0:正常 1：重复',
    activity_id                 string comment '活动id',
    activity_name               string comment '活动名称',
    create_date_time_gk         string comment '创建时间',
    update_date_time_gk         string comment '最后更新时间',
    area_gk                     string comment '所在区域',
    leave_school_date           string comment '离校时间',
    graduation_date             string comment '毕业时间',
    origin_type_gk              string comment '数据来源: 线上: NETSERVICE 或者 PRESIGNUP  就是线上 线上1  否则就是线下 ,线下为2 ',
    origin_channel_gk           string comment '来源渠道',
    md_id                       int comment '中台id',
    create_date_time_xq         string comment '创建时间',
    update_date_time_xq         string comment '最后更新时间',
    name_xq                     string comment '校区名称',
    code_xq                     string,
    create_date_time_xk         string comment '创建时间',
    update_date_time_xk         string comment '最后更新时间',
    name_xk                     string comment '学科名称',
    code_xk                     string,
    cross_school                string comment '是否有跨校区权限',
    last_login_date             string comment '最后登录日期',
    creator_cjr                 string comment '创建人',
    leave_office                string comment '离职状态',
    leave_office_time           string comment '离职时间',
    reinstated_time             string comment '复职时间',
    ems_user_name               string,
    name_bm                     string comment '部门名称',
    parent_id                   string comment '父部门id',
    start_time                  string comment '拉链开始时间',
    end_time                    string comment '拉链结束时间'
) comment '根据zh_dwm层进行按主题划分'
    partitioned by ( yearinfo string comment '年',
        monthinfo string comment '月',
        dayinfo string comment '日',
        hourinfo string comment '小时')
    clustered by (id) sorted by (id asc) into 10 buckets
    row format delimited fields terminated by '\t'
    stored as orc tblproperties ('orc.compression' = 'ZLIB');


create table zh_dws.zh_intention_dws
(
    customer_total      string COMMENT '聚合意向客户数',
    area                string COMMENT '区域信息',
    itcast_subject_id   string COMMENT '学科id',
    itcast_subject_name string COMMENT '学科名称',
    itcast_school_id    string COMMENT '校区id',
    itcast_school_name  string COMMENT '校区名称',
    origin_type         string COMMENT '来源渠道',
    origin_type_stat    string COMMENT '数据来源:0.线下；1.线上',
    clue_state_stat     string COMMENT '客户属性：0.老客户；1.新客户',
    tdepart_id          string COMMENT '创建者',
tdepart_name        string COMMENT '咨询中心名称',
    time_str            string COMMENT '时间明细',
    groupType           string COMMENT '产品属性类别：1.总意向量；2.区域信息；3.校区、学科组合分组；4.来源渠道；5.贡献中心;',
    time_type           string COMMENT '聚合时间类型：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合；'
)
    partitioned by (yearinfo string COMMENT '年信息',
        monthinfo string COMMENT '月信息',
        dayinfo string COMMENT '日信息',
        hourinfo string COMMENT '小时信息')
    row format delimited fields terminated by '\t';


drop table  if exists zh_dws.intention_dws ;
create table if not exists zh_dws.intent_dwsintention_dws
(
    customer_id      string comment '总客户量',
    area             string comment '区域',
    xk_id            string comment '学科id',
    xk_name          string comment '学科名字',
    xq_id            string comment '校区id',
    xq_name          string comment '校区名称',
    origin_type      string COMMENT '来源渠道',
    tdepart_id       string comment '咨询中心_id :创建者',
    tdepart_name     string comment '咨询中心_名称',
    origin_type_stat string COMMENT '数据来源:1-线上2-线下',
    clue_state       string comment '客户类型: 1-新客户,2-旧客户',
    str_time         string COMMENT '时间属性:年-月-日',
    time_type        string comment '时间标记: 1 小时  2 天 3月  4 年',
    group_type       string comment '产品属性维度标记: 1.总意向量 2.意向学员位置热力图 3.意向学科排名 4.意向校区排名 5.来源渠道占比 6.意向贡献中心占比'
)
    comment '主题需求'
    partitioned by (yearinfo string COMMENT '年信息',
        monthinfo string COMMENT '月信息',
        dayinfo string COMMENT '日信息',
        hourinfo string COMMENT '小时信息')
    row format delimited fields terminated by '\t'
    stored as orc tblproperties ('orc.compression' = 'ZLIB');




--

-- 1- 创建库
drop database if exists edu_ods;
create database if not exists edu_ods;

-- 2- 创建表:
create table if not exists edu_ods.web_chat_ems(

    id       INT            comment '主键'                  ,
    create_date_time              STRING         comment '数据创建时间'          ,
    session_id                    STRING         comment '七陌SESsionId'         ,
    sid                           STRING         comment '访客id'                ,
    create_time                   STRING         comment '会话创建时间'          ,
    seo_source                    STRING         comment '搜索来源'              ,
    seo_keywords                  STRING         comment '关键字'                ,
    ip                            STRING         comment 'IP地址'                ,
    AREA                          STRING         comment '地域'                  ,
    country                       STRING         comment '所在国家'              ,
    province                      STRING         comment '省'                    ,
    city                          STRING         comment '城市'                  ,
    origin_channel                STRING         comment '投放渠道'              ,
    `user`                          STRING         comment '所属坐席'              ,
    manual_time                   STRING         comment '人工开始时间'          ,
    begin_time                    STRING         comment '坐席领取时间'          ,
    end_time                      STRING         comment '会话结束时间'          ,
    last_customer_msg_time_stamp  STRING         comment '客户最后一条消息的时间',
    last_agent_msg_time_stamp     STRING         comment '坐席最后一下回复的时间',
    reply_msg_count               INT            comment '客服回复消息数'        ,
    msg_count                     INT            comment '客户发送消息数'        ,
    browser_name                  STRING         comment '浏览器名称'            ,
    os_info                       STRING         comment '系统名称'
)
partitioned by(dt string)
row format delimited fields terminated by '\t'
stored as orc
location 'hdfs://hadoop01:8020/user/hive/warehouse/edu_ods.db/web_chat_ems'
TBLPROPERTIES('orc.compress'='SNAPPY' );


create table if not exists edu_ods.web_chat_text_ems(
    id INT comment'主键',
    referrer string comment'上级来源页面',
    from_url string comment'会话来源页面',
    landing_page_url string comment'访客着陆页面',
    url_title string comment'咨询页面title',
    platform_description string comment'客户平台信息',
    other_params string comment'扩展字段中数据',
    history string comment'历史访问记录'
)
partitioned by(dt string)
row format delimited fields terminated by '\t'
stored as orc
location 'hdfs://hadoop01:8020/user/hive/warehouse/edu_ods.db/web_chat_text_ems'
TBLPROPERTIES('orc.compress'='SNAPPY' );


-- 1- 创建库
drop database if exists edu_dwd;
create database if not exists edu_dwd;

-- 2) 创建表
drop table if exists edu_dwd.web_chat_ems_dwd;
create table if not exists edu_dwd.web_chat_ems_dwd(

    id       INT            comment '主键'                  ,
    create_date_time              STRING         comment '数据创建时间'          ,
    session_id                    STRING         comment '七陌SESsionId'         ,
    sid                           STRING         comment '访客id'                ,
    create_time                   STRING         comment '会话创建时间'          ,
    seo_source                    STRING         comment '搜索来源'              ,
    seo_keywords                  STRING         comment '关键字'                ,
    ip                            STRING         comment 'IP地址'                ,
    AREA                          STRING         comment '地域'                  ,
    country                       STRING         comment '所在国家'              ,
    province                      STRING         comment '省'                    ,
    city                          STRING         comment '城市'                  ,
    origin_channel                STRING         comment '投放渠道'              ,
    `user`                          STRING         comment '所属坐席'              ,
    manual_time                   STRING         comment '人工开始时间'          ,
    begin_time                    STRING         comment '坐席领取时间'          ,
    end_time                      STRING         comment '会话结束时间'          ,
    last_customer_msg_time_stamp  STRING         comment '客户最后一条消息的时间',
    last_agent_msg_time_stamp     STRING         comment '坐席最后一下回复的时间',
    reply_msg_count               INT            comment '客服回复消息数'        ,
    msg_count                     INT            comment '客户发送消息数'        ,
    browser_name                  STRING         comment '浏览器名称'            ,
    os_info                       STRING         comment '系统名称'          ,
    hourinfo  string comment '小时'
)
partitioned by(yearinfo string,quarterinfo string,monthinfo string,dayinfo string)
clustered by(id) sorted by (id asc) into 10 buckets
row format delimited fields terminated by '\t'
stored as orc
location 'hdfs://hadoop01:8020/user/hive/warehouse/edu_dwd.db/web_chat_ems_dwd'
TBLPROPERTIES(
    'orc.compress'='SNAPPY' ,
    "orc.bloom.filter.columns"="id"
);

drop table if exists edu_dwd.web_chat_text_ems_dwd;
create table if not exists edu_dwd.web_chat_text_ems_dwd(
    id INT comment'主键',
    referrer string comment'上级来源页面',
    from_url string comment'会话来源页面',
    landing_page_url string comment'访客着陆页面',
    url_title string comment'咨询页面title',
    platform_description string comment'客户平台信息',
    other_params string comment'扩展字段中数据',
    history string comment'历史访问记录'
)
partitioned by(dt string)
clustered by(id) sorted by (id asc) into 10 buckets
row format delimited fields terminated by '\t'
stored as orc
location 'hdfs://hadoop01:8020/user/hive/warehouse/edu_dwd.db/web_chat_text_ems_dwd'
TBLPROPERTIES(
    'orc.compress'='SNAPPY',
    "orc.bloom.filter.columns"="id"
);


-- 创建库
drop database if exists edu_dwb;
create database if not exists edu_dwb;

-- 建表:
create table if not exists edu_dwb.web_chat_ems_dwb(
    id       INT            comment '主键'                  ,
    create_date_time              STRING         comment '数据创建时间'          ,
    session_id                    STRING         comment '七陌SESsionId'         ,
    sid                           STRING         comment '访客id'                ,
    create_time                   STRING         comment '会话创建时间'          ,
    seo_source                    STRING         comment '搜索来源'              ,
    seo_keywords                  STRING         comment '关键字'                ,
    ip                            STRING         comment 'IP地址'                ,
    AREA                          STRING         comment '地域'                  ,
    country                       STRING         comment '所在国家'              ,
    province                      STRING         comment '省'                    ,
    city                          STRING         comment '城市'                  ,
    origin_channel                STRING         comment '投放渠道'              ,
    `user`                          STRING         comment '所属坐席'              ,
    manual_time                   STRING         comment '人工开始时间'          ,
    begin_time                    STRING         comment '坐席领取时间'          ,
    end_time                      STRING         comment '会话结束时间'          ,
    last_customer_msg_time_stamp  STRING         comment '客户最后一条消息的时间',
    last_agent_msg_time_stamp     STRING         comment '坐席最后一下回复的时间',
    reply_msg_count               INT            comment '客服回复消息数'        ,
    msg_count                     INT            comment '客户发送消息数'        ,
    browser_name                  STRING         comment '浏览器名称'            ,
    os_info                       STRING         comment '系统名称'          ,
    hourinfo  string comment '小时',
    referrer string comment'上级来源页面',
    from_url string comment'会话来源页面',
    landing_page_url string comment'访客着陆页面',
    url_title string comment'咨询页面title',
    platform_description string comment'客户平台信息',
    other_params string comment'扩展字段中数据',
    history string comment'历史访问记录'

)
partitioned by(yearinfo string,quarterinfo string,monthinfo string,dayinfo string)
row format delimited fields terminated by '\t'
stored as orc
location 'hdfs://hadoop01:8020/user/hive/warehouse/edu_dwb.db/web_chat_ems_dwb'
TBLPROPERTIES('orc.compress'='SNAPPY' ,'orc.create.index'='true');

-- 1- 创建库
drop database if exists edu_dm;
create database if not exists edu_dm;

-- 2- 创建表
create table if not exists edu_dm.visit_dm(
    sid_total bigint comment '访问量',
    hourinfo string comment '小时',
    area string comment '地区维度',
    origin_channel string comment '来源渠道维度',
    seo_source string comment '搜索来源维度',
    from_url string comment '受访url',
    time_type string comment '时间标记: 1 小时  2 天 3月 4 季度 5 年',
    group_type string comment '产品属性维度标记: 1 地区  2 来源渠道 3 搜索来源 4 受访url 5总访问量'
)
partitioned by(yearinfo string,quarterinfo string,monthinfo string,dayinfo string)
row format delimited fields terminated by '\t'
stored as orc
location 'hdfs://hadoop01:8020/user/hive/warehouse/edu_dm.db/visit_dm'
TBLPROPERTIES(
    'orc.compress'='SNAPPY'
);

create table if not exists edu_dm.consult_dm(
    sid_total bigint comment '咨询量',
    hourinfo string comment '小时',
    area string comment '地区维度',
    origin_channel string comment '来源渠道维度',
    time_type string comment '时间标记: 1 小时  2 天 3月 4 季度 5 年',
    group_type string comment '产品属性维度标记: 1 地区  2 来源渠道 3总访问量'
)
partitioned by(yearinfo string,quarterinfo string,monthinfo string,dayinfo string)
row format delimited fields terminated by '\t'
stored as orc
location 'hdfs://hadoop01:8020/user/hive/warehouse/edu_dm.db/consult_dm'
TBLPROPERTIES(
    'orc.compress'='SNAPPY'
);



/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://106.75.33.59:3306/nev?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query "select *, '2022-08-21' as dt from web_chat_ems_2019_07 where 1=1 and (create_time between '1970-01-01 00:00:00' and '2022-08-21 23:59:59') and  \$CONDITIONS" \
--hcatalog-database edu_ods \
--hcatalog-table web_chat_ems \
-m 1

/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://106.75.33.59:3306/nev?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query "select t2.*, '2022-08-21' as dt from web_chat_ems_2019_07 t1 join web_chat_text_ems_2019_07 t2 on t1.id = t2.id  where 1=1 and (t1.create_time between '1970-01-01 00:00:00' and '2022-08-21 23:59:59') and  \$CONDITIONS" \
--hcatalog-database edu_ods \
--hcatalog-table web_chat_text_ems \
-m 1

/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://106.75.33.59:3306/nev?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456\
--query "select *, '2022-08-21' as dt from web_chat_ems_2019_07 where 1=1 and (create_time between '2022-08-21 00:00:00' and '2022-08-21 23:59:59') and  \$CONDITIONS" \
--hcatalog-database edu_ods \
--hcatalog-table web_chat_ems \
--hive-partition-key dt
--hive-partition-value '2022-08-21'
-m 1


/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://106.75.33.59:3306/nev?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query "select t2.*, '2022-08-21' as dt from web_chat_ems_2019_ 07 t1 join web_chat_text_ems_2019_07 t2 on t1.id = t2.id  where 1=1 and (t1.create_time between '2022-08-21 00:00:00' and '2022-08-21 23:59:59') and  \$CONDITIONS" \
--hcatalog-database edu_ods \
--hcatalog-table web_chat_text_ems \
--hive-partition-key dt \
--hive-partition-value "2022-08-21" \
--m 1


-- web_chat_ems
-- 动态分区配置
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;

-- hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
-- 写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
-- 写入数据强制分桶
set hive.enforce.bucketing=true;
-- 开启强制排序
set hive.enforce.sorting=true;



insert overwrite table edu_dwd.web_chat_ems_dwd partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
    id,
    create_date_time,
    session_id,
    sid,
    create_time,
    seo_source,
    seo_keywords,
    ip,
    area,
    country,
    province,
    city,
    origin_channel,
    `user`,
    manual_time,
    begin_time,
    end_time,
    last_customer_msg_time_stamp,
    last_agent_msg_time_stamp,
    reply_msg_count,
    msg_count,
    browser_name,
    os_info,
    substr(create_time,12,2) as hourinfo,
    substr(create_time,1,4) as yearinfo,
    quarter(create_time) as quarterinfo,
    substr(create_time,6,2) as monthinfo,
    substr(create_time,9,2) as dayinfo
from  edu_ods.web_chat_ems;



-- web_chat_text_ems
insert overwrite table edu_dwd.web_chat_text_ems_dwd partition(dt)
select
   *
from  edu_ods.web_chat_text_ems;



-- web_chat_ems
-- 动态分区配置
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;

-- hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
-- 写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
-- 写入数据强制分桶
set hive.enforce.bucketing=true;
-- 开启强制排序
set hive.enforce.sorting=true;



insert overwrite table edu_dwd.web_chat_ems_dwd partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
    id,
    create_date_time,
    session_id,
    sid,
    create_time,
    seo_source,
    seo_keywords,
    ip,
    area,
    country,
    province,
    city,
    origin_channel,
    `user`,
    manual_time,
    begin_time,
    end_time,
    last_customer_msg_time_stamp,
    last_agent_msg_time_stamp,
    reply_msg_count,
    msg_count,
    browser_name,
    os_info,
    substr(create_time,12,2) as hourinfo,
    substr(create_time,1,4) as yearinfo,
    quarter(create_time) as quarterinfo,
    substr(create_time,6,2) as monthinfo,
    substr(create_time,9,2) as dayinfo
from  edu_ods.web_chat_ems where dt = '-- web_chat_ems
-- 动态分区配置
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;

-- hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
-- 写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
-- 写入数据强制分桶
set hive.enforce.bucketing=true;
-- 开启强制排序
set hive.enforce.sorting=true;



insert overwrite table edu_dwd.web_chat_ems_dwd partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
    id,
    create_date_time,
    session_id,
    sid,
    create_time,
    seo_source,
    seo_keywords,
    ip,
    area,
    country,
    province,
    city,
    origin_channel,
    `user`,
    manual_time,
    begin_time,
    end_time,
    last_customer_msg_time_stamp,
    last_agent_msg_time_stamp,
    reply_msg_count,
    msg_count,
    browser_name,
    os_info,
    substr(create_time,12,2) as hourinfo,
    substr(create_time,1,4) as yearinfo,
    quarter(create_time) as quarterinfo,
    substr(create_time,6,2) as monthinfo,
    substr(create_time,9,2) as dayinfo
from  edu_ods.web_chat_ems where dt = ' -- web_chat_ems
-- 动态分区配置
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;

-- hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
-- 写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
-- 写入数据强制分桶
set hive.enforce.bucketing=true;
-- 开启强制排序
set hive.enforce.sorting=true;



insert overwrite table edu_dwd.web_chat_ems_dwd partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
    id,
    create_date_time,
    session_id,
    sid,
    create_time,
    seo_source,
    seo_keywords,
    ip,
    area,
    country,
    province,
    city,
    origin_channel,
    `user`,
    manual_time,
    begin_time,
    end_time,
    last_customer_msg_time_stamp,
    last_agent_msg_time_stamp,
    reply_msg_count,
    msg_count,
    browser_name,
    os_info,
    substr(create_time,12,2) as hourinfo,
    substr(create_time,1,4) as yearinfo,
    quarter(create_time) as quarterinfo,
    substr(create_time,6,2) as monthinfo,
    substr(create_time,9,2) as dayinfo
from  edu_ods.web_chat_ems where dt = '2022-08-21';



-- web_chat_text_ems
insert overwrite table edu_dwd.web_chat_text_ems_dwd partition(dt)
select
   *
from  edu_ods.web_chat_text_ems where dt = '2022-08-21';
';



-- web_chat_text_ems
insert overwrite table edu_dwd.web_chat_text_ems_dwd partition(dt)
select
   *
from  edu_ods.web_chat_text_ems where dt = '2022-08-21';
';



-- web_chat_text_ems
insert overwrite table edu_dwd.web_chat_text_ems_dwd partition(dt)
select
   *
from  edu_ods.web_chat_text_ems where dt = '2022-08-21';


set hive.auto.convert.join=true;
-- smb
set hive.enforce.bucketing=true;
set hive.enforce.sorting=true;
set hive.optimize.bucketmapjoin = true;
set hive.auto.convert.sortmerge.join=true;
set hive.auto.convert.sortmerge.join.noconditionaltask=true;
set hive.optimize.bucketmapjoin.sortedmerge = true;

explain
select
    wce.id,
    wce.create_date_time,
    wce.session_id,
    wce.sid,
    wce.create_time,
    wce.seo_source,
    wce.seo_keywords,
    wce.ip,
    wce.area,
    wce.country,
    wce.province,
    wce.city,
    wce.origin_channel,
    wce.`user`,
    wce.manual_time,
    wce.begin_time,
    wce.end_time,
    wce.last_customer_msg_time_stamp,
    wce.last_agent_msg_time_stamp,
    wce.reply_msg_count,
    wce.msg_count,
    wce.browser_name,
    wce.os_info,
    wce.hourinfo,
    wcte.referrer,
    wcte.from_url,
    wcte.landing_page_url,
    wcte.url_title,
    wcte.platform_description,
    wcte.other_params,
    wcte.history,
    wce.yearinfo,
    wce.quarterinfo,
    wce.monthinfo,
    wce.dayinfo
from edu_dwd.web_chat_ems_dwd wce  join edu_dwd.web_chat_text_ems_dwd wcte on wce.id = wcte.id;

--动态分区配置
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
--hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
--矢量化查询(批量读取操作)
set hive.vectorized.execution.enabled=true;

set hive.auto.convert.join=true;
-- smb
set hive.enforce.bucketing=true;
set hive.enforce.sorting=true;
set hive.optimize.bucketmapjoin = true;
set hive.auto.convert.sortmerge.join=true;
set hive.auto.convert.sortmerge.join.noconditionaltask=true;
set hive.optimize.bucketmapjoin.sortedmerge = true;

insert overwrite table edu_dwb.web_chat_ems_dwb partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
    wce.id,
    wce.create_date_time,
    wce.session_id,
    wce.sid,
    wce.create_time,
    wce.seo_source,
    wce.seo_keywords,
    wce.ip,
    wce.area,
    wce.country,
    wce.province,
    wce.city,
    wce.origin_channel,
    wce.`user`,
    wce.manual_time,
    wce.begin_time,
    wce.end_time,
    wce.last_customer_msg_time_stamp,
    wce.last_agent_msg_time_stamp,
    wce.reply_msg_count,
    wce.msg_count,
    wce.browser_name,
    wce.os_info,
    wce.hourinfo,
    wcte.referrer,
    wcte.from_url,
    wcte.landing_page_url,
    wcte.url_title,
    wcte.platform_description,
    wcte.other_params,
    wcte.history,
    wce.yearinfo,
    wce.quarterinfo,
    wce.monthinfo,
    wce.dayinfo
from edu_dwd.web_chat_ems_dwd wce  join edu_dwd.web_chat_text_ems_dwd wcte on wce.id = wcte.id;


--动态分区配置
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
--hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
--矢量化查询(批量读取操作)
set hive.vectorized.execution.enabled=true;

set hive.auto.convert.join=true;
-- smb
set hive.enforce.bucketing=true;
set hive.enforce.sorting=true;
set hive.optimize.bucketmapjoin = true;
set hive.auto.convert.sortmerge.join=true;
set hive.auto.convert.sortmerge.join.noconditionaltask=true;
set hive.optimize.bucketmapjoin.sortedmerge = true;

insert overwrite table edu_dwb.web_chat_ems_dwb partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
    wce.id,
    wce.create_date_time,
    wce.session_id,
    wce.sid,
    wce.create_time,
    wce.seo_source,
    wce.seo_keywords,
    wce.ip,
    wce.area,
    wce.country,
    wce.province,
    wce.city,
    wce.origin_channel,
    wce.`user`,
    wce.manual_time,
    wce.begin_time,
    wce.end_time,
    wce.last_customer_msg_time_stamp,
    wce.last_agent_msg_time_stamp,
    wce.reply_msg_count,
    wce.msg_count,
    wce.browser_name,
    wce.os_info,
    wce.hourinfo,
    wcte.referrer,
    wcte.from_url,
    wcte.landing_page_url,
    wcte.url_title,
    wcte.platform_description,
    wcte.other_params,
    wcte.history,
    wce.yearinfo,
    wce.quarterinfo,
    wce.monthinfo,
    wce.dayinfo
from (select * from edu_dwd.web_chat_ems_dwd where yearinfo='2022' and quarterinfo='1' and monthinfo='03' and dayinfo='13') wce  join (select * from edu_dwd.web_chat_text_ems_dwd where dt = ''2022 ||
                                                                                                                                                                                              '--动态分区配置
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
--hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
--矢量化查询(批量读取操作)
set hive.vectorized.execution.enabled=true;

set hive.auto.convert.join=true;
-- smb
set hive.enforce.bucketing=true;
set hive.enforce.sorting=true;
set hive.optimize.bucketmapjoin = true;
set hive.auto.convert.sortmerge.join=true;
set hive.auto.convert.sortmerge.join.noconditionaltask=true;
set hive.optimize.bucketmapjoin.sortedmerge = true;

insert overwrite table edu_dwb.web_chat_ems_dwb partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
    wce.id,
    wce.create_date_time,
    wce.session_id,
    wce.sid,
    wce.create_time,
    wce.seo_source,
    wce.seo_keywords,
    wce.ip,
    wce.area,
    wce.country,
    wce.province,
    wce.city,
    wce.origin_channel,
    wce.`user`,
    wce.manual_time,
    wce.begin_time,
    wce.end_time,
    wce.last_customer_msg_time_stamp,
    wce.last_agent_msg_time_stamp,
    wce.reply_msg_count,
    wce.msg_count,
    wce.browser_name,
    wce.os_info,
    wce.hourinfo,
    wcte.referrer,
    wcte.from_url,
    wcte.landing_page_url,
    wcte.url_title,
    wcte.platform_description,
    wcte.other_params,
    wcte.history,
    wce.yearinfo,
    wce.quarterinfo,
    wce.monthinfo,
    wce.dayinfo
from (select * from edu_dwd.web_chat_ems_dwd where yearinfo='2022' and quarterinfo='3' and monthinfo='08' and dayinfo='21') wce  join (select * from edu_dwd.web_chat_text_ems_dwd where dt = '2022-08-21') wcte on wce.id = wcte.id  ;') wcte on wce.id = wcte.id  ;


-- 访问量指标计算:
-- 计算总访问量: 根据时间计算各个时间段的访问量

-- 统计每年的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  '-1' as area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '5' as time_type,
  '5' as group_type,
  yearinfo,
  '-1' as quarterinfo,
  '-1' as monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb
group by yearinfo;

-- 统计每年每季度的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  '-1' as area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '4' as time_type,
  '5' as group_type,
  yearinfo,
  quarterinfo,
  '-1' as monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb
group by yearinfo,quarterinfo;
-- 统计每年每季度每月的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  '-1' as area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '3' as time_type,
  '5' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb
group by yearinfo,quarterinfo,monthinfo;
-- 统计每年每季度每月每天的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  '-1' as area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '2' as time_type,
  '5' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  dayinfo
from edu_dwb.web_chat_ems_dwb
group by yearinfo,quarterinfo,monthinfo,dayinfo;
-- 统计每年每季度每月每天每小时访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  hourinfo,
  '-1' as area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '1' as time_type,
  '5' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  dayinfo
from edu_dwb.web_chat_ems_dwb
group by yearinfo,quarterinfo,monthinfo,dayinfo,hourinfo;

-- 按照地区和时间:
-- 统计每年各个地区的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '5' as time_type,
  '1' as group_type,
  yearinfo,
  '-1' as quarterinfo,
  '-1' as monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb
group by yearinfo,area;
-- 统计每年每季度各个地区访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '4' as time_type,
  '1' as group_type,
  yearinfo,
  quarterinfo,
  '-1' as monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb
group by yearinfo,quarterinfo,area;
-- 统计每年每季度每月各个地区的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '3' as time_type,
  '1' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb
group by yearinfo,quarterinfo,monthinfo,area;
-- 统计每年每季度每月每天各个地区的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '2' as time_type,
  '1' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  dayinfo
from edu_dwb.web_chat_ems_dwb
group by yearinfo,quarterinfo,monthinfo,dayinfo,area;
-- 统计每年每季度每月每天每小时各个地区访问量

insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  hourinfo,
  area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '1' as time_type,
  '1' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  dayinfo
from edu_dwb.web_chat_ems_dwb
group by yearinfo,quarterinfo,monthinfo,dayinfo,hourinfo,area;

--增量
-- 访问量指标计算:
-- 先执行删除受影响分区结果数据
drop table edu_dm.visit_dm drop partition(yearinfo='2022',quarterinfo='-1',monthinfo='-1',dayinfo='-1');
drop table edu_dm.visit_dm drop partition(yearinfo='2022',quarterinfo='1',monthinfo='-1',dayinfo='-1');
drop table edu_dm.visit_dm drop partition(yearinfo='2022',quarterinfo='1',monthinfo='01',dayinfo='-1');
-- 计算总访问量: 根据时间计算各个时间段的访问量

-- 统计每年的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  '-1' as area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '5' as time_type,
  '5' as group_type,
  yearinfo,
  '-1' as quarterinfo,
  '-1' as monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb where yearinfo='2022'
group by yearinfo;

-- 统计每年每季度的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  '-1' as area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '4' as time_type,
  '5' as group_type,
  yearinfo,
  quarterinfo,
  '-1' as monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb where yearinfo = '2022' and quarterinfo = '3'
group by yearinfo,quarterinfo;
-- 统计每年每季度每月的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  '-1' as area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '3' as time_type,
  '5' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb  where yearinfo = '2022' and quarterinfo = '3' and monthinfo ='08'
group by yearinfo,quarterinfo,monthinfo;
-- 统计每年每季度每月每天的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  '-1' as area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '2' as time_type,
  '5' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  dayinfo
from edu_dwb.web_chat_ems_dwb where yearinfo = '2022' and quarterinfo = '3' and monthinfo ='03' and dayinfo = '21'
group by yearinfo,quarterinfo,monthinfo,dayinfo;
-- 统计每年每季度每月每天每小时访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  hourinfo,
  '-1' as area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '1' as time_type,
  '5' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  dayinfo
from edu_dwb.web_chat_ems_dwb  where yearinfo = '2022' and quarterinfo = '3' and monthinfo ='08' and dayinfo = '21'
group by yearinfo,quarterinfo,monthinfo,dayinfo,hourinfo;

-- 按照地区和时间:
-- 统计每年各个地区的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '5' as time_type,
  '1' as group_type,
  yearinfo,
  '-1' as quarterinfo,
  '-1' as monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb where  yearinfo = '2022'
group by yearinfo,area;
-- 统计每年每季度各个地区访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '4' as time_type,
  '1' as group_type,
  yearinfo,
  quarterinfo,
  '-1' as monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb where  yearinfo = '2022'and quarterinfo ='3'
group by yearinfo,quarterinfo,area;
-- 统计每年每季度每月各个地区的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '3' as time_type,
  '1' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  '-1' as dayinfo
from edu_dwb.web_chat_ems_dwb where  yearinfo = '2022'and quarterinfo ='3' and monthinfo ='08'
group by yearinfo,quarterinfo,monthinfo,area;
-- 统计每年每季度每月每天各个地区的访问量
insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  '-1' as hourinfo,
  area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '2' as time_type,
  '1' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  dayinfo
from edu_dwb.web_chat_ems_dwb where  yearinfo = '2022'and quarterinfo ='1' and monthinfo ='08' and dayinfo ='21'
group by yearinfo,quarterinfo,monthinfo,dayinfo ,area;
-- 统计每年每季度每月每天每小时各个地区访问量

insert into table edu_dm.visit_dm partition(yearinfo,quarterinfo,monthinfo,dayinfo)
select
  count(distinct sid) as sid_total ,
  hourinfo,
  area,
  '-1' as origin_channel,
  '-1' as seo_source,
  '-1' as from_url,
  '1' as time_type,
  '1' as group_type,
  yearinfo,
  quarterinfo,
  monthinfo,
  dayinfo
from edu_dwb.web_chat_ems_dwb where  yearinfo = '2022'and quarterinfo ='3' and monthinfo ='08' and dayinfo ='21'
group by yearinfo,quarterinfo,monthinfo,dayinfo,hourinfo,area;

--导出
create database if not exists edu_result;
create table if not exists edu_result.visit_dm(
    sid_total bigint comment '访问量',
    hourinfo varchar(2) comment '小时',
    area varchar(50) comment '地区维度',
    origin_channel varchar(50) comment '来源渠道维度',
    seo_source varchar(50) comment '搜索来源维度',
    from_url varchar(500) comment '受访url',
    time_type varchar(2) comment '时间标记: 1 小时  2 天 3月 4 季度 5 年',
    group_type varchar(2) comment '产品属性维度标记: 1 地区  2 来源渠道 3 搜索来源 4 受访url 5总访问量'
);

-- 全量导出:
sqoop export \
--connect "jdbc:mysql://192.168.52.150:3306/edu_result?useUnicode=true&characterEncoding=utf-8" \
--username root \
--password '123456' \
--table visit_dm \
--hcatalog-database edu_dm \
--hcatalog-table visit_dm \
--m 1


-- 增量导出操作:
-- 先要将MySQL中当年的全部统计结果删除掉
delete from edu_result.visit_dm where yearinfo ='2022'

sqoop export \
--connect "jdbc:mysql://192.168.52.150:3306/edu_result?useUnicode=true&characterEncoding=utf-8" \
--username root \
--password '123456' \
--table visit_dm \
--hcatalog-database edu_dm \
--hcatalog-table visit_dm \
--hcatalog-partition-keys yearinfo \
--hcatalog-partition-values '2022' \
--m 1












