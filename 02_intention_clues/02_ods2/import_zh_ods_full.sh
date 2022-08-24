#! /bin/bash

date_time=`date -d '1 days ago' "+%Y-%m-%d"`
echo '========================================'
echo '==============开始全量导入==============='
echo '========================================'
#　访问咨询表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from web_chat_ems_2019_07 where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table nev_web_chat_ems_2019_07 \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================访问咨询表导入完毕,成功或者失败往上翻======================================'
# 访问咨询文本表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from web_chat_text_ems_2019_07 where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table nev_web_chat_text_ems_2019_07 \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================访问咨询文本表导入完毕,成功或者失败往上翻======================================'
#顾客表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from customer where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table scrm_customer \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================顾客表导入完毕,成功或者失败往上翻======================================'
#客户的吸引力表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from customer_appeal where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table scrm_customer_appeal \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================客户的吸引力表导入完毕,成功或者失败往上翻======================================'
# 客户线索表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from customer_clue where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table scrm_customer_clue \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================客户线索表导入完毕,成功或者失败往上翻======================================'

#客户关系表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from customer_relationship where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table scrm_customer_relationship \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================客户关系表导入完毕,成功或者失败往上翻======================================'
#员工信息表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from employee where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table scrm_employee \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================员工信息表导入完毕,成功或者失败往上翻======================================'
#传智播客的班级表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from itcast_clazz where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table scrm_itcast_class \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================传智播客的班级表导入完毕,成功或者失败往上翻======================================'
#传智播客的学区表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from itcast_school where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table scrm_itcast_school \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================传智播客的学区表导入完毕,成功或者失败往上翻======================================'
#传智播客的学科
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from itcast_subject where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table scrm_itcast_subject \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================传智播客的学科表导入完毕,成功或者失败往上翻======================================'
# 学科部门表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from department where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table scrm_department \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================学科部门表导入完毕,成功或者失败往上翻======================================'



#日历表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from calendar where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table scrm_calendar \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================日历表导入完毕,成功或者失败往上翻======================================'
#班级学习人数表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from class_studying_student_count where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table teach_class_studying_student_count \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================班级学习人数表导入完毕,成功或者失败往上翻======================================'
#课程表上传详情表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from course_table_upload_detail where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table teach_course_table_upload_detail \
--fields-terminated-by '\t' \
--m 1
wait
echo '=====================================课程表上传详情表导入完毕,成功或者失败往上翻======================================'

#学生离开申请表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from student_leave_apply where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table teach_student_leave_apply \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================学生离开申请表导入完毕,成功或者失败往上翻======================================'
#TBH班时间表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from tbh_class_time_table where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table teach_tbh_class_time_table \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================TBH班时间表导入完毕,成功或者失败往上翻======================================'
#TBH学生登记记录表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from tbh_student_signin_record where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table teach_tbh_student_signin_record \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================TBH学生登记记录表导入完毕,成功或者失败往上翻======================================'
#课程表上传详情表
sqoop import \
--connect jdbc:mysql://192.168.88.80:3306/zxjy \
--username root \
--password 123456 \
--query "select *, '${date_time}' as dt from course_table_upload_detail where 1=1 and \$CONDITIONS" \
--hcatalog-database zh_ods \
--hcatalog-table teach_course_table_upload_detail \
--fields-terminated-by '\t' \
--m 1
wait
echo '======================================课程表上传详情表导入完毕,成功或者失败往上翻======================================'
