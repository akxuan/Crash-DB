--count taxi in a crash

SELECT count (LIC_plate_NO),
         count (distinct LIC_plate_NO) from (

SELECT DISTINCT LIC_plate_NO,
         date_of_occurrence
    FROM 
        (SELECT traffic_crash_id report_id ,
         to_char(date_of_occurrence,'DDMM') date_of_occurrence, 
         to_number(to_char(date_of_occurrence,'HH24')) crash_hr
          FROM chris_dwh.ufe_tc_reports@cdot_dal_link
        WHERE date_of_occurrence > '1-JAN-18' 
                AND date_of_occurrence < '1-JULY-18') t1  -- select report id by time
                
        INNER JOIN     ( select LIC_plate_NO, report_ID    from chris_dwh.ufe_tc_units_vehicles@cdot_dal_link  where  LIC_plate_NO like '%TX') t2 -- select unite with plant number , TNP at fault
        USING (report_id)
            ) all_table;
            
-- count taxi at fault in a crash       
SELECT count (LIC_plate_NO),
         count (distinct LIC_plate_NO) from (

SELECT DISTINCT LIC_plate_NO,
         date_of_occurrence
    FROM 
        (SELECT traffic_crash_id report_id ,
         to_char(date_of_occurrence,'DDMM') date_of_occurrence, 
         to_number(to_char(date_of_occurrence,'HH24')) crash_hr
          FROM chris_dwh.ufe_tc_reports@cdot_dal_link
        WHERE date_of_occurrence > '1-JAN-18' 
                AND date_of_occurrence < '1-JULY-18') t1  -- select report id by time
                
        INNER JOIN     ( select LIC_plate_NO, report_ID    from chris_dwh.ufe_tc_units_vehicles@cdot_dal_link  where unit_no =  1
        and   LIC_plate_NO like '%TX') t2 -- select unite with plant number , TNP at fault
        USING (report_id)
            ) all_table;
            
