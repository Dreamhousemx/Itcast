知行教育项目需求文档
1. 访问咨询主题看板
客户访问和咨询主题，顾名思义，分析的数据主要是客户的访问数据和咨询数据。但是经过需求调研，这里的访问数据，实际指的是访问的客户量，而不是客户访问量。原始数据来源于咨询系统的mysql业务数据库。
用户关注的核心指标有：1、总访问客户量、2、地区独立访客热力图、3、访客咨询率趋势、4、客户访问量和访客咨询率双轴趋势、5、时间段访问客户量趋势、6、来源渠道访问量占比、7、搜索来源访问量占比、8、活跃页面排行榜。

1.1 总访问客户量
说明：统计指定时间段内，访问客户的总数量。能够下钻到小时数据。
展现：线状图
粒度：天
条件：年、季度、月
数据来源：咨询系统的web_chat_ems_2019_12等月表


按年：显示指定年范围内每天的访问客户量
按季度：显示指定季度范围内每天的访问客户量
按月：显示指定月份范围内每天的访问客户量
注意: 除按照sid进行统计后, 还需同时按照 ip和sessionid进行去重统计
SQL：
1.SELECT  
2.    count( DISTINCT ( wce.sid ) )  '总数',  count( DISTINCT ( wce.ip) )  '总数', count( DISTINCT ( wce.session_id) )  '总数',DATE_FORMAT( wce.create_time, '%Y-%m-%d' ) '时间'  
3.FROM  
4.    web_chat_ems_2019_12 wce   
5.GROUP BY  
6.    DATE_FORMAT( wce.create_time, '%Y-%m-%d' )  
7.ORDER BY  
8.    DATE_FORMAT( wce.create_time, '%Y-%m-%d' ) ASC  

1.2 地区独立访客热力图
说明：统计指定时间段内，访问客户中各区域人数热力图。能够下钻到小时数据。
展现：地图热力图
粒度：天
条件：年、季度、月
数据来源：咨询系统的web_chat_ems_2019_12等月表

按年：显示指定年范围内每天的客户访问量
按季度：显示指定季度范围内每天的客户访问量
按月：显示指定月份范围内每天的客户访问量
注意: 除按照sid进行统计后, 还需同时按照 ip和sessionid进行去重统计

SQL：
1.SELECT  
2.    wce.area '区域',  
3.    count(DISTINCT(wce.sid)) '总数',  count( DISTINCT ( wce.ip) )  '总数', count( DISTINCT ( wce.session_id) )  '总数',
4.    wce.country '国家',  
5.    wce.province '省份',  
6.    wce.city '城市',  
7.    DATE_FORMAT(wce.create_time,'%Y-%m-%d') '时间'  
8.FROM  
9.    web_chat_ems_2019_12 wce  
10.GROUP BY  
11.    DATE_FORMAT(wce.create_time,'%Y-%m-%d'),  
12.    wce.area  
13.ORDER BY   
14.    DATE_FORMAT(wce.create_time,'%Y-%m-%d') ASC, count(DISTINCT(wce.sid)) DESC;  

1.3 访客咨询率趋势
说明：统计指定时间段内，不同地区（省、市）访问的客户中发起咨询的人数占比；
咨询率 = 咨询客户量 / 访问客户量；客户与网咨有说一句话的称为有效咨询。
展现：线状图
粒度：天
条件：年、季度、月、省、市
数据来源：咨询系统的web_chat_ems_2019_12等月表

按年：显示指定年范围内每天的客户访问量
按季度：显示指定季度范围内每天的客户访问量
按月：显示指定月份范围内每天的客户访问量
注意: 除按照sid进行统计后, 还需同时按照 ip和sessionid进行去重统计

SQL:
1.SELECT  
2.    CONCAT(msgNumber.num / totalNumber.num * 100, '%')  
3.FROM  
4.    (  
5.    SELECT  
6.        count( DISTINCT ( sid ) ) num   
7.    FROM  
8.        web_chat_ems_2019_12   
9.    WHERE  
10.        msg_count >= 1   
11.    ) msgNumber,  
12.    (  
13.    SELECT  
14.        count( DISTINCT ( sid ) ) num   
15.    FROM  
16.    web_chat_ems_2019_12   
17.    ) totalNumber  


1.4 访问客户量和访客咨询率双轴趋势
说明：统计指定时间段内，每日客户访问量/咨询率双轴趋势图。能够下钻到小时数据。
每日客户访问量可以复用指标2数据；
咨询率可以复用指标3的数据。

按年：显示指定年范围内每天的客户访问量
按季度：显示指定季度范围内每天的客户访问量
按月：显示指定月份范围内每天的客户访问量
注意: 除按照sid进行统计后, 还需同时按照 ip和sessionid进行去重统计

1.5 时间段访问客户量趋势
说明：统计指定时间段内，1-24h之间，每个时间段的访问客户量。
横轴：1-24h，间隔为一小时，纵轴：指定时间段内同一小时内的总访问客户量。
展现：线状图、柱状图、饼状图
粒度：区间内小时段
条件：天
数据来源：咨询系统的web_chat_ems_2019_12等月表
注意: 除按照sid进行统计后, 还需同时按照 ip和sessionid进行去重统计

SQL：
1.SELECT  
2.    DATE_FORMAT(wce.create_time,'%H') '时间',  
3.    count(DISTINCT(wce.sid)) '总数'  
4.FROM  
5.    web_chat_ems_2019_12 wce  
6.GROUP BY  
7.    DATE_FORMAT(wce.create_time,'%H')  
8.ORDER BY   
9.    DATE_FORMAT(wce.create_time,'%H');  

1.6 来源渠道访问量占比
说明：统计指定时间段内，不同来源渠道的访问客户量占比。能够下钻到小时数据。
展现：饼状图
粒度：天
条件：年、季度、月
数据来源：咨询系统的web_chat_ems_2019_12等月表
注意: 除按照sid进行统计后, 还需同时按照 ip和sessionid进行去重统计

