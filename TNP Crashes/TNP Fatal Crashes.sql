

SELECT count (LIC_plate_NO),
         count (distinct LIC_plate_NO)
FROM 
    (
    
    SELECT DISTINCT LIC_plate_NO,
         date_of_occurrence
    FROM 
        (
        SELECT traffic_crash_id report_id ,
         to_char(date_of_occurrence,
         'DDMM') date_of_occurrence, to_number(to_char(date_of_occurrence,'HH24') ) crash_hr
        FROM chris_dwh.ufe_tc_reports@cdot_dal_link  WHERE date_of_occurrence > '1-JAN-18' AND date_of_occurrence < '1-JULY-18') t1
        INNER JOIN 
       (select report_id, LIC_plate_no,VIN_NO from chris_dwh.ufe_tc_units_vehicles@cdot_dal_link -- WHERE unit_no = 1
       ) t2  USING (report_id)  
        inner join 
       (select LIC_plate_no,VIN_NO,vehicle_id from chris_dwh.ufe_tc_units_vehicles@cdot_dal_link) t3 using (VIN_NO)
         Inner join (       
       select  vehicle_id from chris_dwh.ufe_tc_passengers@cdot_dal_link where injury_classification_cd =  'K' ) tt using  (vehicle_ID)
        INNER JOIN 
            (SELECT vin vin_no,
         to_char(Fare_start_timestamp,
         'DDMM') date_of_occurrence, to_number(to_char(Fare_start_timestamp,'HH24'))-1 start_hr, to_number(to_char(Fare_end_timestamp,'HH24'))+1 end_hr
            FROM cdot_dal.trips
            WHERE Fare_start_timestamp > '1-JAN-18'
                    AND Fare_start_timestamp < '1-JULY-18') t4
            USING (vin_no, date_of_occurrence)
            WHERE crash_hr >= start_hr
                    AND crash_hr<= end_hr ) table_all; 
