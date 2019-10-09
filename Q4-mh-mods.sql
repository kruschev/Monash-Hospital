/* FIT9132 2019 S1 Assignment 2 Q4 ANSWERS
   Student Name: Cong Son Huynh
    Student ID: 30377080

   Comments to your marker:
   
*/
/* (i)*/
Alter table ITEM
    Add (item_reorder_level number(3));

Update
    ITEM
Set
    item_reorder_level = round(item_stock/2, 0);

Alter table ITEM
    Modify (item_reorder_level not null);

COMMENT ON COLUMN item.item_reorder_level IS
    'Reorder stock level for this item';



  
/* (ii)*/
CREATE TABLE DOCTOR_ANCILLARY (
    adprc_no             NUMBER(7) NOT NULL,
    ancillary_dr_id      NUMBER(4) NOT NULL);

COMMENT ON COLUMN doctor_ancillary.adprc_no IS
    'Admission procedure identifier (PK)';

COMMENT ON COLUMN doctor_ancillary.ancillary_dr_id IS
    'Ancillary (Assisting) Doctor ID (PK)';

ALTER TABLE DOCTOR_ANCILLARY ADD CONSTRAINT doctor_ancillary_pk PRIMARY KEY (adprc_no, ancillary_dr_id);

ALTER TABLE DOCTOR_ANCILLARY
    ADD CONSTRAINT adprc_doctorancil FOREIGN KEY ( adprc_no )
        REFERENCES adm_prc ( adprc_no );

ALTER TABLE DOCTOR_ANCILLARY
    ADD CONSTRAINT doctor_doctorancil FOREIGN KEY ( ancillary_dr_id )
        REFERENCES doctor ( doctor_id );

ALTER TABLE ADM_PRC RENAME COLUMN PERFORM_DR_ID TO LEAD_DR_ID;

Insert into DOCTOR_ANCILLARY (ADPRC_NO,ANCILLARY_DR_ID) values (106654,1084);



commit;

