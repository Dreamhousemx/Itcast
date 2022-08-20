#! /bin/bash
#SQOOP_HOME=/opt/cloudera/parcels/CDH-6.2.1-1.cdh6.2.1.p0.1425774/bin/sqoop
SQOOP_HOME=/usr/bin/sqoop
if [[ $1 == "" ]]; then
  TD_DATE=$(date -d '1 days ago' "+%Y-%m-%d")
else
  TD_DATE=$1
fi

echo '========================================'
echo '==============开始全量导入==============='
echo '========================================'

# 当日在读人数表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:mysql://192.168.88.80:3306/teach?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
  --username root \
  --password 123456 \
  --query 'select *,"2021-10-07" as dt  from class_studying_student_count where 1=1 and $CONDITIONS' \
  --hcatalog-database itcast_dimen \
  --hcatalog-table class_studying_student_count_dimen \
  -m 1

# 日期课程表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:mysql://192.168.88.80:3306/teach?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
  --username root \
  --password 123456 \
  --query 'select *,"2021-10-07" as dt  from course_table_upload_detail where 1=1 and $CONDITIONS' \
  --hcatalog-database itcast_dimen \
  --hcatalog-table course_table_upload_detail_dimen \
  -m 1

# 作息时间表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:mysql://192.168.88.80:3306/teach?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
  --username root \
  --password 123456 \
  --query 'select *,"2021-10-07" as dt  from tbh_class_time_table where 1=1 and $CONDITIONS' \
  --hcatalog-database itcast_dimen \
  --hcatalog-table class_time_dimen \
  -m 1

echo '========================================'
echo '=================success==============='
echo '========================================'
