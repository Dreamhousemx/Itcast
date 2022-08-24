-- 顾客表
insert overwrite table zh_dwd.scrm_customer
select
    id                      ,
    customer_relationship_id,
    create_date_time        ,
    update_date_time        ,
    if(deleted='false',0,1)   as deleted ,
    name                    ,
    idcard                  ,
    birth_year              ,
    gender                  ,
    phone                   ,
    wechat                  ,
    qq                      ,
    email                   ,
     case when  area regexp '^中国'
         then area
         when area like '^未知'
         then '未知'
         else area
         end as area                    ,
    leave_school_date       ,
    graduation_date         ,
    bxg_student_id          ,
    creator                 ,
    case origin_type
        when 'NETSERVICE'
        then 1
        when 'PHONE'
        then 2
        when 'VISITED'
        then 3
        when 'SCHOOL'
        then 4
        when 'OTHER'
        then 5
        end  as origin_type        ,
    origin_channel          ,
    tenant                  ,
    md_id                   ,
    dt
from zh_ods.scrm_customer;
-- 客户的吸引力表
insert overwrite table zh_dwd.fact_customer_appeal
select * from zh_ods.scrm_customer_appeal;
--客户线索表
insert overwrite table zh_dwd.dim_customer_clue partition (dt)
select
    id                      ,
    create_date_time        ,
    update_date_time        ,
    deleted                 ,
    customer_id             ,
    customer_relationship_id,
    session_id              ,
    sid                     ,
    status                  ,
    user_zx                 ,
    create_time             ,
    platform                ,
    s_name                  ,
    seo_source              ,
    seo_keywords            ,
    ip                      ,
    referrer                ,
    from_url                ,
    landing_page_url        ,
    url_title               ,
    to_peer                 ,
    manual_time             ,
    begin_time              ,
    reply_msg_count         ,
    total_msg_count         ,
    msg_count               ,
    comment                 ,
    finish_reason           ,
    finish_user             ,
     end_time as stop_time               ,
    platform_description    ,
    browser_name            ,
    os_info                 ,
    area                    ,
    country                 ,
    province                ,
    city                    ,
    creator                 ,
    name                    ,
    idcard                  ,
    phone                   ,
    itcast_school_id        ,
    itcast_school           ,
    itcast_subject_id       ,
    itcast_subject          ,
    wechat                  ,
    qq                      ,
    email                   ,
    gender                  ,
    level                   ,
    origin_type             ,
    information_way         ,
    working_years           ,
    technical_directions    ,
    customer_state          ,
    valid                   ,
    anticipat_signup_date   ,
    clue_state              ,
    scrm_department_id      ,
    superior_url            ,
    superior_source         ,
    landing_url             ,
    landing_source          ,
    info_url                ,
    info_source             ,
    origin_channel          ,
    course_id               ,
    course_name             ,
    zhuge_session_id        ,
    is_repeat               ,
    tenant                  ,
    activity_id             ,
    activity_name           ,
    follow_type             ,
    shunt_mode_id           ,
    shunt_employee_group_id ,
   substr(create_date_time,1,10)  as start_time  ,
   '9999-99-99'  as end_time                ,
    substr(`current_timestamp`() ,1,10) as dt
from zh_ods.scrm_customer_clue;

select from_unixtime(,"yyyy-mm-dd");

