
/*
ods=元数据层
dwd=清洗删除 做判断 需已支付的/线上线下做转换/年月日分区
zx_dm=zx_dwm /dwm层在dwd层基础上关联出校区,学科 获取到所需要的字段.
dws=dws在dwm层的基础上按照维度进行统计,得到统计宽表
rpt层=按需求做统计

在这个项目中
用到了 if 判断
case when then
 */
--创建dwd关系表
CREATE TABLE IF NOT EXISTS zx_dwd.customer_relationship_dwd (
  `id` int COMMENT '客户关系id',
  `customer_id` int COMMENT '所属客户id',
  `origin_type` STRING COMMENT '数据来源',
  `payment_time` STRING COMMENT '支付状态变动时间字符串',
  `payment_time_hour` STRING COMMENT '支付状态变动小时',
  `itcast_clazz_id` int COMMENT '报名课程id',
  `creator` int COMMENT '创建人id',
  `origin_type_stat` STRING COMMENT '数据来源:0.线下；1.线上' )
comment '客户关系表'
PARTITIONED BY (payment_time_year String, payment_time_month String, payment_time_day String)
CLUSTERED BY(id) sorted by(id) into 10 buckets
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
stored as orc
TBLPROPERTIES ('orc.compress'='SNAPPY','orc.create.index'='true','orc.bloom.filter.columns'='itcast_clazz_id,creator');

--创建dwd班级信息表
CREATE EXTERNAL TABLE IF NOT EXISTS zx_dwd.itcast_clazz_dwd (
  id int COMMENT 'ems课程id(非自增)',
  create_date_time STRING COMMENT '创建时间',
  update_date_time STRING COMMENT '最后更新时间',
  deleted STRING COMMENT '是否被删除（禁用）',
  itcast_school_id STRING COMMENT 'ems校区ID',
  itcast_school_name STRING COMMENT 'ems校区名称',
  itcast_subject_id STRING COMMENT 'ems学科ID',
  itcast_subject_name STRING COMMENT 'ems学科名称',
  itcast_brand STRING COMMENT 'ems品牌',
  clazz_type_state STRING COMMENT '班级类型状态',
  clazz_type_name STRING COMMENT '班级类型名称',
  teaching_mode STRING COMMENT '授课模式',
  start_time STRING COMMENT '开班时间',
  end_time STRING COMMENT '毕业时间',
  comment STRING COMMENT '备注',
  detail STRING COMMENT '详情(比如：27期)',
  uncertain STRING COMMENT '待定班(0:否,1:是)',
  tenant int COMMENT '租户',
  ends_time STRING COMMENT '有效时间')
