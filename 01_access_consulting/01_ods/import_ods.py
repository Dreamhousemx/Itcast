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


def import_web_chat_ems():
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
    df1 = spark.read.format("jdbc").options(url="jdbc:mysql://192.168.88.161:3306/nev",
                                            driver="com.mysql.jdbc.Driver",
                                            dbtable="(select * From web_chat_ems_2019_07) tmp",
                                            user="root",
                                            password="123456").load()

    df1.registerTempTable('web_chat_ems_2019_07_tmp')
    spark.sql("use itcast_ods")
    df2 = spark.sql("select * from web_chat_ems_2019_07_tmp")

    df2.registerTempTable('web_chat_ems_tmp')
    df2.repartition(100000)
    spark.sql("set hive.exec.dynamic.partition.mode=nonstrict")
    spark.sql("insert into web_chat_ems select *,CURRENT_DATE from web_chat_ems_tmp")
    # 关闭spark会话
    spark.stop()


def import_web_chat_text_ems():
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
    df1 = spark.read.format("jdbc").options(url="jdbc:mysql://192.168.88.161:3306/nev",
                                            driver="com.mysql.jdbc.Driver",
                                            dbtable="(select * From web_chat_text_ems_2019_07) tmp",
                                            user="root",
                                            password="123456").load()

    df1.registerTempTable('web_chat_text_ems_2019_07_tmp')
    spark.sql("use itcast_ods")
    df2 = spark.sql("select * from web_chat_text_ems_2019_07_tmp")

    df2.registerTempTable('web_chat_text_ems_tmp')
    df2.repartition(100000)
    spark.sql("set hive.exec.dynamic.partition.mode=nonstrict")
    spark.sql("insert into web_chat_text_ems select *,CURRENT_DATE from web_chat_text_ems_tmp")
    # 关闭spark会话
    spark.stop()


if __name__ == '__main__':
    import_web_chat_ems()
    import_web_chat_text_ems()
