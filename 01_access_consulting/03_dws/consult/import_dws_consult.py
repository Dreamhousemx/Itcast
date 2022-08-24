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


def import_region():
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
    # 天维度
    spark.sql("""insert into itcast_dws.consult_dws partition (year_info, month_info, day_info)
                 select count(distinct sid),
                        count(distinct session_id),
                        count(distinct ip),
                        area,
                        '-1' as origin_channel,
                        '-1' as hour_info,
                        quarter_info,
                        concat_ws('-', year_info, month_info, day_info),
                        '1',
                        '2',
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 where msg_count >= 1
                 group by area, year_info, quarter_info, month_info, day_info
                 union all
                 select count(distinct sid),
                        count(distinct session_id),
                        count(distinct ip),
                        area,
                        '-1' as origin_channel,
                        '-1' as hour_info,
                        quarter_info,
                        concat_ws('-', year_info, month_info),
                        '1',
                        '3',
                        year_info,
                        month_info,
                        '-1' as day_info
                 from itcast_dwd.visit_consult_dwd
                 where msg_count >= 1
                 group by area, year_info, quarter_info, month_info
                 union all
                 select count(distinct sid),
                        count(distinct session_id),
                        count(distinct ip),
                        area,
                        '-1' as origin_channel,
                        '-1' as hour_info,
                        quarter_info,
                        concat_ws('-Q', year_info, quarter_info),
                        '1',
                        '4',
                        year_info,
                        '-1' as month_info,
                        '-1' as day_info
                 from itcast_dwd.visit_consult_dwd
                 where msg_count >= 1
                 group by area, year_info, quarter_info
                 union all
                 select count(distinct sid),
                        count(distinct session_id),
                        count(distinct ip),
                        area,
                        '-1' as origin_channel,
                        '-1' as hour_info,
                        '-1' as quarter_info,
                        year_info,
                        '1',
                        '5',
                        year_info,
                        '-1' as month_info,
                        '-1' as day_info
                 from itcast_dwd.visit_consult_dwd
                 where msg_count >= 1
                 group by area, year_info""")
    # 关闭spark会话
    spark.stop()


def import_source_channel():
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
    # 天维度
    spark.sql("""insert into itcast_dws.consult_dws partition (year_info, month_info, day_info)
                 select count(distinct sid),
                        count(distinct session_id),
                        count(distinct ip),
                        '-1' as area,
                        origin_channel,
                        '-1' as hour_info,
                        quarter_info,
                        concat_ws('-', year_info, month_info, day_info),
                        '2',
                        '2',
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 where msg_count >= 1
                 group by origin_channel, year_info, quarter_info, month_info, day_info
                 union all
                 select count(distinct sid),
                        count(distinct session_id),
                        count(distinct ip),
                        '-1' as area,
                        origin_channel,
                        '-1' as hour_info,
                        quarter_info,
                        concat_ws('-', year_info, month_info),
                        '2',
                        '3',
                        year_info,
                        month_info,
                        '-1' as day_info
                 from itcast_dwd.visit_consult_dwd
                 where msg_count >= 1
                 group by origin_channel, year_info, quarter_info, month_info
                 union all
                 select count(distinct sid),
                        count(distinct session_id),
                        count(distinct ip),
                        '-1' as area,
                        origin_channel,
                        '-1' as hour_info,
                        quarter_info,
                        concat_ws('-Q', year_info, quarter_info),
                        '2',
                        '4',
                        year_info,
                        '-1' as month_info,
                        '-1' as day_info
                 from itcast_dwd.visit_consult_dwd
                 where msg_count >= 1
                 group by origin_channel, year_info, quarter_info
                 union all
                 select count(distinct sid),
                        count(distinct session_id),
                        count(distinct ip),
                        '-1' as area,
                        origin_channel,
                        '-1' as hour_info,
                        '-1' as quarter_info,
                        year_info,
                        '2',
                        '5',
                        year_info,
                        '-1' as month_info,
                        '-1' as day_info
                 from itcast_dwd.visit_consult_dwd
                 where msg_count >= 1
                 group by origin_channel, year_info""")
    # 关闭spark会话
    spark.stop()


if __name__ == '__main__':
    import_region()
    import_source_channel()
