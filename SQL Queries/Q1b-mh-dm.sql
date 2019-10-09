/* FIT9132 2019 S1 Assignment 2 Q1-Part B ANSWERS
   Student Name: Cong Son Huynh
    Student ID: 30377080

   Comments to your marker:
   
*/

/* (i)*/
CREATE SEQUENCE PATIENT_patient_id_SEQ START WITH 200000 INCREMENT BY 10;
CREATE SEQUENCE ADMISSION_adm_no_SEQ START WITH 200000 INCREMENT BY 10;
CREATE SEQUENCE ADM_PRC_adprc_no_SEQ START WITH 200000 INCREMENT BY 10;





/* (ii)*/
Insert into PATIENT (PATIENT_ID,PATIENT_FNAME,PATIENT_LNAME,PATIENT_ADDRESS,PATIENT_DOB,PATIENT_CONTACT_PHN) values (PATIENT_patient_id_SEQ.nextval,'Peter','Xiue','14 Narrow Lane Caulfield',to_date('01-Oct-1981','DD-MON-YYYY'),'0123456789');

Insert into ADMISSION (ADM_NO,ADM_DATE_TIME,ADM_DISCHARGE,PATIENT_ID,DOCTOR_ID)
Select 
    ADMISSION_adm_no_SEQ.nextval,to_date('16-May-2019 10:00','DD-MON-YYYY HH24:MI'),null,PATIENT_patient_id_SEQ.currval,DOCTOR_ID
From 
    DOCTOR
Where
    DOCTOR_FNAME='Sawyer'
    and
    DOCTOR_LNAME='Haisell';






/* (iii)*/
Update 
    DOCTOR_SPECIALITY 
Set 
    spec_code = (Select spec_code From SPECIALITY Where spec_description = 'Vascular surgery')
Where
    doctor_id in (Select doctor_id From DOCTOR Where doctor_fname = 'Decca' and doctor_lname = 'Blankhorn')
    and
    spec_code in (Select spec_code From SPECIALITY Where spec_description = 'Thoracic surgery');




      
/* (iv)*/
Delete From 
    DOCTOR_SPECIALITY 
Where 
    spec_code in (Select spec_code From SPECIALITY Where spec_description = 'Medical genetics');

Delete From
    SPECIALITY
Where
    spec_description = 'Medical genetics';


commit;






