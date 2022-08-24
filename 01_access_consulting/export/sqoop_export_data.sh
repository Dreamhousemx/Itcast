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

/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:mysql://192.168.88.80:3306/scrm_bi?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
  --username root \
  --password '123456' \
  --table itcast_visit \
  --hcatalog-database itcast_dws \
  --hcatalog-table visit_dws \
  -m 1
wait

/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:mysql://192.168.88.80:3306/scrm_bi?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
  --username root \
  --password 123456 \
  --table itcast_consult \
  --hcatalog-database itcast_dws \
  --hcatalog-table consult_dws \
  -m 1
wait

echo '========================================'
echo '=================success==============='
echo '========================================'
