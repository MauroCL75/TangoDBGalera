# vim: filetype=mysql:

USE tango;

#
# Create entries in the property_class tables for controlled access service
#

DELETE from property_class where value='DbGetClasProperty' and class='Database';
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',15,'DbGetClassProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',29,'DbMysqlSelect',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',30,'DbGetDeviceInfo',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',31,'DbGetDeviceWideList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',32,'DbImportEvent',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',33,'DbGetDeviceAlias',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',34,'DbGetCSDbServerList',NULL,NULL,NULL);

#
#
#

INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',9,'QuerySubDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',10,'ZMQEventSubscriptionChange',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',11,'EventConfirmSubscription',NULL,NULL,NULL);

#
#
#

DELETE from property_class where name='AllowedAccessCmd' and class='Starter';

INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',1,'DevReadLog',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',2,'DevStart',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',3,'DevGetRunningServers',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',4,'DevGetStopServers',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',5,'UpdateServerList',NULL,NULL,NULL);

#
#
#

INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',5,'GetAllowedCommands',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',6,'GetAllowedCommandClassList',NULL,NULL,NULL);

#
# Update  the stored procedure
#

source stored_proc.sql

#
# Create entry for TangoRestServer device server in device table
#

DELETE FROM device WHERE server='TangoRestServer/rest';

INSERT INTO device VALUES ('sys/rest/0',NULL,'sys','rest','0',0,'nada','nada','TangoRestServer/rest',0,'TangoRestServer','nada',NULL,NULL,'nada');
INSERT INTO device VALUES ('dserver/TangoRestServer/rest',NULL,'dserver','TangoRestServer','rest',0,'nada','nada','TangoRestServer/rest',0,'DServer','nada',NULL,NULL,'nada');
