-- 日期课程表
CREATE TABLE IF NOT EXISTS itcast_dimen.course_table_upload_detail_dimen
(
    id                  int comment 'id',
    base_id             int comment '课程主表id',
    class_id            int comment '班级id',
    class_date          STRING comment '上课日期',
    content             STRING comment '课程内容',
    teacher_id          int comment '老师id',
    teacher_name        STRING comment '老师名字',
    job_number          STRING comment '工号',
    classroom_id        int comment '教室id',
    classroom_name      STRING comment '教室名称',
    is_outline          int comment '是否大纲 0 否 1 是',
    class_mode          int comment '上课模式 0 传统全天 1 AB上午 2 AB下午 3 线上直播',
    is_stage_exam       int comment '是否阶段考试（0：否 1：是）',
    is_pay              int comment '代课费（0：无 1：有）',
    tutor_teacher_id    int comment '晚自习辅导老师id',
    tutor_teacher_name  STRING comment '辅导老师姓名',
    tutor_job_number    STRING comment '晚自习辅导老师工号',
    is_subsidy          int comment '晚自习补贴（0：无 1：有）',
    answer_teacher_id   int comment '答疑老师id',
    answer_teacher_name STRING comment '答疑老师姓名',
    answer_job_number   STRING comment '答疑老师工号',
    remark              STRING comment '备注',
    create_time         STRING comment '创建时间'
)
    comment '班级课表明细表'
    PARTITIONED BY (dt STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    stored as orcfile
    TBLPROPERTIES ('orc.compress' = 'SNAPPY','orc.bloom.filter.columns' = 'class_id,class_date');

-- 班级作息时间表
CREATE TABLE IF NOT EXISTS itcast_dimen.class_time_dimen
(
    id                    int,
    class_id              int comment '班级id',
    morning_template_id   int comment '上午出勤模板id',
    morning_begin_time    STRING comment '上午开始时间',
    morning_end_time      STRING comment '上午结束时间',
    afternoon_template_id int comment '下午出勤模板id',
    afternoon_begin_time  STRING comment '下午开始时间',
    afternoon_end_time    STRING comment '下午结束时间',
    evening_template_id   int comment '晚上出勤模板id',
    evening_begin_time    STRING comment '晚上开始时间',
    evening_end_time      STRING comment '晚上结束时间',
    use_begin_date        STRING comment '使用开始日期',
    use_end_date          STRING comment '使用结束日期',
    create_time           STRING comment '创建时间',
    create_person         int comment '创建人',
    remark                STRING comment '备注'
)
    comment '班级作息时间表'
    PARTITIONED BY (dt STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    stored as orcfile
    TBLPROPERTIES ('orc.compress' = 'SNAPPY','orc.bloom.filter.columns' = 'id,class_id');


-- 当日在读人数表:
CREATE TABLE IF NOT EXISTS itcast_dimen.class_studying_student_count_dimen
(
    id                     int,
    school_id              int comment '校区id',
    subject_id             int comment '学科id',
    class_id               int comment '班级id',
    studying_student_count int comment '在读班级人数',
    studying_date          STRING comment '在读日期'
)
    comment '在读班级的每天在读学员人数'
    PARTITIONED BY (dt STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    stored as orcfile
    TBLPROPERTIES ('orc.compress' = 'SNAPPY','orc.bloom.filter.columns' = 'studying_student_count,studying_date');