comment '班级信息表'
PARTITIONED BY(starts_time STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
stored as orc
TBLPROPERTIES ('orc.compress'='SNAPPY','orc.create.index'='true','orc.bloom.filter.columns'='id');


---------------------
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=10000;
set hive.exec.max.dynamic.partitions=100000;
set hive.exec.max.created.files=150000;
--hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
--分桶
set hive.enforce.bucketing=true;
set hive.enforce.sorting=true;
set hive.optimize.bucketmapjoin = true;
set hive.auto.convert.sortmerge.join=true;
set hive.auto.convert.sortmerge.join.noconditionaltask=true;
--并行执行
set hive.exec.parallel=true;
set hive.exec.parallel.thread.number=8;
--矢量化查询
set hive.vectorized.execution.enabled=true;
--读取零拷贝
set hive.exec.orc.zerocopy=true;

--往关系表里插入数据
insert into zx_dwd.customer_relationship_dwd PARTITION(payment_time_year, payment_time_month, payment_time_day)
SELECT
    id,
    customer_id,
    origin_type,
    payment_time,
    substr(payment_time, 12, 2) as payment_time_hour,
    nvl(itcast_clazz_id, -1) itcast_clazz_id,
    nvl(creator, -1) creator,
    if(origin_type='NETSERVICE' or origin_type='PRESIGNUP', '1', '0') origin_type_stat,
    substr(payment_time, 1, 4) payment_time_year, --年
    substr(payment_time, 6, 2) payment_time_month,--月
    substr(payment_time, 9, 2) payment_time_day --日
from zx_ods.customer_relationship
WHERE deleted = 'false' and customer_id is not null and payment_state='PAID';
--where 取未删除的   id 去null      支付状态取PAID

--往班级信息里插入数据
insert into zx_dwd.itcast_clazz_dwd PARTITION(starts_time)
select
id,
create_date_time,
update_date_time,
deleted,
itcast_school_id,
itcast_school_name,
itcast_subject_id,
itcast_subject_name,
itcast_brand,
clazz_type_state,
clazz_type_name,
teaching_mode,
start_time,
end_time,
comment,
detail,
uncertain,
tenant,
'2022-08-23' starts_time,
'9999-12-31' ends_time
from zx_ods.itcast_clazz;

--报名人数统计中心层
CREATE TABLE IF NOT EXISTS zx_dm.customer_signup_dm (
  `customer_id` int COMMENT '报名客户id',
  `itcast_school_id` STRING COMMENT '学校id',
  `itcast_school_name` STRING COMMENT '学校namne',
  `itcast_subject_id` STRING COMMENT '学科id',
  `itcast_subject_name` STRING COMMENT '学科name',
  `origin_type` STRING COMMENT '来源渠道',
  origin_type_stat STRING COMMENT '数据来源:0.线下；1.线上',
  `payment_time_hour` STRING COMMENT '最后更新时间')
comment '报名人数统计中间表'
PARTITIONED BY (payment_time_year String, payment_time_month String, payment_time_day String)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
stored as orc
TBLPROPERTIES ('orc.compress'='SNAPPY');

--报名人统计业务
CREATE TABLE IF NOT EXISTS zx_dws.customer_signup_dws (
  `signup_num` int COMMENT '报名人数',
  `itcast_school_id` STRING COMMENT '学校id',
  `itcast_school_name` STRING COMMENT '学校namne',
  `itcast_subject_id` STRING COMMENT '学科id',
  `itcast_subject_name` STRING COMMENT '学科name',
  `origin_type` STRING COMMENT '来源渠道',
  origin_type_stat STRING COMMENT '数据来源:0.线下；1.线上',
  `payment_time_hour` STRING COMMENT '最后更新时间',
  groupType STRING COMMENT '业务分组类型：1：校区、2学科；3:所有',
  time_type STRING COMMENT '聚合时间类型：1、按小时聚合；2、按天聚合；3、按月聚合；4、按年聚合。'
  )
comment '报名人数统计业务表'
PARTITIONED BY (payment_time_year String, payment_time_month String, payment_time_day String)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
stored as orc
TBLPROPERTIES ('orc.compress'='SNAPPY');

--插入数据
INSERT into zx_dm.customer_signup_dm PARTITION (payment_time_year, payment_time_month, payment_time_day)
SELECT
    dwd.customer_id,
    ic.itcast_school_id,
    ic.itcast_school_name,
    ic.itcast_subject_id,
    ic.itcast_subject_name,
    dwd.origin_type,
    dwd.origin_type_stat,
    dwd.payment_time_hour,
    dwd.payment_time_year,
    dwd.payment_time_month,
    dwd.payment_time_day
FROM zx_dwd.customer_relationship_dwd dwd
LEFT JOIN zx_ods.itcast_clazz ic on dwd.itcast_clazz_id=ic.id;


--小时
INSERT INTO zx_dws.customer_signup_dws PARTITION(payment_time_year, payment_time_month, payment_time_day)
SELECT
    count(dm.customer_id) as signup_num,
    dm.itcast_school_id,
    dm.itcast_school_name,
    dm.itcast_subject_id,
    dm.itcast_subject_name,
    '-1' origin_type,
    dm.origin_type_stat,
    dm.payment_time_hour,
    '1' grouptype,
    '1' as time_type,
    dm.payment_time_year,
    dm.payment_time_month,
    dm.payment_time_day
from zx_dm.customer_signup_dm dm
where dm.itcast_school_id!='null'
GROUP BY dm.origin_type_stat,
    dm.payment_time_year,  dm.payment_time_month,  dm.payment_time_day,  dm.payment_time_hour,
     dm.itcast_school_id,  dm.itcast_school_name,  dm.itcast_subject_id,  dm.itcast_subject_name;


SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=10000;
set hive.exec.max.dynamic.partitions=100000;
set hive.exec.max.created.files=150000;
--hive压缩
set hive.exec.compress.intermediate=true;
set hive.exec.compress.output=true;
--写入时压缩生效
set hive.exec.orc.compression.strategy=COMPRESSION;
--分桶
set hive.enforce.bucketing=true;
set hive.enforce.sorting=true;
set hive.optimize.bucketmapjoin = true;
set hive.auto.convert.sortmerge.join=true;
set hive.auto.convert.sortmerge.join.noconditionaltask=true;
--并行执行
set hive.exec.parallel=true;
set hive.exec.parallel.thread.number=8;
--矢量化查询
set hive.vectorized.execution.enabled=true;
--读取零拷贝
set hive.exec.orc.zerocopy=true;
--天
INSERT INTO zx_dws.customer_signup_dws PARTITION(payment_time_year, payment_time_month, payment_time_day)
SELECT
    count(dm.customer_id) as signup_num,
    dm.itcast_school_id,
    dm.itcast_school_name,
    dm.itcast_subject_id,
    dm.itcast_subject_name,
    '-1' origin_type,
    dm.origin_type_stat,
    dm.payment_time_hour,
    '1' grouptype,
    '2' as time_type,
    dm.payment_time_year,
    dm.payment_time_month,
    dm.payment_time_day
from zx_dm.customer_signup_dm dm
GROUP BY dm.origin_type_stat,
    dm.payment_time_year,  dm.payment_time_month,  dm.payment_time_day,  dm.payment_time_hour,
     dm.itcast_school_id,  dm.itcast_school_name,  dm.itcast_subject_id,  dm.itcast_subject_name;

--月
INSERT INTO zx_dws.customer_signup_dws PARTITION(payment_time_year, payment_time_month, payment_time_day)
SELECT
    count(dm.customer_id) as signup_num,
    dm.itcast_school_id,
    dm.itcast_school_name,
    dm.itcast_subject_id,
    dm.itcast_subject_name,
    '-1' origin_type,
    dm.origin_type_stat,
    dm.payment_time_hour,
    '1' grouptype,
    '3' as time_type,
    dm.payment_time_year,
    dm.payment_time_month,
    dm.payment_time_day
from zx_dm.customer_signup_dm dm
GROUP BY dm.origin_type_stat,
    dm.payment_time_year,  dm.payment_time_month,  dm.payment_time_day,  dm.payment_time_hour,
     dm.itcast_school_id,  dm.itcast_school_name,  dm.itcast_subject_id,  dm.itcast_subject_name;

--年
INSERT INTO zx_dws.customer_signup_dws PARTITION(payment_time_year, payment_time_month, payment_time_day)
SELECT
    count(dm.customer_id) as signup_num,
    dm.itcast_school_id,
    dm.itcast_school_name,
    dm.itcast_subject_id,
    dm.itcast_subject_name,
    '-1' origin_type,
    dm.origin_type_stat,
    dm.payment_time_hour,
    '1' grouptype,
    '4' as time_type,
    dm.payment_time_year,
    dm.payment_time_month,
    dm.payment_time_day
from zx_dm.customer_signup_dm dm
GROUP BY dm.origin_type_stat,
    dm.payment_time_year,  dm.payment_time_month,  dm.payment_time_day,  dm.payment_time_hour,
     dm.itcast_school_id,  dm.itcast_school_name,  dm.itcast_subject_id,  dm.itcast_subject_name;


--年总报名数/已支付的
create table zx_rpt.application_sum(
    id  bigint,
    payment_time_year string
)comment '年/总报名数量已支付'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
stored as orc
TBLPROPERTIES ('orc.compress'='SNAPPY','orc.create.index'='true','orc.bloom.filter.columns'='id');
--年总报名数
insert into zx_rpt.application_sum
select
count(),
payment_time_year
from zx_dm.customer_signup_dm
group by payment_time_year ;

--月总报名数/已支付的
create table zx_rpt.applicamonth_sum(
    id  bigint,
    payment_time_month string
)comment '月/总报名数量已支付'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
stored as orc
TBLPROPERTIES ('orc.compress'='SNAPPY','orc.create.index'='true','orc.bloom.filter.columns'='id');
--月总报名数
insert into zx_rpt.applicamonth_sum
select
count(),
payment_time_month
from zx_dm.customer_signup_dm
group by payment_time_month;
--线上报名量 年
create table zx_rpt.online_year(
    id  bigint,
    payment_time_year string
)comment '年/线上报名总量已支付'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
stored as orc
TBLPROPERTIES ('orc.compress'='SNAPPY','orc.create.index'='true','orc.bloom.filter.columns'='id');
--线上报名量 年
insert into zx_rpt.online_year
select
count(),
payment_time_year
from zx_dm.customer_signup_dm
where origin_type_stat='1'
group by payment_time_year;

--月 线上报名量
create table zx_rpt.online_month(
    id  bigint,
    payment_time_month string
)comment '月/线上报名量已支付'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
stored as orc
TBLPROPERTIES ('orc.compress'='SNAPPY','orc.create.index'='true','orc.bloom.filter.columns'='id');
--线上报名量/月
insert into zx_rpt.online_month
select
count(),
payment_time_month
from zx_dm.customer_signup_dm
where origin_type_stat='1'
group by payment_time_month;


--校区学科报名统计
create table zx_rpt.School_enrollment(
    signup_num            bigint,
    origin_type_stat  string ,
    itcast_school_name  string ,
    itcast_subject_name  string ,
    payment_time_year  string ,
    payment_time_month  string ,
    payment_time_day  string ,
    payment_time_hour  string
)comment '各校区学科报名统计'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
stored as orc
TBLPROPERTIES ('orc.compress'='SNAPPY','orc.create.index'='true','orc.bloom.filter.columns'='id');

--往各校区学科同统计表插入数据(在presto)执行
insert into zx_rpt.School_enrollment(
select
count(signup_num),
origin_type_stat,  --线上/线下
itcast_school_name, --校区
itcast_subject_name, --学科
payment_time_year, --年
payment_time_month,--月
payment_time_day, --日
payment_time_hour --小时
from zx_dws.customer_signup_dws
where origin_type_stat='1'
group by
grouping sets(
    (payment_time_year), --年
    (payment_time_year,itcast_school_name),
    (payment_time_year,itcast_school_name,origin_type_stat),

    (payment_time_year), --年
    (payment_time_year,itcast_subject_name),
    (payment_time_year,itcast_subject_name,origin_type_stat),

    (payment_time_month), --月
    (payment_time_month,itcast_school_name),
    (payment_time_month,itcast_school_name,origin_type_stat),

    (payment_time_month), --月
    (payment_time_month,itcast_subject_name),
    (payment_time_month,itcast_subject_name,origin_type_stat),


    (payment_time_day),--日
    (payment_time_day,itcast_school_name),
    (payment_time_day,itcast_school_name,origin_type_stat),


    (payment_time_day),--日
    (payment_time_day,itcast_subject_name),
    (payment_time_day,itcast_subject_name,origin_type_stat),


    (payment_time_hour), --小时
    (payment_time_hour,itcast_school_name),
    (payment_time_hour,itcast_school_name,origin_type_stat),

    (payment_time_hour), --小时
    (payment_time_hour,itcast_subject_name),
    (payment_time_hour,itcast_subject_name,origin_type_stat)
)
)


