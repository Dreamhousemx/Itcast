INSERT overwrite table zh_dwm.itcast_intention_dwm
select
-- scrm_customer_relationship 客户关系表
1_iid.id as id,
1_iid.create_date_time   as  create_date_time,
1_iid.update_date_time as update_date_time,
1_iid.deleted                                             as deleted,
1_iid.customer_id                                         as customer_id,
first_id,
belonger,
belonger_name,
initial_belonger,
distribution_handler,
business_scrm_department_id,
last_visit_time,
next_visit_time,
if(1_iid.origin_type in ( 'NETSERVICE', 'PRESIGNUP'), 1, 2) as origin_type,
1_iid.itcast_school_id                                    as itcast_school_id,
1_iid.itcast_subject_id                                   as itcast_subject_id,
intention_study_type,
1_iid.anticipat_signup_date                               as anticipat_signup_date,
1_iid.level                                               as level,
1_iid.creator                                             as creator,
current_creator,
creator_name,
1_iid.origin_channel                                      as origin_channel,
1_iid.comment                                             as comment,
first_customer_clue_id,
last_customer_clue_id,
process_state,
process_time,
payment_state,
payment_time,
signup_state,
signup_time,
notice_state,
notice_time,
lock_state,
lock_time,
itcast_clazz_id,
itcast_clazz_time,
payment_url,
payment_url_time,
ems_student_id,
delete_reason,
deleter,
deleter_name,
delete_time,
1_iid.course_id as course_id,
1_iid.course_name as course_name,
delete_comment,
close_state,
close_time,
appeal_id,
1_iid.tenant as tenant,
total_fee,
belonged,
belonged_time,
belonger_time,
transfer,
transfer_time,
1_iid.follow_type  as  follow_type,
transfer_bxg_oa_account,
transfer_bxg_belonger_name,
-- 客户线索 scrm_customer_clue
3_scc.customer_relationship_id as customer_relationship_id,
session_id,
sid,
status,
user_zx,
create_time,
platform,
s_name,
seo_source,
seo_keywords,
ip,
referrer,
from_url,
landing_page_url,
url_title,
to_peer,
manual_time,
begin_time,
reply_msg_count,
total_msg_count,
msg_count,
finish_reason,
finish_user,
3_scc.end_time end_time_xs,
platform_description,
browser_name,
os_info,
3_scc.area as area,
country,
province,
city,
3_scc.creator as creator_xs,
3_scc.name asname,
3_scc.idcard as idcard,
3_scc.phone as phone,
itcast_school,
itcast_subject,
3_scc.wechat as wechat,
3_scc.gender as gender,
information_way,
working_years,
technical_directions,
customer_state,
valid,
3_scc.anticipat_signup_date as anticipat_signup_date_xs,
clue_state,
3_scc.scrm_department_id as scrm_department_id,
superior_url,
superior_source,
landing_url,
landing_source,
info_url,
info_source,
zhuge_session_id,
is_repeat,
activity_id,
activity_name,
shunt_mode_id,
shunt_employee_group_id,
3_scc.create_date_time                                   as create_date_time_gk,
3_scc.update_date_time                                   as update_date_time_gk,
3_scc.qq                                                 as qq,
3_scc.email                                              as email,
3_scc.area                                                  area_gk,
leave_school_date,
graduation_date,
bxg_student_id,
--scrm_customer 顾客表
2_sc.creator                                             as creator_gk,
if(2_sc.origin_type in( 'NETSERVICE' , 'PRESIGNUP'), 1, 2) as origin_type_gk,
2_sc.origin_channel                                      as origin_channel_gk,
2_sc.md_id                                               as md_id,
--scrm_itcast_school  传智播客的学区
5_sic.create_date_time                                   as create_date_time_xq,
5_sic.update_date_time                                   as update_date_time_xq,
5_sic.name                                               as name_xq,
5_sic.code                                               as code_xq,
--传智播客的学科 scrm_itcast_subject
6_sis.create_date_time                                   as create_date_time_xk,
6_sis.update_date_time                                   as update_date_time_xk,
6_sis.name as  name_xk,
6_sis.code as  code_xk,
--scrm_employee 员工信息表
4_se.email as email_yg,
real_name,
department_id,
department_name,
remote_login,
job_number,
cross_school,
last_login_date,
4_se.creator as creator_cjr,
leave_office,
leave_office_time,
reinstated_time,
superior_leaders_id,
tdepart_id,
ems_user_name,
--scrm_department 学科部门
7_sd.name name_bm,
parent_id,
7_sd.deleted as deleted_bz,
id_path,
tdepart_code,
4_se.creator as creator_cjz,
depart_level,
depart_sign,
depart_line,
depart_sort,
disable_flag,
start_time,
1_iid.end_time as end_time,
yearinfo,
monthinfo,
dayinfo,
hourinfo
from zh_dwd.itcast_intention_dwd 1_iid
left join zh_ods.scrm_customer 2_sc   on 2_sc.id=1_iid.customer_id and 2_sc.deleted='false'
left join zh_ods.scrm_customer_clue 3_scc on 3_scc.customer_relationship_id=1_iid.id and 3_scc.deleted='false'
left join zh_ods.scrm_employee 4_se on 4_se.creator=1_iid.creator and 4_se.deleted='false'
left join zh_ods.scrm_itcast_school 5_sic on 5_sic.id=1_iid.itcast_school_id and  5_sic.deleted='false'
left join zh_ods.scrm_itcast_subject 6_sis on 6_sis.id=1_iid.itcast_subject_id and 6_sis.deleted='false'
left join zh_ods.scrm_department 7_sd on 7_sd.id=4_se.tdepart_id and  7_sd.deleted='false'
where 1_iid.deleted='false';


