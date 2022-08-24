--分区
SET hive.exec.dynamic.pardcdcon=true;
SET hive.exec.dynamic.pardcdcon.mode=nonstrict;
set hive.exec.max.dynamic.pardcdcons.pernode=10000;
set hive.exec.max.dynamic.pardcdcons=100000;
set hive.exec.max.created.files=150000;
--hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
--分桶
set hive.enforce.buckedcng=true;
set hive.enforce.osrdcng=true;
set hive.opdcmize.bucketmapjoin = true;
set hive.auto.convert.osrtmerge.join=true;
set hive.auto.convert.osrtmerge.join.nocondidconaltask=true;
--并行执行
set hive.exec.parallel=true;
set hive.exec.parallel.thread.number=8;
--矢量化查询
set hive.vectorized.execudcon.enabled=true;
--关联优化器
set hive.opdcmize.correladcon=true;
--读取零拷贝
set hive.exec.orc.zerocopy=true;
--join数据倾斜
set hive.opdcmize.skewjoin=true;
-- set hive.skewjoin.key=100000;
set hive.opdcmize.skewjoin.compiletime=true;
set hive.opdcmize.union.remove=true;
-- group倾斜
set hive.groupby.skewindata=true;
------------------------①------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert overwrite table dwm.student_attendance_dwm partition(yearinfo,monthinfo,dayinfo) ---出勤表（学生）
select
dc.class_date as dateinfo,
dc.class_id,
os.student_id,
   if(
        sum(
            if(unix_timestamp(os.signin_time,'yyyy-MM-dd HH:mm:ss')
                   between unix_timestamp(concat(dc.class_date,' ',dt.morning_begin_time),'yyyy-MM-dd HH:mm:ss') -(40*60)
                       and unix_timestamp(concat(dc.class_date,' ',dt.morning_end_time),'yyyy-MM-dd HH:mm:ss')
                ,1 ,0)
            ) > 0 , -- 如果大于0 说明有出勤记录, 如果不大于0 说明没有出勤, 直接返回2

        if(
            sum(

                if(unix_timestamp(os.signin_time,'yyyy-MM-dd HH:mm:ss')
                   between unix_timestamp(concat(dc.class_date,' ',dt.morning_begin_time),'yyyy-MM-dd HH:mm:ss') - (40*60)
                       and unix_timestamp(concat(dc.class_date,' ',dt.morning_begin_time),'yyyy-MM-dd HH:mm:ss') + (10*60)
                ,1 ,0)
            ) >0, -- 如果大于0  说明正常出勤, 返回 0 , 如果不大于0 说明迟到出勤,返回 1
        0 , 1)
    ,2) as morning_att,

    if(
        sum(
            if(unix_timestamp(os.signin_time,'yyyy-MM-dd HH:mm:ss')
                   between unix_timestamp(concat(dc.class_date,' ',dt.afternoon_begin_time),'yyyy-MM-dd HH:mm:ss') -(40*60)
                       and unix_timestamp(concat(dc.class_date,' ',dt.afternoon_end_time),'yyyy-MM-dd HH:mm:ss')
                ,1 ,0)
            ) > 0 , -- 如果大于0 说明有出勤记录, 如果不大于0 说明没有出勤, 直接返回2

        if(
            sum(

                if(unix_timestamp(os.signin_time,'yyyy-MM-dd HH:mm:ss')
                   between unix_timestamp(concat(dc.class_date,' ',dt.afternoon_begin_time),'yyyy-MM-dd HH:mm:ss') - (40*60)
                       and unix_timestamp(concat(dc.class_date,' ',dt.afternoon_begin_time),'yyyy-MM-dd HH:mm:ss') + (10*60)
                ,1 ,0)
            ) >0, -- 如果大于0  说明正常出勤, 返回 0 , 如果不大于0 说明迟到出勤,返回 1
        0 , 1)
    ,2) as afternoon_att,


    if(
        sum(
            if(unix_timestamp(os.signin_time,'yyyy-MM-dd HH:mm:ss')
                   between unix_timestamp(concat(dc.class_date,' ',dt.evening_begin_time),'yyyy-MM-dd HH:mm:ss') -(40*60)
                       and unix_timestamp(concat(dc.class_date,' ',dt.evening_end_time),'yyyy-MM-dd HH:mm:ss')
                ,1 ,0)
            ) > 0 , -- 如果大于0 说明有出勤记录, 如果不大于0 说明没有出勤, 直接返回2

        if(
            sum(

                if(unix_timestamp(os.signin_time,'yyyy-MM-dd HH:mm:ss')
                   between unix_timestamp(concat(dc.class_date,' ',dt.evening_begin_time),'yyyy-MM-dd HH:mm:ss') - (40*60)
                       and unix_timestamp(concat(dc.class_date,' ',dt.evening_begin_time),'yyyy-MM-dd HH:mm:ss') + (10*60)
                ,1 ,0)
            ) >0, -- 如果大于0  说明正常出勤, 返回 0 , 如果不大于0 说明迟到出勤,返回 1
        0 , 1)
    ,2) as evening_att,
