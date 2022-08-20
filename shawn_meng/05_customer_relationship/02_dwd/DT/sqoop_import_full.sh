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

# 客户表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:mysql://192.168.88.80:3306/scrm?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
  --username root \
  --password 123456 \
  --query 'SELECT *, "2021-09-27" AS start_time FROM customer where 1=1 and $CONDITIONS' \
  --hcatalog-database itcast_dimen \
  --hcatalog-table customer \
  -m 1
wait

# 学科表:
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:mysql://192.168.88.80:3306/scrm?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
  --username root \
  --password 123456 \
  --query 'SELECT *, "2021-09-27" AS start_time FROM itcast_subject where 1=1 and $CONDITIONS' \
  --hcatalog-database itcast_dimen \
  --hcatalog-table itcast_subject \
  -m 1
wait

# 校区表:
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:mysql://192.168.88.80:3306/scrm?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
  --username root \
  --password 123456 \
  --query 'SELECT *, "2021-09-27" AS start_time FROM itcast_school where 1=1 and $CONDITIONS' \
  --hcatalog-database itcast_dimen \
  --hcatalog-table itcast_school \
  -m 1
wait

# 员工表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:mysql://192.168.88.80:3306/scrm?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
  --username root \
  --password 123456 \
  --query 'SELECT *, "2021-09-27" AS start_time FROM employee where 1=1 and $CONDITIONS' \
  --hcatalog-database itcast_dimen \
  --hcatalog-table employee \
  -m 1
wait

# 部门表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:mysql://192.168.88.80:3306/scrm?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
  --username root \
  --password 123456 \
  --query 'SELECT *, "2021-09-27" AS start_time FROM scrm_department where 1=1 and $CONDITIONS' \
  --hcatalog-database itcast_dimen \
  --hcatalog-table scrm_department \
  -m 1
wait

echo '========================================'
echo '=================success==============='
echo '========================================'
