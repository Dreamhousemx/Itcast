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


# 区域
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
    # 小时维度
    spark.sql("""insert into itcast_dws.visit_dws partition (year_info, month_info, day_info)
                 select count(distinct sid)                                           as sid_total,
                        count(distinct session_id)                                    as session_total,
                        count(distinct ip)                                            as ip_total,
                        area,
                        '-1'                                                          as seo_source,
                        '-1'                                                          as origin_channel,
                        hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info, '-', day_info, ' ', hour_info) as time_detail,
                        '-1'                                                          as from_url,
                        '1'                                                           as cic_type,
                        '1'                                                           as time_type,
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 group by area, year_info, quarter_info, month_info, day_info, hour_info
                 union all
                 select count(distinct sid)                            as sid_total,
                        count(distinct session_id)                     as session_total,
                        count(distinct ip)                             as ip_total,
                        area,
                        '-1'                                           as seo_source,
                        '-1'                                           as origin_channel,
                        '-1'                                           as hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info, '-', day_info) as time_detail,
                        '-1'                                           as from_url,
                        '1'                                            as cic_type,
                        '2'                                            as time_type,
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 group by area, year_info, quarter_info, month_info, day_info
                 union all
                 select count(distinct sid)              as sid_total,
                        count(distinct session_id)       as session_total,
                        count(distinct ip)               as ip_total,
                        area,
                        '-1'                             as seo_source,
                        '-1'                             as origin_channel,
                        '-1'                             as hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info) as time_detail,
                        '-1'                             as from_url,
                        '1'                              as cic_type,
                        '3'                              as time_type,
                        year_info,
                        month_info,
                        '-1'                             as day_info
                 from itcast_dwd.visit_consult_dwd
                 group by area, year_info, quarter_info, month_info
                 union all
                 select count(distinct sid)                 as sid_total,
                        count(distinct session_id)          as session_total,
                        count(distinct ip)                  as ip_total,
                        area,
                        '-1'                                as seo_source,
                        '-1'                                as origin_channel,
                        '-1'                                as hour_info,
                        quarter_info,
                        concat(year_info, '-Q', quarter_info) as time_detail,
                        '-1'                                as from_url,
                        '1'                                 as cic_type,
                        '4'                                 as time_type,
                        year_info,
                        '-1'                                as month_info,
                        '-1'                                as day_info
                 from itcast_dwd.visit_consult_dwd
                 group by area, year_info, quarter_info
                 union all
                     select COUNT(distinct wce.sid)        as sid_total,
                        COUNT(distinct wce.session_id) as sessionid_total,
                        COUNT(distinct wce.ip)         as ip_total,
                        wce.area                       as area,
                        '-1'                           as seo_source,
                        '-1'                           as origin_channel,
                        '-1'                           as hour_info,
                        '-1'                           as quarter_info,
                        wce.year_info                   as time_detail,
                        '-1'                           as from_url,
                        '1'                            as cic_type,
                        '5'                            as time_type,
                        wce.year_info                   as year_info,
                        '-1'                           as month_info,
                        '-1'                           as day_info
                 from itcast_dwd.visit_consult_dwd wce
                 group by wce.area, wce.year_info""")
    # 关闭spark会话
    spark.stop()


