--分区
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
--关联优化器
set hive.optimize.correlation=true;
--读取零拷贝
set hive.exec.orc.zerocopy=true;
--join数据倾斜
set hive.optimize.skewjoin=true;
-- set hive.skewjoin.key=100000;
set hive.optimize.skewjoin.compiletime=true;
set hive.optimize.union.remove=true;
-- group倾斜
set hive.groupby.skewindata=true;


--校区、学科组合分组
--小时
INSERT INTO itcast_dws.customer_signup_dws PARTITION (payment_time_year, payment_time_month, payment_time_day)
SELECT count(dwm.customer_id) as signup_num,
       dwm.itcast_school_id,
       dwm.itcast_school_name,
       dwm.itcast_subject_id,
       dwm.itcast_subject_name,
       -1                     as tdepart_id,
       '-1'                      tdepart_name,
       '-1'                      origin_type,
       dwm.origin_type_stat,
       dwm.payment_time_hour,
       '1'                       grouptype,
       '1'                    as time_type,
       dwm.payment_time_year,
       dwm.payment_time_month,
       dwm.payment_time_day
from itcast_dwm.customer_signup_dwm dwm
where CONCAT_WS('-', dwm.payment_time_year, dwm.payment_time_month, dwm.payment_time_day) >= '2037-02-01'
GROUP BY dwm.origin_type_stat,
         dwm.payment_time_year, dwm.payment_time_month, dwm.payment_time_day, dwm.payment_time_hour,
         dwm.itcast_school_id, dwm.itcast_school_name, dwm.itcast_subject_id, dwm.itcast_subject_name;
--天
INSERT INTO itcast_dws.customer_signup_dws PARTITION (payment_time_year, payment_time_month, payment_time_day)
SELECT count(dwm.customer_id) as signup_num,
       dwm.itcast_school_id,
       dwm.itcast_school_name,
       dwm.itcast_subject_id,
       dwm.itcast_subject_name,
       -1                     as tdepart_id,
       '-1'                      tdepart_name,
       '-1'                      origin_type,
       dwm.origin_type_stat,
       '-1'                      payment_time_hour,
       '1'                       grouptype,
       '2'                    as time_type,
       dwm.payment_time_year,
       dwm.payment_time_month,
       dwm.payment_time_day
from itcast_dwm.customer_signup_dwm dwm
where CONCAT_WS('-', dwm.payment_time_year, dwm.payment_time_month, dwm.payment_time_day) >= '2037-02-01'
GROUP BY dwm.origin_type_stat,
         dwm.payment_time_year, dwm.payment_time_month, dwm.payment_time_day,
         dwm.itcast_school_id, dwm.itcast_school_name, dwm.itcast_subject_id, dwm.itcast_subject_name;
--月、年省略


--来源渠道分组
--小时
INSERT INTO itcast_dws.customer_signup_dws PARTITION (payment_time_year, payment_time_month, payment_time_day)
SELECT count(dwm.customer_id) as signup_num,
       '-1'                      itcast_school_id,
       '-1'                      itcast_school_name,
       '-1'                      itcast_subject_id,
       '-1'                      itcast_subject_name,
       -1                     as tdepart_id,
       '-1'                      tdepart_name,
       dwm.origin_type,
       dwm.origin_type_stat,
       dwm.payment_time_hour,
       '2'                       grouptype,
       '1'                    as time_type,
       dwm.payment_time_year,
       dwm.payment_time_month,
       dwm.payment_time_day
from itcast_dwm.customer_signup_dwm dwm
where CONCAT_WS('-', dwm.payment_time_year, dwm.payment_time_month, dwm.payment_time_day) >= '2037-02-01'
GROUP BY dwm.origin_type_stat,
         dwm.payment_time_year, dwm.payment_time_month, dwm.payment_time_day, dwm.payment_time_hour,
         dwm.origin_type;
--天、月、年省略


--咨询中心分组
--小时
INSERT INTO itcast_dws.customer_signup_dws PARTITION (payment_time_year, payment_time_month, payment_time_day)
SELECT count(dwm.customer_id) as signup_num,
       '-1'                      itcast_school_id,
       '-1'                      itcast_school_name,
       '-1'                      itcast_subject_id,
       '-1'                      itcast_subject_name,
       dwm.tdepart_id,
       dwm.tdepart_name,
       '-1'                      origin_type,
       dwm.origin_type_stat,
       dwm.payment_time_hour,
       '3'                       grouptype,
       '1'                    as time_type,
       dwm.payment_time_year,
       dwm.payment_time_month,
       dwm.payment_time_day
from itcast_dwm.customer_signup_dwm dwm
where CONCAT_WS('-', dwm.payment_time_year, dwm.payment_time_month, dwm.payment_time_day) >= '2037-02-01'
GROUP BY dwm.origin_type_stat,
         dwm.payment_time_year, dwm.payment_time_month, dwm.payment_time_day, dwm.payment_time_hour,
         dwm.tdepart_id, dwm.tdepart_name;
--天、月、年省略


--总数分组
--小时
INSERT INTO itcast_dws.customer_signup_dws PARTITION (payment_time_year, payment_time_month, payment_time_day)
SELECT count(dwm.customer_id) as signup_num,
       '-1'                      itcast_school_id,
       '-1'                      itcast_school_name,
       '-1'                      itcast_subject_id,
       '-1'                      itcast_subject_name,
       -1                     as tdepart_id,
       '-1'                      tdepart_name,
       '-1'                      origin_type,
       dwm.origin_type_stat,
       dwm.payment_time_hour,
       '4'                       grouptype,
       '1'                    as time_type,
       dwm.payment_time_year,
       dwm.payment_time_month,
       dwm.payment_time_day
from itcast_dwm.customer_signup_dwm dwm
where CONCAT_WS('-', dwm.payment_time_year, dwm.payment_time_month, dwm.payment_time_day) >= '2037-02-01'
GROUP BY dwm.origin_type_stat,
         dwm.payment_time_year, dwm.payment_time_month, dwm.payment_time_day, dwm.payment_time_hour;
--天、月、年省略……