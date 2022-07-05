INSERT INTO patient_identifier_type (name,required,uniqueness_behavior,location_behavior,creator,date_created,uuid)
VALUES ('NID', 1, 'UNIQUE', 'NOT_USED', 1, now(), '15a3fd64-1d5f-11e0-b929-000c29ad1d08');

INSERT INTO person_attribute_type (name,format,creator,date_created,uuid)
VALUES ('Mobile Phone', 'java.lang.String', 1, now(), 'e2e3fd64-1d5f-11e0-b929-000c29ad1d07'),
       ('Home Phone', 'java.lang.String', 1, now(), 'e6c97a9d-a77b-401f-b06e-81900e21ed1d');

UPDATE global_property SET property_value = 'Mobile Phone,Home Phone' WHERE property = 'patient.viewingAttributeTypes';
