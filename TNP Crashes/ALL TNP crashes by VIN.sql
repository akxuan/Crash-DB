--TNP involved Crashes  by VIN
-- chris_dwh.ufe_tc_reports@cdot_dal_link
-- chris_dwh.ufe_tc_units_vehicles@cdot_dal_link
-- cdot_dal.trips

SELECT count (vin_no),
         count (distinct vin_no)
FROM 
    (SELECT DISTINCT vin_no,
         date_of_occurrence
    FROM 
        (SELECT traffic_crash_id report_id ,
         to_char(date_of_occurrence,
         'DDMM') date_of_occurrence, to_number(to_char(date_of_occurrence,'HH24') ) crash_hr
        FROM chris_dwh.ufe_tc_reports@cdot_dal_link
        WHERE date_of_occurrence > '1-JAN-18'
                AND date_of_occurrence < '1-JULY-18') t1
        INNER JOIN chris_dwh.ufe_tc_units_vehicles@cdot_dal_link t2
        USING (report_id)
        INNER JOIN 
            (SELECT vin vin_no,
         to_char(Fare_start_timestamp,
         'DDMM') date_of_occurrence, to_number(to_char(Fare_start_timestamp,'HH24'))-1 start_hr, to_number(to_char(Fare_end_timestamp,'HH24'))+1 end_hr
            FROM cdot_dal.trips
            WHERE Fare_start_timestamp > '1-JAN-18'
                    AND Fare_start_timestamp < '1-JULY-18') t3
            USING (vin_no, date_of_occurrence)
            WHERE crash_hr >= start_hr
                    AND crash_hr<= end_hr ) table_all; 