# 搜索来源分组
def import_search_source():
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
    # 小时维度
    spark.sql("""insert into itcast_dws.visit_dws partition (year_info, month_info, day_info)
                 select count(distinct sid)                                           as sid_total,
                        count(distinct session_id)                                    as session_total,
                        count(distinct ip)                                            as ip_total,
                        '-1'                                                          as area,
                        seo_source,
                        '-1'                                                          as origin_channel,
                        hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info, '-', day_info, ' ', hour_info) as time_detail,
                        '-1'                                                          as from_url,
                        '2'                                                           as cic_type,
                        '1'                                                           as time_type,
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 group by seo_source, year_info, quarter_info, month_info, day_info, hour_info
                 union all
                 select count(distinct sid)                            as sid_total,
                        count(distinct session_id)                     as session_total,
                        count(distinct ip)                             as ip_total,
                        '-1'                                           as area,
                        seo_source,
                        '-1'                                           as origin_channel,
                        '-1'                                           as hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info, '-', day_info) as time_detail,
                        '-1'                                           as from_url,
                        '2'                                            as cic_type,
                        '2'                                            as time_type,
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 group by seo_source, year_info, quarter_info, month_info, day_info
                 union all
                 select count(distinct sid)              as sid_total,
                        count(distinct session_id)       as session_total,
                        count(distinct ip)               as ip_total,
                        '-1'                             as area,
                        seo_source,
                        '-1'                             as origin_channel,
                        '-1'                             as hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info) as time_detail,
                        '-1'                             as from_url,
                        '2'                              as cic_type,
                        '3'                              as time_type,
                        year_info,
                        month_info,
                        '-1'                             as day_info
                 from itcast_dwd.visit_consult_dwd
                 group by seo_source, year_info, quarter_info, month_info
                 union all
                 select count(distinct sid)                 as sid_total,
                        count(distinct session_id)          as session_total,
                        count(distinct ip)                  as ip_total,
                        '-1'                                as area,
                        seo_source,
                        '-1'                                as origin_channel,
                        '-1'                                as hour_info,
                        quarter_info,
                        concat(year_info, '-Q', quarter_info) as time_detail,
                        '-1'                                as from_url,
                        '2'                                 as cic_type,
                        '4'                                 as time_type,
                        year_info,
                        '-1'                                as month_info,
                        '-1'                                as day_info
                 from itcast_dwd.visit_consult_dwd
                 group by seo_source, year_info, quarter_info
                 union all
                 select COUNT(distinct wce.sid)        as sid_total,
                        COUNT(distinct wce.session_id) as sessionid_total,
                        COUNT(distinct wce.ip)         as ip_total,
                        '-1'                           as area,
                        seo_source,
                        '-1'                           as origin_channel,
                        '-1'                           as hour_info,
                        '-1'                           as quarter_info,
                        wce.year_info                   as time_detail,
                        '-1'                           as from_url,
                        '2'                            as cic_type,
                        '5'                            as time_type,
                        wce.year_info                   as year_info,
                        '-1'                           as month_info,
                        '-1'                           as day_info
                 from itcast_dwd.visit_consult_dwd wce
                 group by wce.seo_source, wce.year_info""")
    # 关闭spark会话
    spark.stop()


# 会话来源页面分组
def import_session_source():
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
    # 小时维度
    spark.sql("""insert into itcast_dws.visit_dws partition (year_info, month_info, day_info)
                 select count(distinct sid)                                           as sid_total,
                        count(distinct session_id)                                    as session_total,
                        count(distinct ip)                                            as ip_total,
                        '-1'                                                          as area,
                        '-1'                                                          as seo_source,
                        '-1'                                                          as origin_channel,
                        hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info, '-', day_info, ' ', hour_info) as time_detail,
                        from_url,
                        '4'                                                           as cic_type,
                        '1'                                                           as time_type,
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 group by from_url, year_info, quarter_info, month_info, day_info, hour_info
                 union all
                 select count(distinct sid)                            as sid_total,
                        count(distinct session_id)                     as session_total,
                        count(distinct ip)                             as ip_total,
                        '-1'                                           as area,
                        '-1'                                           as seo_source,
                        '-1'                                           as origin_channel,
                        '-1'                                           as hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info, '-', day_info) as time_detail,
                        from_url,
                        '4'                                            as cic_type,
                        '2'                                            as time_type,
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 group by from_url, year_info, quarter_info, month_info, day_info
                 union all
                 select count(distinct sid)              as sid_total,
                        count(distinct session_id)       as session_total,
                        count(distinct ip)               as ip_total,
                        '-1'                             as area,
                        '-1'                             as seo_source,
                        '-1'                             as origin_channel,
                        '-1'                             as hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info) as time_detail,
                        from_url,
                        '4'                              as cic_type,
                        '3'                              as time_type,
                        year_info,
                        month_info,
                        '-1'                             as day_info
                 from itcast_dwd.visit_consult_dwd
                 group by from_url, year_info, quarter_info, month_info
                 union all
                 select count(distinct sid)                 as sid_total,
                        count(distinct session_id)          as session_total,
                        count(distinct ip)                  as ip_total,
                        '-1'                                as area,
                        '-1'                                as seo_source,
                        '-1'                                as origin_channel,
                        '-1'                                as hour_info,
                        quarter_info,
                        concat(year_info, '-Q', quarter_info) as time_detail,
                        from_url,
                        '4'                                 as cic_type,
                        '4'                                 as time_type,
                        year_info,
                        '-1'                                as month_info,
                        '-1'                                as day_info
                 from itcast_dwd.visit_consult_dwd
                 group by from_url, year_info, quarter_info
                 union all
                 select COUNT(distinct wce.sid)        as sid_total,
                        COUNT(distinct wce.session_id) as sessionid_total,
                        COUNT(distinct wce.ip)         as ip_total,
                        '-1'                           as area,
                        '-1'                           as seo_source,
                        '-1'                           as origin_channel,
                        '-1'                           as hour_info,
                        '-1'                           as quarter_info,
                        wce.year_info                   as time_detail,
                        from_url,
                        '4'                            as cic_type,
                        '5'                            as time_type,
                        wce.year_info                   as year_info,
                        '-1'                           as month_info,
                        '-1'                           as day_info
                 from itcast_dwd.visit_consult_dwd wce
                 group by wce.from_url, wce.year_info""")
    # 关闭spark会话
    spark.stop()