按年：显示指定年范围内每天的客户访问量
按季度：显示指定季度范围内每天的客户访问量
按月：显示指定月份范围内每天的客户访问量
SQL：
1.SELECT  
2.    count( DISTINCT ( wce.sid ) ) '总数',  
3.    wce.origin_channel   
4.FROM  
5.    web_chat_ems_2019_12 wce   
6.GROUP BY  
7.    wce.origin_channel;  

1.7 搜索来源访问量占比
说明：统计指定时间段内，不同搜索来源的访问客户量占比。能够下钻到小时数据。
展现：饼状图
指标：比值
维度：年、季度、月
粒度：天
条件：年、季度、月
数据来源：咨询系统的web_chat_ems_2019_12等月表
注意: 除按照sid进行统计后, 还需同时按照 ip和sessionid进行去重统计

按年：显示指定年范围内每天的客户访问量
按季度：显示指定季度范围内每天的客户访问量
按月：显示指定月份范围内每天的客户访问量
SQL：
8.SELECT  
9.    count( DISTINCT ( wce.sid ) ) '总数',  
10.    wce.seo_source   
11.FROM  
12.    web_chat_ems_2019_12 wce   
13.GROUP BY  
14.    wce.seo_source;  

1.8 活跃页面排行榜
说明：统计指定时间段内，产生访问客户量最多的页面排行榜TOPN。能够下钻到小时数据。
展现：柱状图
粒度：天
条件：年、季度、月、Top数量
数据来源：咨询系统的	web_chat_text_ems_2019_11等月表
注意: 除按照sid进行统计后, 还需同时按照 ip和sessionid进行去重统计

按年：显示指定年范围内每天的客户访问量
按季度：显示指定季度范围内每天的客户访问量
按月：显示指定月份范围内每天的客户访问量
SQL：
1.SELECT  
2.    count( DISTINCT ( wce.sid ) ),  
3.    wcte.from_url   
4.FROM  
5.    web_chat_text_ems_2019_11 wcte   
6.GROUP BY  
7.    wcte.from_url   
8.    LIMIT 20  

2. 意向线索主题看板
意向客户 及 有效线索 主题看板。
包含的指标有：1、总意向量、2、意向学员位置热力图、3、意向学科排名、4、意向校区排名、5、来源渠道占比、6、意向贡献中心占比、7、有效线索转化率 、8、有效线索量。

2.1 总意向量
说明：计期内，意向客户（包含自己录入的意向客户）总数。
展现：线状图
条件：年、月、线上线下
维度：年、月、线上线下、新老客户
指标：总意向客户量
粒度：天，可以下钻到小时数据。
数据来源：客户管理系统的customer_relationship意向表 
SQL：
1.SELECT  
2.    date_format(  
3.        cr.create_date_time,  
4.        '%Y-%m-%d'  
5.    ),  
6.    count(DISTINCT cr.customer_id)  
7.FROM  
8.    customer_relationship cr  join  customer_clue cc ON cc.customer_relationship_id = cr.id
9.WHERE  
10.    cr.create_date_time >= '2019-12-01'  
11.AND cr.create_date_time <= '2019-12-31 23:59:59' 
12.AND cr.origin_type IN ('NETSERVICE', 'PRESIGNUP') #线上（排除挖掘录入量）  
13.AND cc.clue_state IN (  
14.        'VALID_NEW_CLUES',  	--新客户新线索
15.        'VALID_PUBLIC_NEW_CLUE'  	--老客户新线索
16.    ) 
17.GROUP BY  
18.    date_format(  
19.        cr.create_date_time,  
20.        '%Y-%m-%d'  
21.    );  
2.2 意向学员位置热力图
说明：统计指定时间段内，新增的意向客户，所在城市区域人数热力图。
展现：地图热力图
维度：年、月、线上线下、新老
指标：按照地区聚合意向客户id数量
粒度：天，可以下钻到小时数据。
条件：年、月、线上线下
数据来源：客户管理系统的customer(客户静态信息表) 、customer_relationship（客户意向表）
SQL：
1.SELECT  
2.    c.area '区域',  
3.    count(DISTINCT cr.customer_id) '总数',  
4.    DATE_FORMAT(cr.create_date_time,'%Y-%m-%d') '客户创建时间'   
5.FROM  
6.    customer c, customer_relationship cr   
7.WHERE  cr.customer_id = c.id
8.    AND cr.create_date_time > '2019-11-01 00:00:00'   
9.    AND cr.create_date_time < '2019-11-30 23:59:59'   
10.GROUP BY DATE_FORMAT(cr.create_date_time,'%Y-%m-%d'), c.area  
11.ORDER BY DATE_FORMAT(cr.create_date_time,'%Y-%m-%d') ASC, count(1) DESC  

2.3 意向学科排名
说明：统计指定时间段内，新增的意向客户中，意向学科人数排行榜。学科名称要关联查询出来。
展现：柱状图
条件：年、月、线上线下
维度：年、月、线上线下、学科、新老
指标：学科意向客户量
粒度：天，可以下钻到小时数据。
数据来源：客户管理系统的customer_clue（客户线索表）、customer_relationship（客户意向表）、itcast_subject（学科表）
SQL：
意向学科，要以意向表的学科字段为准，不能以线索表为准。
1.SELECT cr.itcast_subject_id,  
2.       sj.name,  
3.       count(DISTINCT cr.customer_id)  
4.FROM customer_clue cc,  
5.     customer_relationship cr  
6.         left join itcast_subject sj on cr.itcast_subject_id = sj.id  
7.WHERE cc.clue_state = 'VALID_NEW_CLUES'  --新客户新线索
8.  AND ! cc.deleted  
9.  AND cr.origin_type IN ('NETSERVICE', 'PRESIGNUP') #线上（排除挖掘录入量）  
10.  AND cr.create_date_time > '2019-10-01 00:00:00'  
11.  AND cr.create_date_time < '2019-11-30 23:59:59'  
12.  AND cc.customer_relationship_id = cr.id  
13.GROUP BY cr.itcast_subject_id  
14.ORDER BY count(1) DESC;  