-- 客户关系表
insert overwrite  table zh_dwd.itcast_intention_dwd
select
   id                            ,
   create_date_time              ,
   update_date_time              ,
   deleted                       ,
   customer_id                   ,
   first_id                      ,
   belonger                      ,
   belonger_name                 ,
   initial_belonger              ,
   distribution_handler          ,
   business_scrm_department_id   ,
   last_visit_time               ,
   next_visit_time               ,
   origin_type                   ,
   if(itcast_school_id is null ,1,if(itcast_school_id=0,1 ,itcast_school_id ) )    as itcast_school_id         ,
   if(itcast_subject_id is null ,1 ,if(itcast_subject_id=0,1,itcast_subject_id)) as itcast_subject_id             ,
   intention_study_type          ,
   anticipat_signup_date         ,
   `level`                       ,
   creator                       ,
   current_creator               ,
   creator_name                  ,
   origin_channel                ,
   `COMMENT`                     ,
   first_customer_clue_id        ,
   last_customer_clue_id         ,
   process_state                 ,
   process_time                  ,
   payment_state                 ,
   payment_time                  ,
   signup_state                  ,
   signup_time                   ,
   notice_state                  ,
   notice_time                   ,
   lock_state                    ,
   lock_time                     ,
   itcast_clazz_id               ,
   itcast_clazz_time             ,
   payment_url                   ,
   payment_url_time              ,
   ems_student_id                ,
   delete_reason                 ,
   deleter                       ,
   deleter_name                  ,
   delete_time                   ,
   course_id                     ,
   course_name                   ,
   delete_comment                ,
   close_state                   ,
   close_time                    ,
   appeal_id                     ,
   tenant                        ,
   total_fee                     ,
   belonged                      ,
   belonged_time                 ,
   belonger_time                 ,
   transfer                      ,
   transfer_time                 ,
   follow_type                   ,
   transfer_bxg_oa_account       ,
   transfer_bxg_belonger_name,
   substr(create_date_time,1,10)  as start_time,
   '9999-99-99' as end_time,
  substr(create_date_time,1,4) as  yearinfo,
  substr(create_date_time,6,2) as monthinfo,
  substr(create_date_time,9,2) as dayinfo,
  substr(create_date_time,11,2) as hourinfo
from zh_ods.scrm_customer_relationship;
/*
select
id as rid,
customer_id,
create_date_time,
if(itcast_school_id is null , '-1' , if(itcast_school_id = 0,'-1',itcast_school_id) ) as itcast_school_id,
deleted,
origin_type,
if(itcast_subject_id is null , '-1' , if(itcast_subject_id = 0,'-1',itcast_subject_id) ) as itcast_subject_id,
creator,
substr(create_date_time,12,2) as hourinfo,
if( origin_type in ('NETSERVICE', 'PRESIGNUP') , 1 , 0) as origin_type_stat,
substr(create_date_time,1,4) as yearinfo,
substr(create_date_time,6,2) as monthinfo,
substr(create_date_time,9,2)  as dayinfo
from zh_ods.scrm_customer_relationship where  deleted = false;

 */

--学科部门
insert overwrite table zh_dwd.dim_department
select
   id              ,
   name            ,
   parent_id       ,
   create_date_time,
   update_date_time,
   deleted         ,
   id_path         ,
   tdepart_code    ,
   creator         ,
   depart_level    ,
   depart_sign     ,
   depart_line     ,
   depart_sort     ,
   disable_flag    ,
   tenant          ,
  substr(create_date_time,1,10)  as start_time  ,
   '9999-99-99' as end_time        ,
   substr(create_date_time,1,4) as yearinfo,
   substr(create_date_time,6,2) as monthinfo,
   substr(create_date_time,9,2) as dayinfo,
   substr(create_date_time,12,2) as hourinfo
from zh_ods.scrm_department;
--员工信息表

insert overwrite table zh_dwd.fact_employee
select
    id                ,
    email             ,
    real_name         ,
    phone             ,
    department_id     ,
    department_name   ,
    remote_login      ,
    job_number        ,
    cross_school      ,
    last_login_date   ,
    creator           ,
    create_date_time  ,
    update_date_time  ,
    deleted           ,
    scrm_department_id,
    leave_office      ,
    leave_office_time ,
    reinstated_time   ,
    superior_leaders_id,
    tdepart_id        ,
    tenant            ,
    ems_user_name     ,
    substr(create_date_time,1,10) as start_time        ,
    '9999-99-99' as end_time           ,
    substr(create_date_time,1,4) as yearinfo,
    substr(create_date_time,6,2) as monthinfo,
    substr(create_date_time,9,2) as dayinfo,
    substr(create_date_time,12,2) as hourinfo
from zh_ods.scrm_employee;


