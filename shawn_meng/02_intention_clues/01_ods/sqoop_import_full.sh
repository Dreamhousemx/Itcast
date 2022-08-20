#! /bin/bash
#SQOOP_HOME=/opt/cloudera/parcels/CDH-6.2.1-1.cdh6.2.1.p0.1425774/bin/sqoop
SQOOP_HOME=/usr/bin/sqoop
if [[ $1 == "" ]];then
   TD_DATE=`date -d '1 days ago' "+%Y-%m-%d"`
else
   TD_DATE=$1
fi

echo '========================================'
echo '==============开始全量导入==============='
echo '========================================'

# 访问咨询主表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://192.168.88.80:3306/nev?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query 'SELECT id,create_date_time,session_id,sid,create_time,seo_source,seo_keywords,ip,
AREA,country,province,city,origin_channel,USER AS user_match,manual_time,begin_time,end_time,
last_customer_msg_time_stamp,last_agent_msg_time_stamp,reply_msg_count,
msg_count,browser_name,os_info, "2021-09-24" AS starts_time
FROM web_chat_ems_2019_07 where 1=1 and $CONDITIONS' \
--hcatalog-database itcast_ods \
--hcatalog-table web_chat_ems \
-m 1
wait

#访问咨询附属表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://192.168.88.80:3306/nev?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query 'SELECT *, "2021-09-24" AS start_time FROM web_chat_text_ems_2019_07 where 1=1 and $CONDITIONS' \
--hcatalog-database itcast_ods \
--hcatalog-table web_chat_text_ems \
-m 1
wait

echo '========================================'
echo '=================success==============='
echo '========================================'