2.4 意向校区排名
说明：统计指定时间段内，新增的意向客户中，意向校区人数排行榜。
展现：柱状图
条件：年、月、线上线下
维度：年、月、线上线下、校区、新老
指标：校区意向客户量
粒度：天，可以下钻到小时数据。
数据来源：客户管理系统的
注意：学校id，同步时，0和null转换为统一数据，都转换为-1
SQL：
1.SELECT cr.itcast_school_id,  
2.       sc.name,  
3.       count(DISTINCT cr.customer_id)  
4.FROM customer_clue cc,  
5.     customer_relationship cr  
6.         left join itcast_school sc on cr.itcast_school_id = sc.id  
7.WHERE cc.clue_state = 'VALID_NEW_CLUES'  --新客户新线索
8.  AND ! cc.deleted  
9.  AND cr.origin_type IN ('NETSERVICE', 'PRESIGNUP') #线上（排除挖掘录入量）  
10.  AND cr.create_date_time > '2019-10-01 00:00:00'  
11.  AND cr.create_date_time < '2019-11-30 23:59:59'  
12.  AND cc.customer_relationship_id = cr.id  
13.GROUP BY cr.itcast_school_id  
14.ORDER BY count(1) DESC;  

2.5 来源渠道占比
说明：统计指定时间段内，新增的意向客户中，不同来源渠道的意向客户占比。
展现：饼状图
条件：年、月、线上线下
维度：年、月、线上线下、来源渠道、新老
粒度：天，可以下钻到小时数据。
指标：来源渠道意向客户量 
数据来源：客户管理系统的customer_clue（客户线索表）、customer_relationship（客户意向表）
SQL：
1.SELECT  
2.    cr.origin_type '来源渠道',  
3.    count(DISTINCT cr.customer_id) '总数'  
4.FROM  
5.    customer_relationship cr  
6.LEFT JOIN customer_clue cc ON cc.customer_relationship_id = cr.id  
7.WHERE  
8.    cc.clue_state = 'VALID_NEW_CLUES'
9.AND cr.create_date_time < '2019-11-30 23:59:59'
10.AND cr.create_date_time < '2019-11-30 23:59:59'  
11.AND cr.origin_type IN ('NETSERVICE','PRESIGNUP')   #线上（排除挖掘录入量）  
12.AND ! cc.deleted  
13.GROUP BY  
14.    cr.origin_type;  


2.6 意向贡献中心占比
说明：统计指定时间段内，新增的意向客户中，各咨询中心产生的意向客户数占比情况。
展现：饼状图
条件：年、月、线上线下
维度：年、月、线上线下、咨询中心、新老
指标：咨询中心意向客户数
粒度：天，可以下钻到小时数据。
数据来源：客户管理系统的customer_relationship（客户意向表）、employee（员工表）、scrm_department（部门表）
SQL：
1.SELECT  
2.    e.tdepart_id,  
3.    sd.`name`,  
4.    count(DISTINCT cr.customer_id) '总数'  
5.FROM  
6.    customer_relationship cr  
7.LEFT JOIN employee e ON cr.creator = e.id  
8.LEFT JOIN scrm_department sd ON e.tdepart_id = sd.id  
9.WHERE  
10.    cc.clue_state = 'VALID_NEW_CLUES'
11.AND cr.create_date_time >= '2019-10-01 00:00:00'  
12.AND cr.create_date_time <= '2019-11-30 23:59:59'
13.AND cr.origin_type IN ('NETSERVICE','PRESIGNUP')   #线上（排除挖掘录入量）  
14.GROUP BY  
15.    e.tdepart_id;  
2.7 有效线索转化率
说明：统计期内，访客咨询产生的有效线索的占比。有效线索量 / 咨询量，有效线索指的是拿到联系方式且有效（未被投诉认证为无效线索）。
展现：线状图。双轴：有效线索量、有效线索转化率。
条件：年、月、线上线下
维度：年、月、线上线下、新老
指标：访客咨询率=有效线索量/咨询量
粒度：天
数据来源：客户管理系统的customer_clue线索表、customer_relationship意向表、customer_appeal申诉表；咨询系统的web_chat_ems访问咨询表
SQL：
1.--咨询量(暂时以2019年7月的数据为例)：  
2.SELECT  
3.    count(1)  
4.FROM  
5.    web_chat_ems_2019_07  
6.WHERE  
7.    msg_count >= 1  
8.AND create_time >= '2019-07-01'  
9.AND create_time <= '2019-07-15 23:59:59';  

1.--有效线索量：  
2.SELECT  
3.    count(1)  
4.FROM  
5.    customer_clue cc  
6.LEFT JOIN customer_relationship cr ON cc.customer_relationship_id = cr.id  
7.WHERE  
8.    cc.clue_state IN (  
9.        'VALID_NEW_CLUES',  	--新客户新线索
10.        'VALID_PUBLIC_NEW_CLUE'  	--老客户新线索
11.    )  
12.AND cc.customer_relationship_id NOT IN (  
13.    SELECT  
14.        ca.customer_relationship_first_id  
15.    FROM  --投诉表，投诉成功的数据为无效线索
16.        customer_appeal ca  
17.    WHERE  
18.        ca.appeal_status = 1  AND ca.customer_relationship_first_id != 0
19.)  
20.AND cr.origin_type IN ('NETSERVICE','PRESIGNUP')   --线上（排除挖掘录入量）
21.AND ! cc.deleted  
22.AND cr.create_date_time <= '2019-07-01'  
23.AND cr.create_date_time <= '2019-07-15 23:59:59';  

2.8 有效线索转化率时间段趋势
说明：统计期内，1-24h之间，每个时间段的有效线索转化率。横轴：1-24h，间隔为1h，纵轴：每个时间段的有效线索转化率。
展现：线状图
条件：天、线上线下
维度：天、线上线下、新老
指标：某小时的总有效线索转化率
粒度：区间内小时段（区间内同一个时间点的总有效线索转化率）
数据来源：客户管理系统的customer_clue线索表、customer_relationship意向表、customer_appeal申诉表；咨询系统的web_chat_ems访问咨询表
SQL：同上

