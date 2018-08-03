-- select * from cdot_dal.TNP_vehicles; -- TNPvechile plate number 
SELECT count (vin_no),
         count (distinct vin_no)
    (SELECT DISTINCT LIC_plate_NO,
         date_of_occurrence
    FROM 
        (SELECT traffic_crash_id report_id ,
         to_char(date_of_occurrence,
        'DDMM') date_of_occurrence, to_number(to_char(date_of_occurrence,'HH24')) crash_hr
        FROM chris_dwh.ufe_tc_reports@cdot_dal_link
        WHERE date_of_occurrence > '1-JAN-18'
                AND date_of_occurrence < '1-JULY-18') t1 --SELECT report id by time
        INNER JOIN 
            (SELECT LIC_plate_NO,
         report_ID
            FROM chris_dwh.ufe_tc_units_vehicles@cdot_dal_link ) t2 --SELECT unite
            WITH plant number
            USING (report_id)
            INNER JOIN 
                (SELECT license_plate_number LIC_plate_NO
                FROM cdot_dal.TNP_vehicles) t3
                USING (LIC_plate_NO); ) all_table 
