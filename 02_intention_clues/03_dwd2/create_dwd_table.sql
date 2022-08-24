-- scrm_itcast_class
-- scrm_itcast_school
-- scrm_itcast_subject

-- scrm_customer
--顾客表
create table zh_dwd.scrm_customer
(
    id                       int,
    customer_relationship_id string COMMENT '当前意向id',
    create_date_time         string COMMENT '创建时间',
    update_date_time         string COMMENT '最后更新时间',
    deleted                  string COMMENT '是否被删除 : 删除 1 没删除 0',
    name                     string COMMENT '姓名',
    idcard                   string COMMENT '身份证号',
    birth_year               string COMMENT '出生年份',
    gender                   string COMMENT '性别',
    phone                    string COMMENT '手机号',
    wechat                   string COMMENT '微信',
    qq                       string COMMENT 'qq号',
    email                    string COMMENT '邮箱',
    area                     string COMMENT '所在区域',
    leave_school_date        string COMMENT '离校时间',
    graduation_date          string COMMENT '毕业时间',
    bxg_student_id           string COMMENT '博学谷学员ID，可能未关联到，不存在',
    creator                  string COMMENT '创建人ID',
    origin_type              string COMMENT '数据来源 : 1 NETSERVICE:网络来源 ,2 PHONE:电话来源,3 VISITED:参观来源,4 SCHOOL:学校询问来源,5 OTHER:其他来源',
    origin_channel           string COMMENT '来源渠道',
    tenant                   string,
    md_id                    int COMMENT '中台id'

)
    comment '顾客表'
    partitioned by (dt string)
    row format delimited
        fields terminated by '\t'
    stored as orc tblproperties ('orc.compression' = 'ZLIB');

-- scrm_customer_appeal
--客户的吸引力表
drop table if exists zh_dwd.fact_customer_appeal;
create table if not exists zh_dwd.fact_customer_appeal
(
    id                             string comment '主键',
    customer_relationship_first_id string COMMENT '第一条客户关系id',
    employee_id                    string COMMENT '申诉人',
    employee_name                  string COMMENT '申诉人姓名',
    employee_department_id         string COMMENT '申诉人部门',
    employee_tdepart_id            string COMMENT '申诉人所属部门',
    appeal_status                  string COMMENT '申诉状态，0:待稽核 1:无效 2：有效',
    audit_id                       string COMMENT '稽核人id',
    audit_name                     string COMMENT '稽核人姓名',
    audit_department_id            string COMMENT '稽核人所在部门',
    audit_department_name          string COMMENT '稽核人部门名称',
    audit_date_time                string COMMENT '稽核时间',
    create_date_time               string COMMENT '创建时间（申诉时间）',
    update_date_time               string COMMENT '更新时间',
    deleted                        string COMMENT '删除标志位',
    tenant                         string
)
    comment '客户的吸引力表'
    partitioned by (dt string)
    row format delimited
        fields terminated by '\t'
    stored as orc tblproperties ('orc.compression' = 'ZLIB');


