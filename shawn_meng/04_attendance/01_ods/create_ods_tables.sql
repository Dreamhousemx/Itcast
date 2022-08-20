-- 学生打卡信息表:
CREATE TABLE IF NOT EXISTS itcast_ods.student_signin_ods
(
    id                int,
    normal_class_flag int comment '是否正课 1 正课 2 自习 3 休息',
    time_table_id     int comment '作息时间id normal_class_flag=2 关联tbh_school_time_table 或者 normal_class_flag=1 关联 tbh_class_time_table',
    class_id          int comment '班级id',
    student_id        int comment '学员id',
    signin_time       String comment '签到时间',
    signin_date       String comment '签到日期',
    inner_flag        int comment '内外网标志  0 外网 1 内网',
    signin_type       int comment '签到类型 1 心跳打卡 2 老师补卡 3 直播打卡',
    share_state       int comment '共享屏幕状态 0 否 1是  在上午或下午段有共屏记录，则该段所有记录该字段为1，内网默认为1 外网默认为0   (暂不用)',
    inner_ip          String comment '内网ip地址',
    create_time       String comment '创建时间'
)
    comment '学生打卡记录表'
    PARTITIONED BY (dt STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    stored as orcfile
    TBLPROPERTIES ('orc.compress' = 'SNAPPY','orc.bloom.filter.columns' =
            'time_table_id,class_id,signin_date,share_state');

-- 学生请假信息表:
CREATE TABLE IF NOT EXISTS itcast_ods.student_leave_apply_ods
(
    id              int,
    class_id        int comment '班级id',
    student_id      int comment '学员id',
    audit_state     int comment '审核状态 0 待审核 1 通过 2 不通过',
    audit_person    int comment '审核人',
    audit_time      String comment '审核时间',
    audit_remark    String comment '审核备注',
    leave_type      int comment '请假类型  1 请假 2 销假 （查询是否请假不用过滤此类型，通过有效状态来判断）',
    leave_reason    int comment '请假原因  1 事假 2 病假',
    begin_time      String comment '请假开始时间',
    begin_time_type int comment '1：上午 2：下午 3：晚自习',
    end_time        String comment '请假结束时间',
    end_time_type   int comment '1：上午 2：下午 3：晚自习',
    days            float comment '请假/已休天数',
    cancel_state    int comment '撤销状态  0 未撤销 1 已撤销',
    cancel_time     String comment '撤销时间',
    old_leave_id    int comment '原请假id，只有leave_type =2 销假的时候才有',
    leave_remark    String comment '请假/销假说明',
    valid_state     int comment '是否有效（0：无效 1：有效）',
    create_time     String comment '创建时间'
)
    comment '学生请假申请表'
    PARTITIONED BY (dt STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
    stored as orcfile
    TBLPROPERTIES ('orc.compress' = 'SNAPPY','orc.bloom.filter.columns' =
            'class_id,audit_state,cancel_state,valid_state');