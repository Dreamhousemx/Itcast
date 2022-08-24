insert into table dws.class_attendance_dws partition(yearinfo,monthinfo,dayinfo)
select  
  dateinfo, 
  class_id, 
  studying_student_count, 
  
  morning_att_count, 
  morning_att_ratio, 
  afternoon_att_count, 
  afternoon_att_ratio, 
  evening_att_count, 
  evening_att_ratio, 
  
  morning_late_count, 
  morning_late_ratio, 
  afternoon_late_count, 
  afternoon_late_ratio, 
  evening_late_count, 
  evening_late_ratio, 
  
  morning_leave_count, 
  morning_leave_ratio, 
  afternoon_leave_count, 
  afternoon_leave_ratio, 
  evening_leave_count, 
  evening_leave_ratio, 
  
  morning_truant_count, 
  morning_truant_ratio, 
  afternoon_truant_count, 
  afternoon_truant_ratio, 
  evening_truant_count, 
  evening_truant_ratio, 
  
  '2' as time_type,
  yearinfo, 
  monthinfo, 
  dayinfo
from dwm.attendance_summary_dwm ; 
```
--按月来统计 上午 下午 和晚自习
insert into table dws.class_attendance_dws partition(yearinfo,monthinfo,dayinfo)
select  
  concat(yearinfo,'-',monthinfo) as dateinfo, 
  class_id, 
  sum(studying_student_count) as studying_student_count, 
  
  sum(morning_att_count) as morning_att_count, 
  concat(cast(sum(morning_att_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as morning_att_ratio, 
  sum(afternoon_att_count) as morning_att_count, 
  concat(cast(sum(afternoon_att_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%')  as afternoon_att_ratio, 
  sum(evening_att_count) as evening_att_count, 
  concat(cast(sum(evening_att_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as evening_att_ratio, 
  
  sum(morning_late_count) as morning_late_count, 
  concat(cast(sum(morning_late_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as morning_late_ratio, 
  sum(afternoon_late_count) as afternoon_late_count, 
  concat(cast(sum(afternoon_late_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as afternoon_late_ratio, 
  sum(evening_late_count) as evening_late_count, 
  concat(cast(sum(evening_late_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as evening_late_ratio, 
  
  sum(morning_leave_count) as morning_leave_count, 
  concat(cast(sum(morning_leave_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as morning_leave_ratio, 
  sum(afternoon_leave_count) as afternoon_leave_count, 
  concat(cast(sum(afternoon_leave_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%')  as afternoon_leave_ratio, 
  sum(evening_leave_count) as evening_leave_count, 
  concat(cast(sum(evening_leave_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as evening_leave_ratio, 
  
  sum(morning_truant_count) as morning_truant_count, 
  concat(cast(sum(morning_truant_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%')  as morning_truant_ratio, 
  sum(afternoon_truant_count) as afternoon_truant_count, 
  concat(cast(sum(afternoon_truant_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as afternoon_truant_ratio, 
  sum(evening_truant_count)  as evening_truant_count, 
  concat(cast(sum(evening_truant_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as evening_truant_ratio, 
  
  '4' as time_type,
  yearinfo, 
  monthinfo, 
  '-1' as dayinfo
from dwm.attendance_summary_dwm
group by  yearinfo, monthinfo,class_id ; 
```

-- 按年统计, 上午 下午 和 晚自习

insert into table dws.class_attendance_dws partition(yearinfo,monthinfo,dayinfo)
select  
  yearinfo as dateinfo, 
  class_id, 
  sum(studying_student_count) as studying_student_count, 
  
  sum(morning_att_count) as morning_att_count, 
  concat(cast(sum(morning_att_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as morning_att_ratio, 
  sum(afternoon_att_count) as morning_att_count, 
  concat(cast(sum(afternoon_att_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%')  as afternoon_att_ratio, 
  sum(evening_att_count) as evening_att_count, 
  concat(cast(sum(evening_att_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as evening_att_ratio, 
  
  sum(morning_late_count) as morning_late_count, 
  concat(cast(sum(morning_late_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as morning_late_ratio, 
  sum(afternoon_late_count) as afternoon_late_count, 
  concat(cast(sum(afternoon_late_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as afternoon_late_ratio, 
  sum(evening_late_count) as evening_late_count, 
  concat(cast(sum(evening_late_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as evening_late_ratio, 
  
  sum(morning_leave_count) as morning_leave_count, 
  concat(cast(sum(morning_leave_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as morning_leave_ratio, 
  sum(afternoon_leave_count) as afternoon_leave_count, 
  concat(cast(sum(afternoon_leave_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%')  as afternoon_leave_ratio, 
  sum(evening_leave_count) as evening_leave_count, 
  concat(cast(sum(evening_leave_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as evening_leave_ratio, 
  
  sum(morning_truant_count) as morning_truant_count, 
  concat(cast(sum(morning_truant_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%')  as morning_truant_ratio, 
  sum(afternoon_truant_count) as afternoon_truant_count, 
  concat(cast(sum(afternoon_truant_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as afternoon_truant_ratio, 
  sum(evening_truant_count)  as evening_truant_count, 
  concat(cast(sum(evening_truant_count)  / sum(studying_student_count) * 100 as  decimal(8,2)), '%') as evening_truant_ratio, 
  
  '5' as time_type,
  yearinfo, 
  '-1' as monthinfo, 
  '-1' as dayinfo
from dwm.attendance_summary_dwm
group by yearinfo,class_id ; 