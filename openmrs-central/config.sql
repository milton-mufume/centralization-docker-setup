INSERT INTO global_property (property,property_value,uuid)
VALUES ('debezium.engine.enabled', 'true', 'ace8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('debezium.mysql.history.file.filename', '/root/.OpenMRS/config/debezium/history.txt', 'bce8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('debezium.offset.storage.file.filename', '/root/.OpenMRS/config/debezium/offset.txt', 'cce8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('debezium.database.user', 'root', 'dce8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('debezium.database.password', 'root', 'ece8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.server.base.url', 'https://opencr:3000', '1be8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.keystore.path', '/root/.OpenMRS/mpi/config/openmrs.p12', '2be8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.keystore.password', 'changeit', '3be8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.keystore.type', 'PKCS12', '4be8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.relationship.type.personA.concept.mappings', '8d91a210-c2cc-11de-8d13-0010c6dffd0f:BP:Biological Patient,8d919b58-c2cc-11de-8d13-0010c6dffd0f:PD:Personal Doctor', '5be8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.relationship.type.personB.concept.mappings', '8d91a210-c2cc-11de-8d13-0010c6dffd0f:BC:Biological Child,8d919b58-c2cc-11de-8d13-0010c6dffd0f:P:Patient', '6be8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.patient.uuid.concept.map', 'OpenMRS_UUID:OpenMRS UUID', '7be8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.patient.health.center.url', 'http://openmrs.org/fhir/StructureDefinition/patient-healthCenter', '8be8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.person.uuid.url', 'http://openmrs.org/fhir/StructureDefinition/person-uuid', '9be8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.relationship.type.terminology.system.uri', 'http://relationship.type.concept', '0ce8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.identifier.type.terminology.system.uri', 'http://identifier.type.concept', '1ce8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.identifier.type.concept.mappings', '15a3fd64-1d5f-11e0-b929-000c29ad1d08:ND:The NID', '2ce8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.patient.uuid.system.uri', 'http://test.id.com/uuid', '3ce8f66d-98b8-4829-a5af-d063376cd5c1'),
       ('mpi.identifier.type.system.uri.mappings', '15a3fd64-1d5f-11e0-b929-000c29ad1d08^http://test.id.com/nid,8d79403a-c2cc-11de-8d13-0010c6dffd0f^http://test.id.com/openmrs-old-id', '4ce8f66d-98b8-4829-a5af-d063376cd5c1');

UPDATE global_property SET property_value = 'org.openmrs.api:info,org.openmrs.module.debezium:debug,org.openmrs.module.fgh.mpi:debug,io.debezium:info' WHERE property = 'log.level';
