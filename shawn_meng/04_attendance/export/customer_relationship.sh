sqoop export \
  --connect "jdbc:mysql://192.168.52.150:3306/scrm_bi?useUnicode=true&characterEncoding=utf-8" \
  --username root \
  --password 123456 \
  --table customer_signup_app \
  --hcatalog-database itcast_dws \
  --hcatalog-table customer_signup_dws \
  -m 100
#sqoop export \
#  --connect "jdbc:mysql://172.17.0.202:3306/scrm_bi?useUnicode=true&characterEncoding=utf-8" \
#  --username root \
#  --password 123456 \
#  --table customer_signup_app \
#  --hcatalog-database itcast_dws \
#  --hcatalog-table customer_signup_dws \
