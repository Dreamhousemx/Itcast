--------一层----------------------------------------
create database ODS;
--------打卡记录表-----------------------------------
create table if not exists ODS.student_signin_ods(
    id                int            comment '主键id',
    normal_class_flag int            comment '是否正课 1 正课 2 自习',
    time_table_id     int            comment '作息时间id 关联tbh_school_time_table 或者 tbh_class_time_table',
    class_id          int            comment '班级id',
    student_id        int            comment '学员id',
    signin_time       string         comment '签到时间',
    signin_date       string         comment '签到日期',
    inner_flag        int            comment '内外网标志  0 外网 1 内网',
    signin_type       int            comment '签到类型 1 心跳打卡 2 老师补卡',
    share_state       int            comment '共享屏幕状态 0 否 1是  在上午或下午段有共屏记录，则该段所有记录该字段为1，内网默认为1 外网默认为0 ',
    inner_ip          string         comment '内网ip地址'
)
comment '学生打卡记录表'
partitioned by (dt string)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------学生请假记录表--------------------------------
create table if not exists ODS.student_leave_apply_ods(
    id              int  ,
    class_id        int            comment '班级id',
    student_id      int            comment '学员id',
    audit_state     int            comment '审核状态 0 待审核 1 通过 2 不通过',
    audit_person    int            comment '审核人',
    audit_time      string         comment '审核时间',
    audit_remark    string         comment '审核备注',
    leave_type      int            comment '请假类型  1 请假 2 销假',
    leave_reason    int            comment '请假原因  1 事假 2 病假',
    begin_time      string         comment '请假开始时间',
    begin_time_type int            comment '1：上午 2：下午',
    end_time        string         comment '请假结束时间',
    end_time_type   int            comment '1：上午 2：下午',
    days            float          comment '请假/已休天数',
    cancel_state    int            comment '撤销状态  0 未撤销 1 已撤销',
    cancel_time     string         comment '撤销时间',
    old_leave_id    int            comment '原请假id，只有leave_type =2 销假的时候才有',
    leave_remark    string         comment '请假/销假说明',
    valid_state     int            comment '是否有效（0：无效 1：有效）',
    create_time     string         comment '创建时间'
)
comment '学生请假记录表'
partitioned by (dt string)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------二层----------------------------------------
create database DIM;
--------建表在读班级的每天在读学员人数-------------------
create table if not exists DIM.class_studying_student_count_dimen(
    id                     int,
    school_id              int  comment '校区id',
    subject_id             int  comment '学科id',
    class_id               int  comment '班级id',
    studying_student_count int  comment '在读班级人数',
    studying_date          STRING comment '在读日期'
)
comment '在读班级的每天在读学员人数'
partitioned by (dt string)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------建表日期课程表--------------------------------
create table if not exists DIM.course_table_upload_detail_dimen(
id                      int,
    base_id             int            comment '课程主表id',
    class_id            int            comment '班级id',
    class_date          string         comment '上课日期',
    content             string         comment '课程内容',
    teacher_id          int            comment '老师id',
    teacher_name        string         comment '老师名字',
    job_number          string         comment '工号',
    classroom_id        int            comment '教室id',
    classroom_name      string         comment '教室名称',
    is_outline          int            comment '是否大纲 0 否 1 是',
    class_mode          int            comment '上课模式 0 传统全天 1 AB上午 2 AB下午 3 线上直播',
    is_stage_exam       int            comment '是否阶段考试（0：否 1：是）',
    is_pay              int            comment '代课费（0：无 1：有）',
    tutor_teacher_id    int            comment '晚自习辅导老师id',
    tutor_teacher_name  string         comment '辅导老师姓名',
    tutor_job_number    string         comment '晚自习辅导老师工号',
    is_subsidy          int            comment '晚自习补贴（0：无 1：有）',
    answer_teacher_id   int            comment '答疑老师id',
    answer_teacher_name string         comment '答疑老师姓名',
    answer_job_number   string         comment '答疑老师工号',
    remark              string         comment '备注',
    create_time         string         comment '创建时间'
)
comment '日期课程表'
partitioned by (dt string)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------建表班级作息表--------------------------------
create table if not exists DIM.class_time_dimen(
    id                    int  ,
    class_id              int           comment '班级id',
    morning_template_id    int           comment '上午出勤模板id',
    morning_begin_time    string        comment '上午开始时间',
    morning_end_time      string        comment '上午结束时间',
    afternoon_template_id int           comment '下午出勤模板id',
    afternoon_begin_time  string        comment '下午开始时间',
    afternoon_end_time    string        comment '下午结束时间',
    evening_template_id   int           comment '晚上出勤模板id',
    evening_begin_time    string        comment '晚上开始时间',
    evening_end_time      string        comment '晚上结束时间',
    use_begin_date        string        comment '使用开始日期',
    use_end_date          string        comment '使用结束日期',
    create_time           string        comment '创建时间',
    create_person         int           comment '创建人',
    remark                string        comment '备注'
)
comment '班级作息表'
partitioned by (dt string)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------三层----------------------------------------
create database DWM;
--------学生出勤信息表--------------------------------
create table if not exists DWM.student_attendance_dwm(
    dateinfo        String        comment '日期',
    class_id        int           comment '班级id',
    student_id      int           comment '学员id',
    morning_att     String        comment '上午出勤情况：0.正常出勤、1.迟到、2.其他（请假+旷课）',
    afternoon_att   String        comment '下午出勤情况：0.正常出勤、1.迟到、2.其他（请假+旷课）',
    evening_att     String        comment '晚自习出勤情况：0.正常出勤、1.迟到、2.其他（请假+旷课）'
)
comment '学生出勤信息表'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------班级出勤信息表（正常出勤和迟到）-------------------
create table if not exists DWM.class_attendance_dwm(
    dateinfo                String        comment '日期',
    class_id                int           comment '班级id',
    morning_att_count       String        comment '上午出勤人数',
    afternoon_att_count     String        comment '下午出勤人数',
    evening_att_count       String        comment '晚自习出勤人数',
    morning_late_count      String        comment '上午迟到人数',
    afternoon_late_count    String        comment '下午迟到人数',
    evening_late_count      String        comment '晚自习迟到人数'
)
comment '班级出勤信息表（正常出勤和迟到）'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------班级请假人数表--------------------------------
create table if not exists DWM.class_leave_dwm(
    dateinfo                   String        comment '日期',
    class_id                   int           comment '班级id',
    morning_leave_count        String        comment '上午请假人数',
    afternoon_leave_count      String        comment '下午请假人数',
    evening_leave_count        String        comment '晚自习请假人数'
)
comment '班级请假人数表'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------班级旷课人数----------------------------------
create table if not exists DWM.class_truant_dwm(
    dateinfo                    String        comment '日期',
    class_id                    int           comment '班级id',
    morning_truant_count        String        comment '上午旷课人数',
    afternoon_truant_count      String        comment '下午旷课人数',
    evening_truant_count        String        comment '晚自习旷课人数'
)
comment '班级旷课人数'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------班级大聚和表----------------------------------
create table if not exists DWM.attendance_summary_dwm(
    dateinfo                    String        comment '日期',
    class_id                    int           comment '班级id',
    studying_student_count      int           comment '在读班级人数',
    morning_att_count           String        comment '上午出勤人数',
    morning_att_ratio           String        comment '上午出勤率',
    afternoon_att_count         String        comment '下午出勤人数',
    afternoon_att_ratio         String        comment '下午出勤率',
    evening_att_count           String        comment '晚自习出勤人数',
    evening_att_ratio           String        comment '晚自习出勤率',
    morning_late_count          String        comment '上午迟到人数',
    morning_late_ratio          String        comment '上午迟到率',
    afternoon_late_count        String        comment '下午迟到人数',
    afternoon_late_ratio        String        comment '下午迟到率',
    evening_late_count          String        comment '晚自习迟到人数',
    evening_late_ratio          String        comment '晚自习迟到率',
    morning_leave_count         String        comment '上午请假人数',
    morning_leave_ratio         String        comment '上午请假率',
    afternoon_leave_count       String        comment '下午请假人数',
    afternoon_leave_ratio       String        comment '下午请假率',
    evening_leave_count         String        comment '晚自习请假人数',
    evening_leave_ratio         String        comment '晚自习请假率',
    morning_truant_count        String        comment '上午旷课人数',
    morning_truant_ratio        String        comment '上午旷课率',
    afternoon_truant_count      String        comment '下午旷课人数',
    afternoon_truant_ratio      String        comment '下午旷课率',
    evening_truant_count        String        comment '晚自习旷课人数',
    evening_truant_ratio        String        comment '晚自习旷课率'
)
comment '班级大聚和表'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
-------四层------------------------------------------
create database DWS;
-------班级出勤信息（马上完成实现）----------------------
create table if not exists DWS.class_attendance_dws(
    dateinfo                    String        comment '日期',
    class_id                    int           comment '班级id',
    studying_student_count      int           comment '在读班级人数',
    morning_att_count           String        comment '上午出勤人数',
    morning_att_ratio           String        comment '上午出勤率',
    afternoon_att_count         String        comment '下午出勤人数',
    afternoon_att_ratio         String        comment '下午出勤率',
    evening_att_count           String        comment '晚自习出勤人数',
    evening_att_ratio           String        comment '晚自习出勤率',
    morning_late_count          String        comment '上午迟到人数',
    morning_late_ratio          String        comment '上午迟到率',
    afternoon_late_count        String        comment '下午迟到人数',
    afternoon_late_ratio        String        comment '下午迟到率',
    evening_late_count          String        comment '晚自习迟到人数',
    evening_late_ratio          String        comment '晚自习迟到率',
    morning_leave_count         String        comment '上午请假人数',
    morning_leave_ratio         String        comment '上午请假率',
    afternoon_leave_count       String        comment '下午请假人数',
    afternoon_leave_ratio       String        comment '下午请假率',
    evening_leave_count         String        comment '晚自习请假人数',
    evening_leave_ratio         String        comment '晚自习请假率',
    morning_truant_count        String        comment '上午旷课人数',
    morning_truant_ratio        String        comment '上午旷课率',
    afternoon_truant_count      String        comment '下午旷课人数',
    afternoon_truant_ratio      String        comment '下午旷课率',
    evening_truant_count        String        comment '晚自习旷课人数',
    evening_truant_ratio        String        comment '晚自习旷课率'
)
comment '聚合时间类型：1、按小时聚合；2、按天聚合；3、按周聚合；4、按月聚合；5、按年聚合'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
----------------------------------------------------