--客户线索表
drop table if exists zh_dwd.dim_customer_clue;
create table if not exists zh_dwd.dim_customer_clue
(
    id                       string comment ' ',
    create_date_time         string comment '创建时间',
    update_date_time         string comment '最后更新时间',
    deleted                  string comment '是否被删除（禁用）',
    customer_id              string comment '客户id',
    customer_relationship_id string comment '客户关系id',
    session_id               string comment '七陌会话id',
    sid                      string comment '访客id',
    status                   string comment '状态（undeal待领取 deal 已领取 finish 已关闭 changePeer 已流转）',
    user_zx                  string comment '所属坐席',
    create_time              string comment '七陌创建时间',
    platform                 string comment '平台来源 （pc-网站咨询|wap-wap咨询|sdk-app咨询|weixin-微信咨询）',
    s_name                   string comment '用户名称',
    seo_source               string comment '搜索来源',
    seo_keywords             string comment '关键字',
    ip                       string comment 'IP地址',
    referrer                 string comment '上级来源页面',
    from_url                 string comment '会话来源页面',
    landing_page_url         string comment '访客着陆页面',
    url_title                string comment '咨询页面title',
    to_peer                  string comment '所属技能组',
    manual_time              string comment '人工开始时间',
    begin_time               string comment '坐席领取时间 ',
    reply_msg_count          string comment '客服回复消息数',
    total_msg_count          string comment '消息总数',
    msg_count                string comment '客户发送消息数',
    comment                  string comment '备注',
    finish_reason            string comment '结束类型',
    finish_user              string comment '结束坐席',
    stop_time                string comment '会话结束时间',
    platform_description     string comment '客户平台信息',
    browser_name             string comment '浏览器名称',
    os_info                  string comment '系统名称',
    area                     string comment '区域',
    country                  string comment '所在国家',
    province                 string comment '省',
    city                     string comment '城市',
    creator                  string comment '创建人',
    name                     string comment '客户姓名',
    idcard                   string comment '身份证号',
    phone                    string comment '手机号',
    itcast_school_id         string comment '校区Id',
    itcast_school            string comment '校区',
    itcast_subject_id        string comment '学科Id',
    itcast_subject           string comment '学科',
    wechat                   string comment '微信',
    qq                       string comment 'qq号',
    email                    string comment '邮箱',
    gender                   string comment '性别',
    level                    string comment '客户级别',
    origin_type              string comment '数据来源渠道',
    information_way          string comment '资讯方式',
    working_years            string comment '开始工作时间',
    technical_directions     string comment '技术方向',
    customer_state           string comment '当前客户状态',
    valid                    string comment '该线索是否是网资有效线索',
    anticipat_signup_date    string comment '预计报名时间',
    clue_state               string comment '线索状态',
    scrm_department_id       string comment 'SCRM内部部门id',
    superior_url             string comment '诸葛获取上级页面URL',
    superior_source          string comment '诸葛获取上级页面URL标题',
    landing_url              string comment '诸葛获取着陆页面URL',
    landing_source           string comment '诸葛获取着陆页面URL来源',
    info_url                 string comment '诸葛获取留咨页URL',
    info_source              string comment '诸葛获取留咨页URL标题',
    origin_channel           string comment '投放渠道',
    course_id                string comment ' ',
    course_name              string comment ' ',
    zhuge_session_id         string comment ' ',
    is_repeat                string comment '是否重复线索(手机号维度) 0:正常 1：重复',
    tenant                   string comment '租户id',
    activity_id              string comment '活动id',
    activity_name            string comment '活动名称',
    follow_type              string comment '分配类型，0-自动分配，1-手动分配，2-自动转移，3-手动单个转移，4-手动批量转移，5-公海领取',
    shunt_mode_id            string comment '匹配到的技能组id',
    shunt_employee_group_id  string comment '所属分流员工组',
    start_time               string comment '拉链开始时间',
    end_time                 string comment '拉链结束时间'
)
    comment '客户线索表'
    partitioned by (dt string)
    row format delimited
        fields terminated by '\t'
    stored as orc tblproperties ('orc.compression' = 'ZLIB');

-- 客户关系表
drop table  if exists zh_dwd.itcast_intention_dwd;

create table zh_dwd.itcast_intention_dwd
(
    id                          string,
    create_date_time            string ,
    update_date_time            string COMMENT '最后更新时间',
    deleted                     string COMMENT '是否被删除（禁用） : 0-为删除 1-为未删除',
    customer_id                 string COMMENT '所属客户id',
    first_id                    string COMMENT '第一条客户关系id',
    belonger                    string COMMENT '归属人',
    belonger_name               string COMMENT '归属人姓名',
    initial_belonger            string COMMENT '初始归属人',
    distribution_handler        string COMMENT '分配处理人',
    business_scrm_department_id string COMMENT '归属部门',
    last_visit_time             string COMMENT '最后回访时间',
    next_visit_time             string COMMENT '下次回访时间',
    origin_type                 string COMMENT '数据来源',
    itcast_school_id            string COMMENT '校区Id',
    itcast_subject_id           string COMMENT '学科Id',
    intention_study_type        string COMMENT '意向学习方式',
    anticipat_signup_date       string COMMENT '预计报名时间',
    `level`                     string COMMENT '客户级别',
    creator                     string COMMENT '创建人',
    current_creator             string COMMENT '当前创建人：初始==创建人，当在公海拉回时为 拉回人',
    creator_name                string COMMENT '创建者姓名',
    origin_channel              string COMMENT '来源渠道',
    `COMMENT`                   string comment '',
    first_customer_clue_id      string COMMENT '第一条线索id : 如果值为 1-则无线索  2-则为有线索 ',
    last_customer_clue_id       string COMMENT '最后一条线索id: 如果值为 1-则无线索  2-则为有线索',
    process_state               string COMMENT '处理状态',
    process_time                string COMMENT '处理状态变动时间',
    payment_state               string COMMENT '支付状态',
    payment_time                string COMMENT '支付状态变动时间',
    signup_state                string COMMENT '报名状态',
    signup_time                 string COMMENT '报名时间',
    notice_state                string COMMENT '通知状态',
    notice_time                 string COMMENT '通知状态变动时间',
    lock_state                  string COMMENT '锁定状态',
    lock_time                   string COMMENT '锁定状态修改时间',
    itcast_clazz_id             string COMMENT '所属ems班级id',
    itcast_clazz_time           string COMMENT '报班时间',
    payment_url                 string COMMENT '付款链接',
    payment_url_time            string COMMENT '支付链接生成时间',
    ems_student_id              string COMMENT 'ems的学生id',
    delete_reason               string COMMENT '删除原因',
    deleter                     string COMMENT '删除人 ',
    deleter_name                string COMMENT '删除人姓名',
    delete_time                 string COMMENT '删除时间',
    course_id                   string COMMENT '课程ID',
    course_name                 string COMMENT '课程名称',
    delete_comment              string COMMENT '删除原因说明',
    close_state                 string COMMENT '关闭装填',
    close_time                  string COMMENT '关闭状态变动时间',
    appeal_id                   string COMMENT '申诉id',
    tenant                      string COMMENT '租户',
    total_fee                   string COMMENT '报名费总金额',
    belonged                    string COMMENT '小周期归属人',
    belonged_time               string COMMENT '归属时间',
    belonger_time               string COMMENT '归属时间',
    transfer                    string COMMENT '转移人',
    transfer_time               string COMMENT '转移时间',
    follow_type                 string COMMENT '分配类型，0-自动分配，1-手动分配，2-自动转移，3-手动单个转移，4-手动批量转移，5-公海领取',
    transfer_bxg_oa_account     string COMMENT '转移到博学谷归属人OA账号',
    transfer_bxg_belonger_name  string COMMENT '转移到博学谷归属人OA姓名',
    start_time                  string COMMENT '拉链开始时间',
    end_time                    string COMMENT '拉链结束时间'
)
    comment '客户关系表'
    partitioned by (yearinfo string,monthinfo string,dayinfo string, hourinfo string)
    clustered by (id) sorted by (id desc) into 10 buckets
    row format delimited fields terminated by '\t'
    stored as orc tblproperties ('orc.compression' = 'ZLIB');