2.9 有效线索量
说明：统计期内，新增的咨询客户中，有效线索的数量。
展现：线状图。
条件：年、月、线上线下
维度：年、月、线上线下、新老
指标：有效线索的数量
粒度：天
数据来源：客户管理系统的customer_clue线索表、customer_relationship意向表、customer_appeal申诉表
SQL：同上

3. 报名用户主题看板
此主题下指标需要能够下钻到小时数据。
3.1 校区报名柱状图
说明：统计期内，全部报名客户中，各校区报名人数分布。
展现：柱状图
条件：年、月，校区
维度：天区间，按查询条件来定
指标：报名人数
粒度：天/线上线下/校区
数据来源：客户管理系统的customer_relationship、itcast_clazz报名课程表
SQL：
1.SELECT  
2.    count( 1 ) '报名数量',  
3.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) '时间',  
4.    ic.itcast_school_name '校区名称'   
5.FROM  
6.    customer_relationship cr  
7.    LEFT JOIN itcast_clazz ic ON cr.itcast_clazz_id = ic.id   
8.WHERE  
9.    cr.payment_state = 'PAID'   
10.    AND DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) >= '2019-08-01'   
11.    AND DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) <= '2019-12-01'
12.    AND cr.origin_type IN ('NETSERVICE', 'PRESIGNUP') #线上（排除挖掘录入量）   
13.GROUP BY  
14.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ),  
15.    ic.itcast_school_id   
16.ORDER BY  
17.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) ASC,  
18.    count( 1 ) DESC;  

3.2 学科报名柱状图
说明：统计期内，全部报名客户中，各学科报名人数分布。
展现：柱状图
条件：年、月，学科
维度：天区间，按查询条件来定
指标：报名人数
粒度：天/线上线下/学科
数据来源：客户管理系统的customer_relationship、itcast_clazz报名课程表
SQL：
1.SELECT  
2.    count( 1 ) '报名数量',  
3.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) '时间',  
4.    ic.itcast_subject_name '学科名称'   
5.FROM  
6.    customer_relationship cr  
7.    LEFT JOIN itcast_clazz ic ON cr.itcast_clazz_id = ic.id   
8.WHERE  
9.    cr.payment_state = 'PAID'   
10.    AND DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) >= '2019-08-01'   
11.    AND DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) <= '2019-12-01'   
12.GROUP BY  
13.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ),  
14.    ic.itcast_subject_id   
15.ORDER BY  
16.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) ASC,  
17.    count( 1 ) DESC;  

3.3 总报名量
说明：统计期内，已经缴费的报名客户总量。
展现：数值。
条件：年、月
维度：年、月
指标：报名客户总量
粒度：天
数据来源：客户管理系统的customer_relationship表 
SQL：
1.SELECT  
2.    count( 1 ) '报名数量',  
3.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) '时间'  
4.FROM  
5.    customer_relationship cr  
6.WHERE  
7.    cr.payment_state = 'PAID'   
8.    AND DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) >= '2019-08-01'   
9.    AND DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) <= '2019-12-01'   
10.GROUP BY  
11.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' )  
12.ORDER BY  
13.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) ASC,  
14.    count( 1 ) DESC;  

3.4 线上报名量
说明：总报名量中来源渠道为线上访客渠道的报名总量
展现：线状图。
条件：年、月
维度：天区间，按查询条件来定
指标：报名客户总量
粒度：天
数据来源：客户管理系统的customer_relationship表
 SQL：
1.SELECT  
2.    count( 1 ) '报名数量',  
3.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) '时间'  
4.FROM  
5.    customer_relationship cr  
6.WHERE  
7.    cr.payment_state = 'PAID'   
8.    AND cr.origin_type IN ('NETSERVICE','PRESIGNUP')  
9.    AND DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) >= '2019-08-01'   
10.    AND DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) <= '2019-12-01'   
11.GROUP BY  
12.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' )  
13.ORDER BY  
14.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) ASC,  
15.    count( 1 ) DESC;  

3.5 意向用户报名转化率
说明：统计期内，新增的意向客户中报名的客户占比。全部报名人数 / 全部新增的意向人数
展现：线状图。双轴：全部报名人数、报名转化率。
条件：年、月
维度：天/线上线下
指标：报名转化率=全部报名人数/全部新增的意向人数
粒度：天
数据来源：客户管理系统的customer_relationship表 
SQL：
1.SELECT  
2.    CONCAT(  
3.        signup_num.num / total_num.num * 100,  
4.        '%'   
5.    ) '报名转化率',  
6.    total_num.date_day '时间'   
7.FROM  
8.    (  
9.        SELECT  
10.            count( 1 ) AS num,  
11.            DATE_FORMAT( cr.create_date_time, '%Y-%m-%d' ) AS date_day   
12.        FROM  
13.            customer_relationship cr   
14.        GROUP BY  
15.            DATE_FORMAT( cr.create_date_time, '%Y-%m-%d' )   
16.    ) total_num  
17.    INNER JOIN (  
18.        SELECT  
19.            count( 1 ) AS num,  
20.            DATE_FORMAT( cr.create_date_time, '%Y-%m-%d' ) AS date_day   
21.        FROM  
22.            customer_relationship cr   
23.        WHERE  
24.            cr.payment_state = 'PAID'   
25.        GROUP BY  
26.            DATE_FORMAT( cr.create_date_time, '%Y-%m-%d' )   
27.    ) signup_num ON total_num.date_day = signup_num.date_day  

