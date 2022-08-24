#! /bin/bash
/usr/bin/sqoop export \
--connect "jdbc:mysql://192.168.88.80:3306/out_sql?useUnicode=true&characterEncoding=utf-8" \
--username root \
--password 123456 \
--table class_attendance_dws \
--hcatalog-database dws \
--hcatalog-table class_attendance_dws \
-m 1