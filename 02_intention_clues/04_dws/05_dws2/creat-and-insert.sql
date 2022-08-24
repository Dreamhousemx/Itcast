create database zh_dws;
create table zh_dws.itcast_clue_dws(
    customer_relationship_id    int comment '客户关系id',
    create_date_time            string comment '创建时间',
    update_date_time            string comment '最后更新时间',
    -- 维度
    year_code string comment '年',
    month_code string comment '月',
    day_code string comment '日',
    hour_code string comment '小时',
    origin_type                 string comment '数据来源',-- 线上，线下('NETSERVICE') #线上（排除挖掘录入量） 其他'OTHER'都是线下
    clue_state                  string comment '线索状态', -- 新旧客户
    -- 指标
    new_effective_clue bigint comment '新客户有效线索',
    new_up_effective_clue bigint comment '新客户线上有效线索',
    new_down_effective_clue bigint comment '新客户线下有效线索',
    old_effective_clue bigint comment '老客户有效线索',
    old_up_effective_clue bigint comment '老客户线上有效线索',
    old_down_effective_clue bigint comment '老客户线下有效线索',
    all_effective_clue bigint comment '所有有效线索',
    last_visit_time             string comment '最后回访时间',
    next_visit_time             string comment '下次回访时间',
    intention_study_type        string comment '意向学习方式',
    anticipat_signup_date       string comment '预计报名时间',
    origin_channel              string comment '来源渠道',
    first_customer_clue_id      string comment '第一条线索id',
    last_customer_clue_id       string comment '最后一条线索id',
    itcast_clazz_id             string comment '所属ems班级id',
    itcast_clazz_time           string comment '报班时间',
    course_id                   string comment '课程ID',
    course_name                 string comment '课程名称',
    follow_type                 string comment '分配类型，0-自动分配，1-手动分配，2-自动转移，3-手动单个转移，4-手动批量转移，5-公海领取',
    sid                         string comment '访客id',
    platform                    string comment '平台来源 （pc-网站咨询|wap-wap咨询|sdk-app咨询|weixin-微信咨询）',
    s_name                      string comment '用户名称',
    seo_source                  string comment '搜索来源',
    name                        string comment '客户姓名',
    phone string comment '电话',
    itcast_school               string comment '校区',
    itcast_subject              string comment '学科',
    gender                      string comment '性别',
    valid                       string comment '该线索是否是网资有效线索',  --false,ture
    is_repeat                   int comment '是否重复线索(手机号维度) 0:正常 1：重复',   -- 线索是否重复
    employee_id                    string comment '申诉人',
    employee_name                  string comment '申诉人姓名',
    appeal_status                  string comment '申诉状态，0:待稽核 1:无效 2：有效'   --  18.ca.appeal_status = 1  AND ca.customer_relationship_first_id != 0  无效
)COMMENT '线索数据宽表'
row format delimited fields terminated by '\t'
stored as orc
tblproperties ('orc.compress' = 'SNAPPY');


insert into zh_dws.itcast_clue_dws
select
      customer_relationship_id,
      create_date_time ,
      update_date_time,
      -- 维度
      year_code,
      month_code,
      day_code,
      hour_code,
      origin_type,
      clue_state,
       -- 新客户有效线索
       if ((clue_state IN ('VALID_NEW_CLUES') and (appeal_status not in ('1') or appeal_status is null) and phone is not null),1,null)
        as new_effective_clue,
       -- 新客户线上
       if ((clue_state IN ('VALID_NEW_CLUES') and (appeal_status not in ('1') or appeal_status is null) and origin_type in ('NETSERVICE') and phone is not null),1,null)
        as new_up_effective_clue,
       -- 新客户线下
       if ((clue_state IN ('VALID_NEW_CLUES') and (appeal_status not in ('1') or appeal_status is null) and origin_type not in ('NETSERVICE') and phone is not null),1,null)
        as new_down_effective_clue,
       -- 老客户有效线索
       if ((clue_state IN ('VALID_PUBLIC_NEW_CLUE') and (appeal_status not in ('1') or appeal_status is null) and phone is not null),1,null)
        as old_effective_clue,
       -- 老客户线上
       if ((clue_state IN ('VALID_PUBLIC_NEW_CLUE') and (appeal_status not in ('1') or appeal_status is null) and origin_type in ('NETSERVICE') and phone is not null),1,null)
        as old_up_effective_clue,
       -- 老客户线下
       if ((clue_state IN ('VALID_PUBLIC_NEW_CLUE') and (appeal_status not in ('1') or appeal_status is null) and origin_type not in ('NETSERVICE') and phone is not null),1,null)
        as old_down_effective_clue,
       -- 全部有效线索
       if ((clue_state IN ('VALID_NEW_CLUES','VALID_PUBLIC_NEW_CLUE') and (appeal_status not in ('1') or appeal_status is null) and phone is not null),1,null)
        as all_effective_clue,
      last_visit_time             ,
      next_visit_time             ,
      intention_study_type        ,
      anticipat_signup_date       ,
      origin_channel              ,
      first_customer_clue_id      ,
      last_customer_clue_id       ,
      itcast_clazz_id             ,
      itcast_clazz_time           ,
      course_id                   ,
      course_name                 ,
      follow_type                 ,
      sid                         ,
      platform                    ,
      s_name                      ,
      seo_source                  ,
      name                        ,
      phone,
      itcast_school               ,
      itcast_subject              ,
      gender                      ,
      valid                       ,
      is_repeat                   ,
      employee_id          ,
      employee_name        ,
      appeal_status
from zh_dwb.itcast_clue_dwb;