3.6 有效线索报名转化率
说明：线上报名量 / 线上有效线索量，与上一个指标类似，此处的线索量需要排除已申诉数据。
展现：线状图。双轴：线上报名人数、线上报名转化率。
条件：年、月
维度：天/线上线下
指标：线上报名转化率=线上报名人数/线上有效线索量
粒度：天
数据来源：客户管理系统的customer_relationship表、customer_clue表、customer_appeal表
SQL：
1.SELECT  
2.    CONCAT(  
3.        signup_num.num / total_num.num * 100,  
4.        '%'   
5.    ) '线上报名转化率',  
6.    total_num.date_day '时间'   
7.FROM  
8.    (  
9.    SELECT  
10.        count( 1 ) AS num,  
11.        DATE_FORMAT( cr.create_date_time, '%Y-%m-%d' ) AS date_day   
12.    FROM  
13.        customer_clue cc  
14.        LEFT JOIN customer_relationship cr ON cr.id = cc.customer_relationship_id  
15.     WHERE  
16.        cc.clue_state IN ( 'VALID_NEW_CLUES', 'VALID_PUBLIC_NEW_CLUE' ) 
17.         AND !cc.deleted  
18.        AND cr.id NOT IN ( SELECT customer_relationship_first_id FROM customer_appeal WHERE appeal_status = '1' )   
19.    GROUP BY  
20.        DATE_FORMAT( cr.create_date_time, '%Y-%m-%d' )   
21.    ) total_num  
22.    INNER JOIN (  
23.    SELECT  
24.        count( 1 ) AS num,  
25.        DATE_FORMAT( cr.create_date_time, '%Y-%m-%d' ) AS date_day   
26.    FROM  
27.        customer_relationship cr   
28.    WHERE  
29.        cr.payment_state = 'PAID'   
30.    GROUP BY  
31.        DATE_FORMAT( cr.create_date_time, '%Y-%m-%d' )   
32.    ) signup_num ON total_num.date_day = signup_num.date_day  

3.7 日报名趋势图
说明：统计期内，每天报名人数的趋势图。
展现：线状图。
条件：年、月
维度：天/线上线下
指标：报名人数
粒度：天
数据来源：客户管理系统的customer_relationship表 
SQL：
1.SELECT  
2.    count( 1 ) '报名人数',  
3.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' )   
4.FROM  
5.    customer_relationship cr   
6.WHERE  
7.    cr.payment_state = 'PAID'   
8.    AND DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) >= '2019-08-01'  
9.    AND DATE_FORMAT( cr.payment_time, '%Y-%m-%d' ) <= '2019-12-01'  
10.GROUP BY  
11.    DATE_FORMAT( cr.payment_time, '%Y-%m-%d' )  

3.8 校区学科的报名学员TOP
说明：统计期内，全部报名学员中，校区学科排行榜，topN。A校区b学科第一，B校区a学科第二等等。
展现：柱状图
条件：年、月，校区，学科，数据量N
维度：天/线上线下 
指标：报名学员人数 
粒度：各校区各学科的报名人数和
数据来源：客户管理系统的customer_relationship表、itcast_clazz表
SQL：
1.SELECT  
2.    count(1) '总数',  
3.    itc.itcast_school_id,  
4.    itc.itcast_school_name,  
5.    itc.itcast_subject_id,
6.    itc.itcast_subject_name,  
7.    cr.payment_state,  
8.    cr.payment_time   
9.FROM  
10.    customer_relationship cr  
11.    LEFT JOIN itcast_clazz itc ON cr.itcast_clazz_id = itc.id   
12.WHERE  
13.    cr.payment_state = 'PAID'   
14.    AND cr.payment_time >= '2019-10-01'   
15.    AND cr.payment_time <= '2020-10-31 23:59:59'   
16.GROUP BY  
17.    itc.itcast_school_id,  
18.    itc.itcast_subject_id   
19.ORDER BY  
20.    count(1) DESC;  

3.9 来源渠道占比
说明：统计期内，全部报名学员中，不同来源渠道的报名学员占比情况。
展现：饼状图
条件：年、月
维度：天/线上线下/来源渠道
指标：比值
数据来源：客户管理系统的customer_relationship表 
SQL：
1.SELECT  
2.    count( 1 ) '总数',  
3.    cr.origin_type,  
4.    cr.payment_state,  
5.    cr.payment_time   
6.FROM  
7.    customer_relationship cr   
8.WHERE  
9.    cr.payment_state = 'PAID'   
10.    AND cr.payment_time >= '2019-10-01'   
11.    AND cr.payment_time <= '2019-10-31 23:59:59'   
12.GROUP BY  
13.    cr.origin_type;  

3.10 咨询中心报名贡献
说明：统计期内，全部报名学员中，各咨询中心的报名学员人数占比情况。
展现：饼状图
条件：年、月，咨询中心
维度：天/线上线下/咨询中心
指标：报名学员人数
粒度：天/报名学员人数
数据来源：客户管理系统的customer_relationship表、employee表、scrm_department表
SQL：
1.SELECT  
2.    count( 1 ),  
3.    e.tdepart_id,  
4.    sd.`name`   
5.FROM  
6.    customer_relationship cr  
7.    LEFT JOIN employee e ON cr.creator = e.id  
8.    LEFT JOIN scrm_department sd ON e.tdepart_id = sd.id   
9.WHERE  
10.    cr.payment_state = 'PAID'   
11.    AND cr.payment_time >= '2019-10-01'   
12.    AND cr.payment_time <= '2019-10-31 23:59:59'   
13.GROUP BY  
14.    e.tdepart_id;  
4. 出勤主题看板
4.1 班级出勤人数
说明：统计指定时间段内，不同班级的出勤人数。打卡时间在上课前40分钟(否则认为无效)~上课时间点之内，则为正常上课打卡。可以下钻到具体学生的出勤数据。跨天数据直接累加。
指标：出勤人数
维度：年、月、天
粒度：上午、下午、晚自习
条件：年、月
数据来源：教学实施与保障系统teach的course_table_upload_detail班级课表、tbh_student_signin_record学生打卡记录表、tbh_class_time_table班级作息时间表。

