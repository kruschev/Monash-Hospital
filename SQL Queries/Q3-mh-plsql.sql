/* FIT9132 2019 S1 Assignment 2 Q3 ANSWERS
   Student Name: Cong Son Huynh
    Student ID: 30377080

   Comments to your marker:
   
*/

/* (i)*/
create or replace trigger item_code 
after update of item_code on item
for each row
begin
    UPDATE ITEM_TREATMENT
        SET item_code = :new.item_code
        WHERE item_code = :old.item_code;
    dbms_output.put_line ('Related item codes in ITEM_TREATMENT have been updated');
end;
/

-- Test Harness
set serveroutput on
set echo on
-- Prior state
select * from item;
select * from item_treatment;

-- Test trigger 

update item set item_code = 'CE111' where item_code = 'CE001';

-- Post state
select * from item;
select * from item_treatment;

-- Undo changes
rollback;
set echo off;



/* (ii)*/
create or replace trigger prevent_blank 
before insert or update of patient_fname,patient_lname on patient
for each row
begin
    If :new.patient_fname is null And :new.patient_lname is null Then        
        raise_application_error(-20001, 'Patient first name and last name cannot be both blank');
    End If;
end;
/

-- Test Harness
set echo on

-- Test trigger 
-- Test Insert
insert into patient values(PATIENT_patient_id_SEQ.nextval,null,null,'12 Jane Doe Caulfield',to_date('04-Nov-1991','DD-MON-YYYY'),'0202020202');
rollback;

-- Test Update
update patient set patient_fname = null, patient_lname = null where patient_id > 200000;
rollback;

set echo off;





/* (iii)*/
create or replace trigger adjust_item_level 
after insert on item_treatment
for each row
begin
    UPDATE ITEM 
        SET item_stock = item_stock - :new.it_qty_used Where item_code = :new.item_code;
end;
/

--Test Harness
set echo on
-- Prior state
select * from item;
select * from item_treatment;

-- Test trigger 
insert into item_treatment values(106654,'NE001',1,3.45);

-- Post state
select * from item;
select * from item_treatment;

-- Undo changes
rollback;
set echo off;






