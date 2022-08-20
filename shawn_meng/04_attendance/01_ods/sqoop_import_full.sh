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

#访问咨询附属表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://192.168.88.80:3306/teach?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query 'SELECT *, "2021-09-24" AS start_time FROM web_chat_text_ems_2019_07 where 1=1 and $CONDITIONS' \
--hcatalog-database itcast_ods \
--hcatalog-table web_chat_text_ems \
-m 1
wait

# 学生打卡记录表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://192.168.88.80:3306/teach?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query 'select *,"2021-10-07" as dt  from tbh_student_signin_record where 1=1 and $CONDITIONS' \
--hcatalog-database itcast_ods \
--hcatalog-table student_signin_ods \
-m 1
wait

# 学生请假信息表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://192.168.88.80:3306/teach?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query 'select *,"2021-10-07" as dt  from student_leave_apply where 1=1 and $CONDITIONS' \
--hcatalog-database itcast_ods \
--hcatalog-table student_leave_apply_ods \
-m 1
wait

echo '========================================'
echo '=================success==============='
echo '========================================'