4.2 班级出勤率
说明：统计指定时间段内，不同班级的学生出勤率。可以下钻到具体学生的出勤数据。出勤率=出勤人数/当日在读学员人数。
指标：出勤率
维度：年、月、天
粒度：上午、下午、晚自习
条件：年、月
数据来源：教学实施与保障系统的course_table_upload_detail班级课表、tbh_student_signin_record学生打卡记录表、tbh_class_time_table班级作息时间表、class_studying_student_count班级在读学生人数。

4.3 班级迟到人数
说明：统计指定时间段内，不同班级的迟到人数。上课10分钟后视为迟到。可以下钻到具体学生的迟到数据。跨天数据直接累加。
指标：迟到人数
维度：年、月、天
粒度：上午、下午、晚自习
条件：年、月
数据来源：教学实施与保障系统的course_table_upload_detail班级课表、tbh_student_signin_record学生打卡记录表、tbh_class_time_table班级作息时间表。

4.4 班级迟到率
说明：统计指定时间段内，不同班级的学生迟到率。上课10分钟后视为迟到。可以下钻到具体学生的迟到数据。迟到率=迟到人数/当日在读学员人数。
指标：迟到率
维度：年、月、天
粒度：上午、下午、晚自习
条件：年、月
数据来源：教学实施与保障系统的course_table_upload_detail班级课表、tbh_student_signin_record学生打卡记录表、tbh_class_time_table班级作息时间表、class_studying_student_count班级在读学生人数。
SQL：
select dt.every_date,
       ctud.class_id,
       tssr.student_id,
       if(
           #上午正常打卡为0，迟到10分钟以上为1，其他(请假+旷课)为2
           sum(
               case
               #上午打卡时间是否在上课前40分钟~下课时间段之内
                   when time(tssr.signin_time) between TIMESTAMPADD(minute, -40, tctt.morning_begin_time) and tctt.morning_end_time
                       then 1   #上午来了
                   else 0 end   #上午没来
            ) > 0,  #打卡多次，只要有一次正常打卡，就会>0，返回true；否则没来，返回false
           if(
               sum(
                   case
               #上午打卡时间是否在上课前40分钟~上课后10分钟之内
                      when time(tssr.signin_time) between TIMESTAMPADD(minute, -40, tctt.morning_begin_time) and TIMESTAMPADD(minute, 10, tctt.morning_begin_time)
                          then 1    #正常出勤
                      else 0 end    #迟到
                ) > 0,              #有一次打卡是正常出勤，就会>0，返回true；否则迟到，返回false
               0,   #正常出勤
               1    #迟到
            ),
           2    #上午没来
        ) as morning_signin,
       if(
           #下午正常打卡为0，迟到10分钟以上为1，其他(请假+旷课)为2
                   sum(case
                           when time(tssr.signin_time) between TIMESTAMPADD(minute, -40, tctt.afternoon_begin_time) and tctt.afternoon_end_time
                               then 1
                           else 0 end) > 0,
                   if(sum(case
                              when time(tssr.signin_time) between TIMESTAMPADD(minute, -40, tctt.afternoon_begin_time) and TIMESTAMPADD(minute, 10, tctt.afternoon_begin_time)
                                  then 1
                              else 0 end) > 0, 0, 1), 2) as afternoon_signin,
       if(
           #晚自习正常打卡为0，迟到10分钟以上为1，其他(请假+旷课)为2
                   sum(case
                           when time(tssr.signin_time) between TIMESTAMPADD(minute, -20, tctt.evening_begin_time) and tctt.evening_end_time
                               then 1
                           else 0 end) > 0,
                   if(sum(case
                              when time(tssr.signin_time) between TIMESTAMPADD(minute, -20, tctt.evening_begin_time) and TIMESTAMPADD(minute, 10, tctt.evening_begin_time)
                                  then 1
                              else 0 end) > 0, 0, 1), 2) as evening_signin
from (
         #获取今天之前一周内的日期
         select datelist as every_date from calendar where datelist between '2019-09-01' and '2019-09-30'
     ) dt
         #日期课表不为空且不是开班典礼
         left join course_table_upload_detail ctud
                   on ctud.class_date = dt.every_date and ifnull(ctud.content, '') != '' and
                      ctud.content != '开班典礼'
    #学生打卡记录日期和班级匹配，且开启共屏进入学习
         left join tbh_student_signin_record tssr
                   on tssr.class_id = ctud.class_id and tssr.signin_date = dt.every_date and
                      tssr.share_state = 1
    #获取班级作息时间以判断是否按时出勤
         left join tbh_class_time_table tctt on tctt.id = tssr.time_table_id
     #按照日期、班级、学生分组统计
group by dt.every_date, ctud.class_id, tssr.student_id;

4.5 班级请假人数
说明：统计指定时间段内，不同班级的请假人数。跨天数据直接累加。
指标：请假人数
维度：年、月、天
粒度：上午、下午、晚自习
条件：年、月
数据来源：教学实施与保障系统的student_leave_apply学生请假申请表、tbh_class_time_table班级作息时间表、course_table_upload_detail班级课表。
SQL：
select cud.class_date as dateinfo,
       cud.class_id,
       count(distinct sla.student_id) as morning_leave_count
from student_leave_apply sla,
     tbh_class_time_table ct,
     course_table_upload_detail cud
--       表关联
where sla.class_id = ct.class_id = cud.class_id
--   课程表，当天有课程内容
  AND cud.content IS NOT NULL
  AND cud.content != '开班典礼'
--   作息时间表，数据在生效期范围内
  and cud.class_date between ct.use_begin_date and ct.use_end_date
--   请假表，请假状态已审核通过，且没有取消、数据有效
  and sla.audit_state = 1
  and sla.cancel_state = 0
  and sla.valid_state = 1
--   关联判断请假周期，请假时间周期要与课程和作息时间对比
--      cud.class_date          课程表的上课日期     2020-09-16
--      ct.morning_begin_time   作息表的早上上课时间  09:00:00
--      请假结束时间 >= 2020-09-16 09:00:00 >= 请假开始时间，认为上午请假了
  and concat(cud.class_date, ' ', ct.morning_begin_time) >= sla.begin_time
  and concat(cud.class_date, ' ', ct.morning_begin_time) <= sla.end_time
