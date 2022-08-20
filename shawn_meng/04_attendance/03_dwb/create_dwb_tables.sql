-- 学生出勤状态信息表
CREATE TABLE IF NOT EXISTS itcast_dwm.student_attendance_dwm
(
    dateinfo      String comment '日期',
    class_id      int comment '班级id',
    student_id    int comment '学员id',
    morning_att   String comment '上午出勤情况：0.正常出勤、1.迟到、2.其他（请假+旷课）',
    afternoon_att String comment '下午出勤情况：0.正常出勤、1.迟到、2.其他（请假+旷课）',
    evening_att   String comment '晚自习出勤情况：0.正常出勤、1.迟到、2.其他（请假+旷课）'
)
    comment '学生出勤(正常出勤和迟到)数据'
    PARTITIONED BY (yearinfo STRING, monthinfo STRING, dayinfo STRING)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
    stored as orcfile
    TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- 班级出勤人数表:
CREATE TABLE IF NOT EXISTS itcast_dwm.class_attendance_dwm
(
    dateinfo             String comment '日期',
    class_id             int comment '班级id',
    morning_att_count    String comment '上午出勤人数',
    afternoon_att_count  String comment '下午出勤人数',
    evening_att_count    String comment '晚自习出勤人数',
    morning_late_count   String comment '上午迟到人数',
    afternoon_late_count String comment '下午迟到人数',
    evening_late_count   String comment '晚自习迟到人数'
)
    comment '学生出勤(正常出勤和迟到)数据'
    PARTITIONED BY (yearinfo STRING, monthinfo STRING, dayinfo STRING)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
    stored as orcfile
    TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- 班级请假人数表
CREATE TABLE IF NOT EXISTS itcast_dwm.class_leave_dwm
(
    dateinfo              String comment '日期',
    class_id              int comment '班级id',
    morning_leave_count   String comment '上午请假人数',
    afternoon_leave_count String comment '下午请假人数',
    evening_leave_count   String comment '晚自习请假人数'
)
    comment '班级请假数据统计'
    PARTITIONED BY (yearinfo STRING, monthinfo STRING, dayinfo STRING)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
    stored as orcfile
    TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- 班级旷课人数表
CREATE TABLE IF NOT EXISTS itcast_dwm.class_truant_dwm
(
    dateinfo               String comment '日期',
    class_id               int comment '班级id',
    morning_truant_count   String comment '上午旷课人数',
    afternoon_truant_count String comment '下午旷课人数',
    evening_truant_count   String comment '晚自习旷课人数'
)
    comment '班级请假数据统计'
    PARTITIONED BY (yearinfo STRING, monthinfo STRING, dayinfo STRING)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
    stored as orcfile
    TBLPROPERTIES ('orc.compress' = 'SNAPPY');

-- 汇总表

CREATE TABLE IF NOT EXISTS itcast_dwm.class_all_dwm
(
    dateinfo               String comment '日期',
    class_id               int comment '班级id',
    studying_student_count int comment '在读班级人数',
    morning_att_count      String comment '上午出勤人数',
    morning_att_ratio      String comment '上午出勤率',
    afternoon_att_count    String comment '下午出勤人数',
    afternoon_att_ratio    String comment '下午出勤率',
    evening_att_count      String comment '晚自习出勤人数',
    evening_att_ratio      String comment '晚自习出勤率',
    morning_late_count     String comment '上午迟到人数',
    morning_late_ratio     String comment '上午迟到率',
    afternoon_late_count   String comment '下午迟到人数',
    afternoon_late_ratio   String comment '下午迟到率',
    evening_late_count     String comment '晚自习迟到人数',
    evening_late_ratio     String comment '晚自习迟到率',
    morning_leave_count    String comment '上午请假人数',
    morning_leave_ratio    String comment '上午请假率',
    afternoon_leave_count  String comment '下午请假人数',
    afternoon_leave_ratio  String comment '下午请假率',
    evening_leave_count    String comment '晚自习请假人数',
    evening_leave_ratio    String comment '晚自习请假率',
    morning_truant_count   String comment '上午旷课人数',
    morning_truant_ratio   String comment '上午旷课率',
    afternoon_truant_count String comment '下午旷课人数',
    afternoon_truant_ratio String comment '下午旷课率',
    evening_truant_count   String comment '晚自习旷课人数',
    evening_truant_ratio   String comment '晚自习旷课率'
)
    comment '班级请假数据统计'
    PARTITIONED BY (yearinfo STRING, monthinfo STRING, dayinfo STRING)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
    stored as orcfile
    TBLPROPERTIES ('orc.compress' = 'SNAPPY');