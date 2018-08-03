-- select Taxi involved Crashes SQL:
SELECT count (vin_no) num_crash,
         count (distinct vin_no) num_vin
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
        INNER JOIN 
            (SELECT *
            FROM chris_dwh.ufe_tc_units_vehicles@cdot_dal_link
            WHERE lic_plate_no LIKE '%TX' ) t2
            USING (report_id) ) table_all; 
            
            
-- select taxi fault crashes SQL
SELECT count (vin_no) num_crash,
         count (distinct vin_no) num_vin
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
        INNER JOIN 
            (SELECT *
            FROM chris_dwh.ufe_tc_units_vehicles@cdot_dal_link
            WHERE unit_no = 1
                    AND lic_plate_no LIKE '%TX' ) t2
            USING (report_id) ) table_all; 