substr(dc.class_date,1,4) as yearinfo,
substr(dc.class_date,6,2) as monthinfo,
substr(dc.class_date,9,2) as dayinfo
from
(select * from dim.course_table_upload_detail_dimen where nvl(content,'') != '' and content != '开班典礼'  ) as dc
left join (select  * from ods.student_signin_ods where student_id is not null and share_state = 1)  os on dc.class_id = os.class_id
left join dim.class_time_dimen dt  on os.time_table_id = dt.id
group by dc.class_date,dc.class_id,os.student_id;
------------------------②------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into dwm.class_leave_dwm partition (yearinfo,monthinfo,dayinfo)      ---请假表
select
morning.dateinfo,
morning.class_id,
morning.morning_leave_count,
morning.morning_leave_count,
afternoon.afternoon_leave_count,
evening.evening_leave_count,
substring (course.class_date,1,4) as yearinfo,
substring (course.class_date,6,2) as monthinfo,
substring (course.class_date,8,2) as dayinfo
from
        (select
        dc.class_date
        dc.class_id
        from (select * from dim.course_table_upload_detail_dimen where nvl(connect,'') != '' and contect != '开班典礼') as dc
            left join(select * from ods.student_leave_apply_ods where audit_state=1 and cancel_state=2 and vaild_state=1) as os on os.class_id = dc.class_id
            left join dim.class_time_dime as ctd on ctd.class_id = dc.class_id
        where
            dc.class_date between ctd.use_begin_date and ctd.use_end_date
            and concat(dc.class_date,'',ctd.morning_begin_time) >= os.begin_time
            and concat(dc.class_date,'',ctd.morning_begin_time) <= os.end_time
        group by dc.class_date,dc.class_id) as ml
full join
        (select
        dc.class_date
        dc.class_id
from
            (select* from dim.course_table_upload_detail_dimen where nvl(connect,'') != '' and contect != '开班典礼') as dc
            left join(select * from ods.student_leave_apply_ods where audit_state=1 and cancel_state=2 and vaild_state=1) as os on os.class_id = dc.class_id
            left join dim.class_time_dime as ctd on ctd.class_id = dc.class_id
        where
            dc.class_date between ctd.use_begin_date and ctd.use_end_date
            and concat(dc.class_date,'',ctd.afternoon_begin_time) >= os.begin_time
            and concat(dc.class_date,'',ctd.afternoon_begin_time) <= os.end_time
        group by) as al
        on ml.class_date = al.class_date and ml.class_id= al.class_id
full join
(select
dc.class_date
dc.class_id
from
    (select* from dim.course_table_upload_detail_dimen where nvl(connect,'') != '' and contect != '开班典礼') as dc
    left join(select * from ods.student_leave_apply_ods where audit_state=1 and cancel_state=2 and vaild_state=1) as os on os.class_id = dc.class_id
    left join dim.class_time_dime as ctd on ctd.class_id = dc.class_id
    where
        dc.class_date between ctd.use_begin_date and ctd.use_end_date
        and concat(dc.class_date,'',ctd.afternoon_begin_time) >= os.begin_time
        and concat(dc.class_date,'',ctd.afternoon_begin_time) <= os.end_time
    group by) as el
