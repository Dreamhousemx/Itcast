# import pandas as pd
from pyspark import SparkContext, SparkConf, SQLContext
from pyspark.sql import SparkSession
from pyspark.sql.types import *
import pyspark.sql.functions as F
import os

# 锁定远端python版本:
os.environ['SPARK_HOME'] = '/export/server/spark'
os.environ['PYSPARK_PYTHON'] = '/root/anaconda3/bin/python3'
os.environ['PYSPARK_DRIVER_PYTHON'] = '/root/anaconda3/bin/python3'

if __name__ == '__main__':
    # 创建一个连接
    spark = SparkSession \
        .builder \
        .master('local[*]') \
        .appName('itcast') \
        .config('spark.sql.shuffle.partitions', '4') \
        .config("spark.sql.warehouse.dir", 'hdfs://node1:8020/user/hive/warehouse') \
        .config("hive.metastore.uris", "thrift://node1:9083") \
        .enableHiveSupport() \
        .getOrCreate()
    spark.sql("set hive.exec.dynamic.partition.mode=nonstrict")
    spark.sql("""insert into table itcast_dwd.visit_consult_dwd partition (year_info, month_info, day_info)
                 select wce.session_id,
                        wce.sid,
                        unix_timestamp(wce.create_time, 'yyyy-MM-dd HH:mm:ss.SSS') as create_time,
                        wce.seo_source,
                        wce.ip,
                        wce.area,
                        cast(if(wce.msg_count is null, 0, wce.msg_count) as int)   as msg_count,
                        wce.origin_channel,
                        wcte.referrer,
                        wcte.from_url,
                        wcte.landing_page_url,
                        wcte.url_title,
                        wcte.platform_description,
                        wcte.other_params,
                        wcte.history,
                        substr(wce.create_time, 12, 2)                             as hour_info,
                        quarter(wce.create_time)                                   as quarter_info,
                        substr(wce.create_time, 1, 4)                              as year_info,
                        substr(wce.create_time, 6, 2)                              as month_info,
                        substr(wce.create_time, 9, 2)                              as day_info
                 from itcast_ods.web_chat_ems wce
                          inner join itcast_ods.web_chat_text_ems wcte on wce.id = wcte.id""")
    # 关闭spark会话
    spark.stop()
