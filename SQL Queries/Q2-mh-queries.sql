/* FIT9132 2019 S1 Assignment 2 Q2 ANSWERS
   Student Name: Cong Son Huynh
    Student ID: 30377080

   Comments to your marker:
   
*/

/* (i)*/
Select 
    doctor_title, doctor_fname, doctor_lname, doctor_phone
From
    DOCTOR
Where
    doctor_id in 
        (Select doctor_id From DOCTOR_SPECIALITY Where spec_code in 
            (Select spec_code From SPECIALITY Where lower(spec_description) = lower('ORTHOPEDIC SURGERY')))
Order by
    doctor_lname,
    doctor_fname;






/* (ii)*/
Select
    item_code, item_description, item_stock, item_cost, cc_code
From
    ITEM
Where
    item_stock > 50
    and
    lower(item_description) like '%disposable%'
Order by
    item_code;






    
/* (iii)*/
Select 
    p.patient_id, p.patient_fname ||' '|| p.patient_lname as "Patient name", adm.adm_date_time, d.doctor_title ||' '|| d.doctor_fname ||' '|| d.doctor_lname as "Doctor name"
From
    PATIENT p
    Join ADMISSION adm
        on p.patient_id = adm.patient_id
    Join DOCTOR d
        on adm.doctor_id = d.doctor_id
Where
    to_char(adm.adm_date_time, 'dd-MON-YYYY') like '14-MAR-2019%'
Order by
    adm.adm_date_time;





/* (iv)*/
Select 
    proc_code, proc_name, proc_description, '$'||to_char(proc_std_cost, 'fm9999990.00') as "Standard cost"
From
    PROCEDURE
Where
    proc_std_cost < (Select avg(proc_std_cost) From PROCEDURE)
Order by
    proc_std_cost desc;




 
/* (v)*/
Select 
    p.patient_id, p.patient_fname, p.patient_lname, p.patient_dob, count(adm.patient_id) as "NUMBERADMISSIONS"
From
    PATIENT p
    Join ADMISSION adm
        on adm.patient_id = p.patient_id
Group by
    p.patient_id, p.patient_fname, p.patient_lname, p.patient_dob
Having
    count(adm.patient_id) > 2
Order by
    p.patient_dob;



    
/* (vi)*/
Select 
    adm.adm_no, adm.patient_id, p.patient_fname, p.patient_lname, floor(adm.adm_discharge - adm.adm_date_time)||' days ' ||round(((adm.adm_discharge - adm.adm_date_time) - floor(adm.adm_discharge - adm.adm_date_time))*24, 1)||' hours ' as "STAYLENGTH"
From
    ADMISSION adm
    Join PATIENT p
        on adm.patient_id = p.patient_id
Where
    adm.adm_discharge is not NULL
    and
    adm.adm_discharge - adm.adm_date_time > 
        (Select avg(adm_discharge - adm_date_time) From ADMISSION Where adm_discharge is not NULL);
        


    
/* (vii)*/
Select
    pr.proc_code, pr.proc_name, pr.proc_description, pr.proc_time, pr.proc_std_cost - avg(apr.adprc_pat_cost) as "Price Differential"
From
    ADM_PRC apr
    Join PROCEDURE pr
        on apr.proc_code = pr.proc_code
Group by
    pr.proc_code, pr.proc_name, pr.proc_description, pr.proc_time, pr.proc_std_cost
Order by
    pr.proc_code;





    
/* (viii)*/
Select
    pr.proc_code, pr.proc_name, nvl(i.item_code,'---'), nvl(i.item_description,'---'), nvl(to_char(max(it.it_qty_used)),'---') as "MAX_QTY_USED"
From
    PROCEDURE pr
    Left Join ADM_PRC apr
        on pr.proc_code = apr.proc_code
    Left Join ITEM_TREATMENT it
        on apr.adprc_no = it.adprc_no
    Left Join ITEM i
        on it.item_code = i.item_code
Group by
    pr.proc_code, pr.proc_name, i.item_code, i.item_description
Order by
    pr.proc_name;

commit;