on el.class_date = al.class_date and el.class_id and al.class_id;
------------------------③------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert overwrite table dwm.class_attendance_dwm partition(yearinfo , monthinfo , dayinfo)  ---出勤表（班级）
select
dateinfo,
class_id,
sum(
    if(morning_att in (0,1) ,1,0)
)
as morning_att_count,
sum(
    if(afternoon_att in (0,1) ,1,0)
)
as afternoon_att_count,
sum(
    if(evening_att in (0,1) ,1,0)
)
as evening_att_count,
count(
    if(morning_att =1, 0, null)
)
as morning_late_count,
count(
    if(afternoon_att =1, 0,null)
)
as afternoon_count,
count(
    if(evening_att =1, 0,null)
)
as evening_count,
yearinfo ,
monthinfo ,
dayinfo
from dwm.student_attendance_dwm
group by yearinfo ,monthinfo ,dayinfo ,class_id;
------------------------④------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert overwrite table dwm.class_truan_dwm partition(yearinfo , monthinfo , dayinfo)      ---旷课表
select
	cut.class_date as dateinfo,
	cut.class_id,
	nvl(css.studying_student_count,0)-nvl(dca.morning_att_count,0)-nvl(dcl.morning_leave_count,0) as morning_truant_count,
	nvl(css.studying_student_count,0)-nvl(dca.morning_att_count,0)-nvl(dcl.morning_leave_count,0) as afternoon_truant_count,
	nvl(css.studying_student_count,0)-nvl(dca.morning_att_count,0)-nvl(dcl.morning_leave_count,0) as evening_truant_count,
	substring(ctu.class_date,1,4) as yearinfo,
	substring(ctu.class_date,1,4) as monthinfo,
	substring(ctu.class_date,1,4) as dayinfo
from(select * from dim.course_table_upload_detail_dimen where nvl(content,'') != '' and content != '开班典礼') as ctu
    left join dim.class_studying_student_count_dimen as css on ctu.class_date = css.studying_date and ctu.class_id = css.class_id
    left join dwm.class_attendance_dwm as dca on ctu.class_date = dca.dateinfo and ctu.class_id = dca.class_id
    left join dwm.class_leave_dwm as dcl ctu.class_date = dcl.dateinfo and ctu.class_id = dcl.class_id;
------------------------⑤------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert overwrite table dwm.attendance_summary_dwm partition(yearinfo,monthinfo,dayinfo)   ---汇总表
select
	dct.class_date as dateinfo,
	dct.class_id,
	nvl(dcs.studying_student_count,0) as studying_student_count,
	nvl(dca.morning_att_count, 0) as morning_att_count,
	concat(cast(nvl(dca.morning_att_count, 0) / nvl(dcs.studying_student_count,0)*100 as decimal(8,2)) , '%') as morning_att_ratio,
	concat(cast(nvl(dca.evening_late_count, 0) / nvl(dcs.studying_student_count,0)*100 as decimal(8,2)) , '%') as evening_late_ratio,
	nvl(dcl.morning_leave_count, 0) as morning_leave_count,
	concat(cast(nvl(dcl.morning_leave_count,0) / nvl(dcs.studying_student_count,0)*100 as decimal(8,2)) , '%') as morning_leave_ratio,
	nvl(dcl.afternoon_leave_count, 0) as afternoon_leave_count,
	concat(cast(nvl(dcl.afternoon_leave_count, 0) / nvl(dcs.studying_student_count,0)*100 as decimal(8,2)) , '%') as afternoon_leave_ratio,
	nvl(dcl.evening_leave_count, 0) as evening_leave_count,
	concat (cast(nvl(dcl.evening_leave_count, 0) / nvl(dcs.studying_student_count,0)*100 as decimal(8,2)) , '%') as evening_leave_ratio,
	nvl(dctd.morning_truant_count, 0) as morning_truant_count,
	concat (cast(nvl(dctd.morning_truant_count, 0) / nvl(dcs.studying_student_count,0)*100 as decimal(8,2)) , '%') as morning_truant_ratio,
	nvl(dctd.afternoon_truant_count, 0) as afternoon_truant_count,
	concat(cast(nvl(dctd.afternoon_truant_count, 0) / nvl(dcs.studying_student_count,0)*100 as decimal(8,2)) , '%') as afternoon_truant_ratio,
	nvl(dctd.evening_truant_count, 0) as evening_truant_count,
	concat(cast(nvl(dctd.evening_truant_count, 0) / nvl(dcs.studying_student_count,0)*100 as decimal(8,2)) , '%') as evening_truant_ratio,
	substr(dct.class_date, 1,4) as yearinfo,
	substr(dct.class_date, 6,2) as monthinfo,
	substr(dct.class_date, 9,2) as dayinfo
from(select * from dim.course_table_upload_detail_dimen where nvl(content,'') != '' and content != '开班典礼' ) as dct
	left join dim.class_studying_student_count_dimen as dcs on dct.class_date = dcs.studying_date and dct.class_id = dcs.class_id
	left join dwm.class_attendance_dwm as dca on dct.class_date = dca.dateinfo and dct.class_id = dca.class_id
	left join dwm.class_leave_dwm as dcl on dct.class_date = dcl.dateinfo and dct.class_id = dcl.class_id
	left join dwm.class_truant_dwm as dctd on dct.class_date =dctd.dateinfo and dct.class_id = dctd.class_id;