group by cud.class_date, cud.class_id;

4.6 班级请假率
说明：统计指定时间段内，不同班级的学生请假率。请假率=请假人数/当日在读学员人数。
指标：请假率
维度：年、月、天
粒度：上午、下午、晚自习
条件：年、月
数据来源：教学实施与保障系统的student_leave_apply学生请假申请表、class_studying_student_count班级在读学生人数。

4.7 班级旷课人数
说明：统计指定时间段内，不同班级的旷课人数。跨天数据直接累加。旷课人数=当日在读学员人数-出勤人数-请假人数。
指标：旷课人数
维度：年、月、天
粒度：上午、下午、晚自习
条件：年、月
数据来源：教学实施与保障系统的course_table_upload_detail班级课表、tbh_student_signin_record学生打卡记录表、tbh_class_time_table班级作息时间表、student_leave_apply学生请假申请表。

4.8 班级旷课率
说明：统计指定时间段内，不同班级的学生旷课率。旷课率=旷课人数/当日在读学员人数。
指标：旷课率
维度：年、月、天
粒度：上午、下午、晚自习
条件：年、月
数据来源：教学实施与保障系统的course_table_upload_detail班级课表、tbh_student_signin_record学生打卡记录表、tbh_class_time_table班级作息时间表、student_leave_apply学生请假申请表、class_studying_student_count班级在读学生人数。


SQL：
select date_format(tmp3.every_date, '%Y/%m/%d'),
       tmp3.class_count,
       tmp3.student_count,
       tmp3.morning_att_count,
       tmp3.morning_late_count,
       tmp3.morning_leave_count,
       #减出旷课人数
       (tmp3.student_count - tmp3.morning_att_count - tmp3.morning_leave_count)                    as morning_truant_count,
       concat(cast((tmp3.morning_att_count / tmp3.student_count) * 100 as decimal(8, 2)), '%')     as '上午出勤率',
       concat(cast((tmp3.morning_late_count / tmp3.student_count) * 100 as decimal(8, 2)), '%')    as '上午迟到率',
       concat(cast((tmp3.morning_leave_count / tmp3.student_count) * 100 as decimal(8, 2)), '%')   as '上午请假率',
       concat(cast(((tmp3.student_count - tmp3.morning_att_count - tmp3.morning_leave_count) / tmp3.student_count) *
                   100 as decimal(8, 2)), '%')                                                     as '上午旷课率',
       tmp3.afternoon_att_count,
       tmp3.afternoon_late_count,
       tmp3.afternoon_leave_count,
       (tmp3.student_count - tmp3.afternoon_att_count -
        tmp3.afternoon_leave_count)                                                                as afternoon_truant_count,
       concat(cast((tmp3.afternoon_att_count / tmp3.student_count) * 100 as decimal(8, 2)), '%')   as '下午出勤率',
       concat(cast((tmp3.afternoon_late_count / tmp3.student_count) * 100 as decimal(8, 2)), '%')  as '下午迟到率',
       concat(cast((tmp3.afternoon_leave_count / tmp3.student_count) * 100 as decimal(8, 2)), '%') as '下午请假率',
       concat(cast(((tmp3.student_count - tmp3.afternoon_att_count - tmp3.afternoon_leave_count) / tmp3.student_count) *
                   100 as decimal(8, 2)), '%')                                                     as '下午旷课率',
       tmp3.evening_att_count,
       tmp3.evening_late_count,
       tmp3.evening_leave_count,
       (tmp3.student_count - tmp3.evening_att_count - tmp3.evening_leave_count)                    as evening_truant_count,
       concat(cast((tmp3.evening_att_count / tmp3.student_count) * 100 as decimal(8, 2)), '%')     as '晚上出勤率',
       concat(cast((tmp3.evening_late_count / tmp3.student_count) * 100 as decimal(8, 2)), '%')    as '晚上迟到率',
       concat(cast((tmp3.evening_leave_count / tmp3.student_count) * 100 as decimal(8, 2)), '%')   as '晚上请假率',
       concat(cast(((tmp3.student_count - tmp3.evening_att_count - tmp3.evening_leave_count) / tmp3.student_count) *
                   100 as decimal(8, 2)), '%')                                                     as '晚上旷课率'
