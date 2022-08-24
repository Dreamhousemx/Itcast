use mysql.scrm_bi;
insert into mysql.scrm_bi.itcast_visit
select *
from hive.itcast_dws.visit_dws;

select * from mysql.scrm_bi.itcast_visit;

insert into mysql.scrm_bi.itcast_consult
select *
from hive.itcast_dws.consult_dws;

select * from mysql.scrm_bi.itcast_consult;