--------һ��----------------------------------------
create database ODS;
--------�򿨼�¼��-----------------------------------
create table if not exists ODS.student_signin_ods(
    id                int            comment '����id',
    normal_class_flag int            comment '�Ƿ����� 1 ���� 2 ��ϰ',
    time_table_id     int            comment '��Ϣʱ��id ����tbh_school_time_table ���� tbh_class_time_table',
    class_id          int            comment '�༶id',
    student_id        int            comment 'ѧԱid',
    signin_time       string         comment 'ǩ��ʱ��',
    signin_date       string         comment 'ǩ������',
    inner_flag        int            comment '��������־  0 ���� 1 ����',
    signin_type       int            comment 'ǩ������ 1 ������ 2 ��ʦ����',
    share_state       int            comment '������Ļ״̬ 0 �� 1��  �������������й�����¼����ö����м�¼���ֶ�Ϊ1������Ĭ��Ϊ1 ����Ĭ��Ϊ0 ',
    inner_ip          string         comment '����ip��ַ'
)
comment 'ѧ���򿨼�¼��'
partitioned by (dt string)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------ѧ����ټ�¼��--------------------------------
create table if not exists ODS.student_leave_apply_ods(
    id              int  ,
    class_id        int            comment '�༶id',
    student_id      int            comment 'ѧԱid',
    audit_state     int            comment '���״̬ 0 ����� 1 ͨ�� 2 ��ͨ��',
    audit_person    int            comment '�����',
    audit_time      string         comment '���ʱ��',
    audit_remark    string         comment '��˱�ע',
    leave_type      int            comment '�������  1 ��� 2 ����',
    leave_reason    int            comment '���ԭ��  1 �¼� 2 ����',
    begin_time      string         comment '��ٿ�ʼʱ��',
    begin_time_type int            comment '1������ 2������',
    end_time        string         comment '��ٽ���ʱ��',
    end_time_type   int            comment '1������ 2������',
    days            float          comment '���/��������',
    cancel_state    int            comment '����״̬  0 δ���� 1 �ѳ���',
    cancel_time     string         comment '����ʱ��',
    old_leave_id    int            comment 'ԭ���id��ֻ��leave_type =2 ���ٵ�ʱ�����',
    leave_remark    string         comment '���/����˵��',
    valid_state     int            comment '�Ƿ���Ч��0����Ч 1����Ч��',
    create_time     string         comment '����ʱ��'
)
comment 'ѧ����ټ�¼��'
partitioned by (dt string)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------����----------------------------------------
create database DIM;
--------�����ڶ��༶��ÿ���ڶ�ѧԱ����-------------------
create table if not exists DIM.class_studying_student_count_dimen(
    id                     int,
    school_id              int  comment 'У��id',
    subject_id             int  comment 'ѧ��id',
    class_id               int  comment '�༶id',
    studying_student_count int  comment '�ڶ��༶����',
    studying_date          STRING comment '�ڶ�����'
)
comment '�ڶ��༶��ÿ���ڶ�ѧԱ����'
partitioned by (dt string)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------�������ڿγ̱�--------------------------------
create table if not exists DIM.course_table_upload_detail_dimen(
id                      int,
    base_id             int            comment '�γ�����id',
    class_id            int            comment '�༶id',
    class_date          string         comment '�Ͽ�����',
    content             string         comment '�γ�����',
    teacher_id          int            comment '��ʦid',
    teacher_name        string         comment '��ʦ����',
    job_number          string         comment '����',
    classroom_id        int            comment '����id',
    classroom_name      string         comment '��������',
    is_outline          int            comment '�Ƿ��� 0 �� 1 ��',
    class_mode          int            comment '�Ͽ�ģʽ 0 ��ͳȫ�� 1 AB���� 2 AB���� 3 ����ֱ��',
    is_stage_exam       int            comment '�Ƿ�׶ο��ԣ�0���� 1���ǣ�',
    is_pay              int            comment '���ηѣ�0���� 1���У�',
    tutor_teacher_id    int            comment '����ϰ������ʦid',
    tutor_teacher_name  string         comment '������ʦ����',
    tutor_job_number    string         comment '����ϰ������ʦ����',
    is_subsidy          int            comment '����ϰ������0���� 1���У�',
    answer_teacher_id   int            comment '������ʦid',
    answer_teacher_name string         comment '������ʦ����',
    answer_job_number   string         comment '������ʦ����',
    remark              string         comment '��ע',
    create_time         string         comment '����ʱ��'
)
comment '���ڿγ̱�'
partitioned by (dt string)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------����༶��Ϣ��--------------------------------
create table if not exists DIM.class_time_dimen(
    id                    int  ,
    class_id              int           comment '�༶id',
    morning_template_id    int           comment '�������ģ��id',
    morning_begin_time    string        comment '���翪ʼʱ��',
    morning_end_time      string        comment '�������ʱ��',
    afternoon_template_id int           comment '�������ģ��id',
    afternoon_begin_time  string        comment '���翪ʼʱ��',
    afternoon_end_time    string        comment '�������ʱ��',
    evening_template_id   int           comment '���ϳ���ģ��id',
    evening_begin_time    string        comment '���Ͽ�ʼʱ��',
    evening_end_time      string        comment '���Ͻ���ʱ��',
    use_begin_date        string        comment 'ʹ�ÿ�ʼ����',
    use_end_date          string        comment 'ʹ�ý�������',
    create_time           string        comment '����ʱ��',
    create_person         int           comment '������',
    remark                string        comment '��ע'
)
comment '�༶��Ϣ��'
partitioned by (dt string)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------����----------------------------------------
create database DWM;
--------ѧ��������Ϣ��--------------------------------
create table if not exists DWM.student_attendance_dwm(
    dateinfo        String        comment '����',
    class_id        int           comment '�༶id',
    student_id      int           comment 'ѧԱid',
    morning_att     String        comment '������������0.�������ڡ�1.�ٵ���2.���������+���Σ�',
    afternoon_att   String        comment '������������0.�������ڡ�1.�ٵ���2.���������+���Σ�',
    evening_att     String        comment '����ϰ���������0.�������ڡ�1.�ٵ���2.���������+���Σ�'
)
comment 'ѧ��������Ϣ��'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------�༶������Ϣ���������ںͳٵ���-------------------
create table if not exists DWM.class_attendance_dwm(
    dateinfo                String        comment '����',
    class_id                int           comment '�༶id',
    morning_att_count       String        comment '�����������',
    afternoon_att_count     String        comment '�����������',
    evening_att_count       String        comment '����ϰ��������',
    morning_late_count      String        comment '����ٵ�����',
    afternoon_late_count    String        comment '����ٵ�����',
    evening_late_count      String        comment '����ϰ�ٵ�����'
)
comment '�༶������Ϣ���������ںͳٵ���'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------�༶���������--------------------------------
create table if not exists DWM.class_leave_dwm(
    dateinfo                   String        comment '����',
    class_id                   int           comment '�༶id',
    morning_leave_count        String        comment '�����������',
    afternoon_leave_count      String        comment '�����������',
    evening_leave_count        String        comment '����ϰ�������'
)
comment '�༶���������'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------�༶��������----------------------------------
create table if not exists DWM.class_truant_dwm(
    dateinfo                    String        comment '����',
    class_id                    int           comment '�༶id',
    morning_truant_count        String        comment '�����������',
    afternoon_truant_count      String        comment '�����������',
    evening_truant_count        String        comment '����ϰ��������'
)
comment '�༶��������'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
--------�༶��ۺͱ�----------------------------------
create table if not exists DWM.attendance_summary_dwm(
    dateinfo                    String        comment '����',
    class_id                    int           comment '�༶id',
    studying_student_count      int           comment '�ڶ��༶����',
    morning_att_count           String        comment '�����������',
    morning_att_ratio           String        comment '���������',
    afternoon_att_count         String        comment '�����������',
    afternoon_att_ratio         String        comment '���������',
    evening_att_count           String        comment '����ϰ��������',
    evening_att_ratio           String        comment '����ϰ������',
    morning_late_count          String        comment '����ٵ�����',
    morning_late_ratio          String        comment '����ٵ���',
    afternoon_late_count        String        comment '����ٵ�����',
    afternoon_late_ratio        String        comment '����ٵ���',
    evening_late_count          String        comment '����ϰ�ٵ�����',
    evening_late_ratio          String        comment '����ϰ�ٵ���',
    morning_leave_count         String        comment '�����������',
    morning_leave_ratio         String        comment '���������',
    afternoon_leave_count       String        comment '�����������',
    afternoon_leave_ratio       String        comment '���������',
    evening_leave_count         String        comment '����ϰ�������',
    evening_leave_ratio         String        comment '����ϰ�����',
    morning_truant_count        String        comment '�����������',
    morning_truant_ratio        String        comment '���������',
    afternoon_truant_count      String        comment '�����������',
    afternoon_truant_ratio      String        comment '���������',
    evening_truant_count        String        comment '����ϰ��������',
    evening_truant_ratio        String        comment '����ϰ������'
)
comment '�༶��ۺͱ�'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
-------�Ĳ�------------------------------------------
create database DWS;
-------�༶������Ϣ���������ʵ�֣�----------------------
create table if not exists DWS.class_attendance_dws(
    dateinfo                    String        comment '����',
    class_id                    int           comment '�༶id',
    studying_student_count      int           comment '�ڶ��༶����',
    morning_att_count           String        comment '�����������',
    morning_att_ratio           String        comment '���������',
    afternoon_att_count         String        comment '�����������',
    afternoon_att_ratio         String        comment '���������',
    evening_att_count           String        comment '����ϰ��������',
    evening_att_ratio           String        comment '����ϰ������',
    morning_late_count          String        comment '����ٵ�����',
    morning_late_ratio          String        comment '����ٵ���',
    afternoon_late_count        String        comment '����ٵ�����',
    afternoon_late_ratio        String        comment '����ٵ���',
    evening_late_count          String        comment '����ϰ�ٵ�����',
    evening_late_ratio          String        comment '����ϰ�ٵ���',
    morning_leave_count         String        comment '�����������',
    morning_leave_ratio         String        comment '���������',
    afternoon_leave_count       String        comment '�����������',
    afternoon_leave_ratio       String        comment '���������',
    evening_leave_count         String        comment '����ϰ�������',
    evening_leave_ratio         String        comment '����ϰ�����',
    morning_truant_count        String        comment '�����������',
    morning_truant_ratio        String        comment '���������',
    afternoon_truant_count      String        comment '�����������',
    afternoon_truant_ratio      String        comment '���������',
    evening_truant_count        String        comment '����ϰ��������',
    evening_truant_ratio        String        comment '����ϰ������'
)
comment '�ۺ�ʱ�����ͣ�1����Сʱ�ۺϣ�2������ۺϣ�3�����ܾۺϣ�4�����¾ۺϣ�5������ۺ�'
partitioned by (yearinfo STRING, monthinfo STRING, dayinfo STRING)
row format delimited
fields terminated by '\t'
stored as orcfile
tblproperties ('orc.compress'='SNAPPY','orc.bloom.filter.columns'='time_table_id,class_id,signin_date,share_state');
----------------------------------------------------