from (
         select tmp2.every_date,
                count(tmp2.class_id)            as class_count,
                sum(tmp2.student_count)         as student_count,
                sum(tmp2.morning_att_count)     as morning_att_count,
                sum(tmp2.morning_late_count)    as morning_late_count,
                sum(tmp2.morning_leave_count)   as morning_leave_count,
                sum(tmp2.afternoon_att_count)   as afternoon_att_count,
                sum(tmp2.afternoon_late_count)  as afternoon_late_count,
                sum(tmp2.afternoon_leave_count) as afternoon_leave_count,
                sum(tmp2.evening_att_count)     as evening_att_count,
                sum(tmp2.evening_late_count)    as evening_late_count,
                sum(tmp2.evening_leave_count)   as evening_leave_count
         from (
                  select tmp.every_date,
                         tmp.class_id,
                         #班级人数
                         (select cssc.studying_student_count
                          from class_studying_student_count cssc
                          where cssc.studying_date = tmp.every_date
                            and cssc.class_id = tmp.class_id)                                            as student_count,
                         #上午出勤人数(包括迟到)
                         count(distinct (case
                                             when tmp.morning_signin = 0 or tmp.morning_signin = 1 then tmp.student_id
                                             else null end))                                             as morning_att_count,
                         #上午迟到人数
                         count(distinct
                               (case when tmp.morning_signin = 1 then tmp.student_id else null end))     as morning_late_count,
                         #下午出勤人数(包括迟到)
                         count(distinct (case
                                             when tmp.afternoon_signin = 0 or tmp.afternoon_signin = 1
                                                 then tmp.student_id
                                             else null end))                                             as afternoon_att_count,
                         #下午迟到人数
                         count(distinct
                               (case when tmp.afternoon_signin = 1 then tmp.student_id else null end))   as afternoon_late_count,
                         #晚自习出勤人数(包括迟到)
                         count(distinct (case
                                             when tmp.evening_signin = 0 or tmp.evening_signin = 1 then tmp.student_id
                                             else null end))                                             as evening_att_count,
                         #晚自习迟到人数
                         count(distinct
                               (case when tmp.evening_signin = 1 then tmp.student_id else null end))     as evening_late_count,
                         #上午请假学生人数，审批通过、未撤销、有效、班级匹配、请假时间在课表上课时间之内
                         (select count(distinct sla.student_id)
                          from student_leave_apply sla
                          where sla.audit_state = 1
                            and sla.cancel_state = 0
                            and sla.valid_state = 1
                            and sla.class_id = tmp.class_id
                            and concat(tmp.every_date, ' ', tctt2.morning_begin_time) >= sla.begin_time
                            and concat(tmp.every_date, ' ', tctt2.morning_begin_time) <=
                                sla.end_time)                                                            as morning_leave_count,
                         #下午请假学生人数，审批通过、未撤销、有效、班级匹配、请假时间在课表上课时间之内
                         (select count(distinct sla.student_id)
                          from student_leave_apply sla
                          where sla.audit_state = 1
                            and sla.cancel_state = 0
                            and sla.valid_state = 1
                            and sla.class_id = tmp.class_id
                            and concat(tmp.every_date, ' ', tctt2.afternoon_begin_time) >= sla.begin_time
                            and concat(tmp.every_date, ' ', tctt2.afternoon_begin_time) <=
                                sla.end_time)                                                            as afternoon_leave_count,
                         #晚自习请假学生人数，审批通过、未撤销、有效、班级匹配、请假时间在课表上课时间之内
                         (select count(distinct sla.student_id)
                          from student_leave_apply sla
                          where sla.audit_state = 1
                            and sla.cancel_state = 0
                            and sla.valid_state = 1
                            and sla.class_id = tmp.class_id
                            and concat(tmp.every_date, ' ', tctt2.evening_begin_time) >= sla.begin_time
                            and concat(tmp.every_date, ' ', tctt2.evening_begin_time) <=
                                sla.end_time)                                                            as evening_leave_count
                  from (
                           select dt.every_date,
                                  ctud.class_id,
                                  tssr.student_id,
                                  if(
                                      #上午正常打卡为0，迟到10分钟以上为1，其他(请假+旷课)为2
                                              sum(case
                                                  #上午打卡时间是否在上课前40分钟~下课时间段之内
                                                      when time(tssr.signin_time) between TIMESTAMPADD(minute, -40, tctt.morning_begin_time) and tctt.morning_end_time
                                                          then 1
                                                      else 0 end) > 0,
                                              if(sum(case
                                                  #上午打卡时间是否在上课前40分钟~上课后10分钟之内
                                                         when time(tssr.signin_time) between TIMESTAMPADD(minute, -40, tctt.morning_begin_time) and TIMESTAMPADD(minute, 10, tctt.morning_begin_time)
                                                             then 1
                                                         else 0 end) > 0, 0, 1), 2) as morning_signin,
                                  if(
                                      #下午正常打卡为0，迟到10分钟以上为1，其他(请假+旷课)为2
                                              sum(case
                                                      when time(tssr.signin_time) between TIMESTAMPADD(minute, -40, tctt.afternoon_begin_time) and tctt.afternoon_end_time
                                                          then 1
                                                      else 0 end) > 0,
                                              if(sum(case
                                                         when time(tssr.signin_time) between TIMESTAMPADD(minute, -40, tctt.afternoon_begin_time) and TIMESTAMPADD(minute, 10, tctt.afternoon_begin_time)
                                                             then 1
                                                         else 0 end) > 0, 0, 1), 2) as afternoon_signin,
                                  if(
                                      #晚自习正常打卡为0，迟到10分钟以上为1，其他(请假+旷课)为2
                                              sum(case
                                                      when time(tssr.signin_time) between TIMESTAMPADD(minute, -20, tctt.evening_begin_time) and tctt.evening_end_time
                                                          then 1
                                                      else 0 end) > 0,
                                              if(sum(case
                                                         when time(tssr.signin_time) between TIMESTAMPADD(minute, -20, tctt.evening_begin_time) and TIMESTAMPADD(minute, 10, tctt.evening_begin_time)
                                                             then 1
                                                         else 0 end) > 0, 0, 1), 2) as evening_signin
                           from (
                                    #获取今天之前一周内的日期
                                    select datelist as every_date from calendar where datelist between  '2019-09-01' and  '2019-09-30'
                               ) dt
                                    #日期课表不为空且不是开班典礼
                                    left join course_table_upload_detail ctud
                                              on ctud.class_date = dt.every_date and ifnull(ctud.content, '') != '' and
                                                 ctud.content != '开班典礼'
                               #学生打卡记录日期和班级匹配，且开启共屏进入学习
                                    left join tbh_student_signin_record tssr
                                              on tssr.class_id = ctud.class_id and tssr.signin_date = dt.every_date and
                                                 tssr.share_state = 1
                               #获取班级作息时间以判断是否按时出勤
                                    left join tbh_class_time_table tctt on tctt.id = tssr.time_table_id
                                #按照日期、班级、学生分组统计
                           group by dt.every_date, ctud.class_id, tssr.student_id
                       ) as tmp
                           #获取班级作息时间以判断是否按时出勤
                           left join tbh_class_time_table tctt2
                                     on tctt2.class_id = tmp.class_id and tmp.every_date >= tctt2.use_begin_date and
                                        tmp.every_date <= tctt2.use_end_date
                       #按照日期和班级统计
                  group by tmp.every_date, tmp.class_id
              ) as tmp2
         #按照日期统计
         group by tmp2.every_date
     ) as tmp3;