# 来源渠道分组
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
    # 小时维度
    spark.sql("""insert into itcast_dws.visit_dws partition (year_info, month_info, day_info)
                 select count(distinct sid)                                           as sid_total,
                        count(distinct session_id)                                    as session_total,
                        count(distinct ip)                                            as ip_total,
                        '-1'                                                          as area,
                        '-1'                                                          as seo_source,
                        origin_channel,
                        hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info, '-', day_info, ' ', hour_info) as time_detail,
                        '-1'                                                          as from_url,
                        '3'                                                           as cic_type,
                        '1'                                                           as time_type,
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 group by origin_channel, year_info, quarter_info, month_info, day_info, hour_info
                 union all
                 select count(distinct sid)                            as sid_total,
                        count(distinct session_id)                     as session_total,
                        count(distinct ip)                             as ip_total,
                        '-1'                                           as area,
                        '-1'                                           as seo_source,
                        origin_channel,
                        '-1'                                           as hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info, '-', day_info) as time_detail,
                        '-1'                                           as from_url,
                        '3'                                            as cic_type,
                        '2'                                            as time_type,
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 group by origin_channel, year_info, quarter_info, month_info, day_info
                 union all
                 select count(distinct sid)              as sid_total,
                        count(distinct session_id)       as session_total,
                        count(distinct ip)               as ip_total,
                        '-1'                             as area,
                        '-1'                             as seo_source,
                        origin_channel,
                        '-1'                             as hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info) as time_detail,
                        '-1'                             as from_url,
                        '3'                              as cic_type,
                        '3'                              as time_type,
                        year_info,
                        month_info,
                        '-1'                             as day_info
                 from itcast_dwd.visit_consult_dwd
                 group by origin_channel, year_info, quarter_info, month_info
                 union all
                 select count(distinct sid)                 as sid_total,
                        count(distinct session_id)          as session_total,
                        count(distinct ip)                  as ip_total,
                        '-1'                                as area,
                        '-1'                                as seo_source,
                        origin_channel,
                        '-1'                                as hour_info,
                        quarter_info,
                        concat(year_info, '-Q', quarter_info) as time_detail,
                        '-1'                                as from_url,
                        '3'                                 as cic_type,
                        '4'                                 as time_type,
                        year_info,
                        '-1'                                as month_info,
                        '-1'                                as day_info
                 from itcast_dwd.visit_consult_dwd
                 group by origin_channel, year_info, quarter_info
                 union all
                 select COUNT(distinct wce.sid)        as sid_total,
                        COUNT(distinct wce.session_id) as sessionid_total,
                        COUNT(distinct wce.ip)         as ip_total,
                        '-1'                           as area,
                        '-1'                           as seo_source,
                        origin_channel,
                        '-1'                           as hour_info,
                        '-1'                           as quarter_info,
                        wce.year_info                   as time_detail,
                        '-1'                           as from_url,
                        '3'                            as cic_type,
                        '5'                            as time_type,
                        wce.year_info                   as year_info,
                        '-1'                           as month_info,
                        '-1'                           as day_info
                 from itcast_dwd.visit_consult_dwd wce
                 group by wce.origin_channel, wce.year_info""")
    # 关闭spark会话
    spark.stop()