--学科部门
drop table if exists zh_dwd.dim_department;
create table zh_dwd.dim_department
(
    id               string,
    name             string COMMENT '部门名称',
    parent_id        string COMMENT '父部门id',
    create_date_time string COMMENT '创建时间',
    update_date_time string COMMENT '更新时间',
    deleted          string COMMENT '删除标志',
    id_path          string COMMENT '编码全路径',
    tdepart_code     string COMMENT '直属部门',
    creator          string COMMENT '创建者',
    depart_level     string COMMENT '部门层级',
    depart_sign      string COMMENT '部门标志，暂时默认1',
    depart_line      string COMMENT '业务线，存储业务线编码',
    depart_sort      string COMMENT '排序字段',
    disable_flag     string COMMENT '禁用标志',
    tenant           string,
    start_time       string comment '拉链开始时间',
    end_time         string comment '拉链结束时间'
)
    comment '学科部门'
    partitioned by ( yearinfo string, monthinfo string, dayinfo string,hourinfo string)
    row format delimited
        fields terminated by '\t'
    stored as orc tblproperties ('orc.compression' = 'ZLIB');

--员工信息表
drop table if exists  zh_dwd.fact_employee;
create table zh_dwd.fact_employee
(
    id                  int,
    email               string COMMENT '公司邮箱，OA登录账号',
    real_name           string COMMENT '员工的真实姓名',
    phone               string COMMENT '手机号，目前还没有使用；隐私问题OA接口没有提供这个属性，',
    department_id       string COMMENT 'OA中的部门编号，有负值',
    department_name     string COMMENT 'OA中的部门名',
    remote_login        string COMMENT '员工是否可以远程登录',
    job_number          string COMMENT '员工工号',
    cross_school        string COMMENT '是否有跨校区权限',
    last_login_date     string COMMENT '最后登录日期',
    creator             string COMMENT '创建人',
    create_date_time    string COMMENT '创建时间',
    update_date_time    string COMMENT '最后更新时间',
    deleted             string COMMENT '是否被删除（禁用）',
    scrm_department_id  string COMMENT 'SCRM内部部门id',
    leave_office        string COMMENT '离职状态',
    leave_office_time   string COMMENT '离职时间',
    reinstated_time     string COMMENT '复职时间',
    superior_leaders_id string COMMENT '上级领导ID',
    tdepart_id          string COMMENT '直属部门',
    tenant              string,
    ems_user_name       string,
    start_time          string COMMENT '拉链开始时间',
    end_time            string COMMENT '拉链结束时间'
)
    comment '员工信息表'
    partitioned by (yearinfo string, monthinfo string, dayinfo string, hourinfo string)
    row format delimited
        fields terminated by '\t'
    stored as orc tblproperties ('orc.compression' = 'ZLIB');







