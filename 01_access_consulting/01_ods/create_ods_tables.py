# # import pandas as pd
# from pyspark import SparkContext, SparkConf,SQLContext
# from pyspark.sql import SparkSession
# from pyspark.sql.types import *
# import pyspark.sql.functions as F
# import os
#
# # 锁定远端python版本:
# os.environ['SPARK_HOME'] = '/export/server/spark'
# os.environ['PYSPARK_PYTHON'] = '/root/anaconda3/bin/python3'
# os.environ['PYSPARK_DRIVER_PYTHON'] = '/root/anaconda3/bin/python3'
#
#
# def runSQL(spark):
#     spark.sql("show databases").show()
#     spark.sql("""
#             DROP DATABASE IF EXISTS `itcast_ods` CASCADE;
#             CREATE DATABASE IF NOT EXISTS `itcast_ods`;
#             SET hive.exec.orc.compression.strategy=COMPRESSION;
#
#             CREATE EXTERNAL TABLE IF NOT EXISTS itcast_ods.web_chat_ems
#             (
#                 id                           INT comment '主键',
#                 create_date_time             STRING comment '数据创建时间',
#                 session_id                   STRING comment '七陌sessionId',
#                 sid                          STRING comment '访客id',
#                 create_time                  STRING comment '会话创建时间',
#                 seo_source                   STRING comment '搜索来源',
#                 seo_keywords                 STRING comment '关键字',
#                 ip                           STRING comment 'IP地址',
#                 area                         STRING comment '地域',
#                 country                      STRING comment '所在国家',
#                 province                     STRING comment '省',
#                 city                         STRING comment '城市',
#                 origin_channel               STRING comment '投放渠道',
#                 user_match                   STRING comment '所属坐席',
#                 manual_time                  STRING comment '人工开始时间',
#                 begin_time                   STRING comment '坐席领取时间 ',
#                 end_time                     STRING comment '会话结束时间',
#                 last_customer_msg_time_stamp STRING comment '客户最后一条消息的时间',
#                 last_agent_msg_time_stamp    STRING comment '坐席最后一下回复的时间',
#                 reply_msg_count              INT comment '客服回复消息数',
#                 msg_count                    INT comment '客户发送消息数',
#                 browser_name                 STRING comment '浏览器名称',
#                 os_info                      STRING comment '系统名称'
#             )
#                 comment '访问会话信息表'
#                 PARTITIONED BY (starts_time STRING)
#                 ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
#                 stored as textfile
#                 location '/user/hive/warehouse/itcast_ods.db/web_chat_ems_ods'
#                 TBLPROPERTIES ('orc.compress' = 'ZLIB');
#
#             CREATE EXTERNAL TABLE IF NOT EXISTS itcast_ods.web_chat_text_ems
#             (
#                 id                   INT COMMENT '主键来自MySQL',
#                 referrer             STRING comment '上级来源页面',
#                 from_url             STRING comment '会话来源页面',
#                 landing_page_url     STRING comment '访客着陆页面',
#                 url_title            STRING comment '咨询页面title',
#                 platform_description STRING comment '客户平台信息',
#                 other_params         STRING comment '扩展字段中数据',
#                 history              STRING comment '历史访问记录'
#             ) comment 'EMS-PV测试表'
#                 PARTITIONED BY (start_time STRING)
#                 ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
#                 stored as textfile
#                 location '/user/hive/warehouse/itcast_ods.db/web_chat_text_ems_ods'
#                 TBLPROPERTIES ('orc.compress' = 'ZLIB');
#        """).show()
#
#     # with open("create_ods_tables.sql") as file:
#     #     queries = file.read()
#     #     print(queries)
#     #     spark.sql(query).show()
#     # spark.sql("""CREATE DATABASE IF NOT EXISTS `itcast_ods`""").show()
#
#
# if __name__ == '__main__':
#     print("spark on hive的集成")
#     # 1- 创建SparkSession对象
#     spark = SparkSession \
#         .builder \
#         .master('local[*]') \
#         .appName('itcast') \
#         .config('spark.sql.shuffle.partitions', '4') \
#         .config("spark.sql.warehouse.dir", 'hdfs://node1:8020/user/hive/warehouse') \
#         .config("hive.metastore.uris", "thrift://node1:9083") \
#         .enableHiveSupport() \
#         .getOrCreate()
#
#     # 2- 构建数据集
#     # runSQL(spark)
#
#     sc = SparkContext("spark://train01:7077", "LDASample")
#     sqlContext = SQLContext(sc)
#     dataframe_mysql = sqlContext.read.format("jdbc") \
#         .options(url="jdbc:mysql://127.0.0.1:3306/spark_db",
#                  driver="com.mysql.jdbc.Driver", dbtable="spark_table",
#                  user="root", password="root").load()
#     dataframe_mysql.show()
#
#     # spark.sql.warehouse.dir : 指定 默认加载数据的路径地址,  在spark中, 如果不设置, 默认为本地路径
#     # hive.metastore.uris : 指定 metastore的服务地址
#     # enableHiveSupport() : 开启 和 hive的集成