# 总访问量
def import_total_visit():
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
    # 小时维度
    spark.sql("""insert into itcast_dws.visit_dws partition (year_info, month_info, day_info)
                 select count(distinct sid)                                           as sid_total,
                        count(distinct session_id)                                    as session_total,
                        count(distinct ip)                                            as ip_total,
                        '-1'                                                          as area,
                        '-1'                                                          as seo_source,
                        '-1'                                                          as origin_channel,
                        hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info, '-', day_info, ' ', hour_info) as time_detail,
                        '-1'                                                          as from_url,
                        '5'                                                           as cic_type,
                        '1'                                                           as time_type,
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 group by year_info, quarter_info, month_info, day_info, hour_info
                 union all
                 select count(distinct sid)                            as sid_total,
                        count(distinct session_id)                     as session_total,
                        count(distinct ip)                             as ip_total,
                        '-1'                                           as area,
                        '-1'                                           as seo_source,
                        '-1'                                           as origin_channel,
                        '-1'                                           as hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info, '-', day_info) as time_detail,
                        '-1'                                           as from_url,
                        '5'                                            as cic_type,
                        '2'                                            as time_type,
                        year_info,
                        month_info,
                        day_info
                 from itcast_dwd.visit_consult_dwd
                 group by year_info, quarter_info, month_info, day_info
                 union all
                 select count(distinct sid)              as sid_total,
                        count(distinct session_id)       as session_total,
                        count(distinct ip)               as ip_total,
                        '-1'                             as area,
                        '-1'                             as seo_source,
                        '-1'                             as origin_channel,
                        '-1'                             as hour_info,
                        quarter_info,
                        concat(year_info, '-', month_info) as time_detail,
                        '-1'                             as from_url,
                        '5'                              as cic_type,
                        '3'                              as time_type,
                        year_info,
                        month_info,
                        '-1'                             as day_info
                 from itcast_dwd.visit_consult_dwd
                 group by year_info, quarter_info, month_info
                 union all
                 select count(distinct sid)                 as sid_total,
                        count(distinct session_id)          as session_total,
                        count(distinct ip)                  as ip_total,
                        '-1'                                as area,
                        '-1'                                as seo_source,
                        '-1'                                as origin_channel,
                        '-1'                                as hour_info,
                        quarter_info,
                        concat(year_info, '-Q', quarter_info) as time_detail,
                        '-1'                                as from_url,
                        '5'                                 as cic_type,
                        '4'                                 as time_type,
                        year_info,
                        '-1'                                as month_info,
                        '-1'                                as day_info
                 from itcast_dwd.visit_consult_dwd
                 group by year_info, quarter_info
                 union all
                 select COUNT(distinct wce.sid)        as sid_total,
                        COUNT(distinct wce.session_id) as sessionid_total,
                        COUNT(distinct wce.ip)         as ip_total,
                        '-1'                           as area,
                        '-1'                           as seo_source,
                        '-1'                           as origin_channel,
                        '-1'                           as hour_info,
                        '-1'                           as quarter_info,
                        wce.year_info                   as time_detail,
                        '-1'                           as from_url,
                        '5'                            as cic_type,
                        '5'                            as time_type,
                        wce.year_info                   as year_info,
                        '-1'                           as month_info,
                        '-1'                           as day_info
                 from itcast_dwd.visit_consult_dwd wce
                 group by wce.year_info""")
    # 关闭spark会话
    spark.stop()


if __name__ == '__main__':
    import_region()
    import_search_source()
    import_session_source()
    import_source_channel()
    import_total_visit()
