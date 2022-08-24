#! /bin/bash
#SQOOP_HOME=/opt/cloudera/parcels/CDH-6.2.1-1.cdh6.2.1.p0.1425774/bin/sqoop
SQOOP_HOME=/usr/bin/sqoop
if [[ $1 == "" ]];then
   TD_DATE=`date -d '0 days ago' "+%Y-%m-%d"`
else
   TD_DATE=$1
fi
# ODS:
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://192.168.88.80:3306/education_online?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query "select * , '${TD_DATE}' as dt from tbh_student_signin_record where \$CONDITIONS" \
--fields-terminated-by '\t' \
--hcatalog-database ODS \
--hcatalog-table student_signin_ods \
-m 1
wait

# ODS:
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://192.168.88.80:3306/education_online?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query "select * , '${TD_DATE}' as dt from  student_leave_apply where \$CONDITIONS" \
--fields-terminated-by '\t' \
--hcatalog-database ODS \
--hcatalog-table student_leave_apply_ods \
-m 1
wait

#DIM:
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://192.168.88.80:3306/education_online?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query "select * , '${TD_DATE}' as dt from class_studying_student_count  where \$CONDITIONS" \
--fields-terminated-by '\t' \
--hcatalog-database DIM \
--hcatalog-table class_studying_student_count_dimen \
-m 1
wait

#DIM:
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://192.168.88.80:3306/education_online?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query "select * , '${TD_DATE}' as dt from course_table_upload_detail  where \$CONDITIONS" \
--fields-terminated-by '\t' \
--hcatalog-database DIM \
--hcatalog-table  course_table_upload_detail_dimen \
-m 1
wait

# DIM: 班级作息时间表
/usr/bin/sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
--connect 'jdbc:mysql://192.168.88.80:3306/education_online?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true' \
--username root \
--password 123456 \
--query "select * , '${TD_DATE}' as dt from tbh_class_time_table  where \$CONDITIONS" \
--fields-terminated-by '\t' \
--hcatalog-database DIM \
--hcatalog-table  class_time_dimen \
-m 1
wait