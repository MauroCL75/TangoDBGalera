# vim: filetype=mysql:

USE tango;

#
# Create all database tables not already created
#

source create_db_tables.sql

#
# Create some temporary stored procedure
#

DROP PROCEDURE IF EXISTS tango.upd_server;
DROP PROCEDURE IF EXISTS tango.upd_device;
DROP PROCEDURE IF EXISTS tango.upd_access_address;
DROP PROCEDURE IF EXISTS tango.upd_access_device;
DROP PROCEDURE IF EXISTS tango.upd_history_ids;

delimiter |

CREATE PROCEDURE tango.upd_server (IN obj_name VARCHAR(255))
BEGIN
	DECLARE nb_val INT DEFAULT 0;

	SELECT count(*)
	INTO nb_val
	FROM tango.server
	WHERE name = obj_name;

	IF nb_val = 0
	THEN
		INSERT INTO server VALUES (obj_name,'',1,1);
	END IF;
END |

CREATE PROCEDURE tango.upd_device (IN obj_name VARCHAR(255),IN domain VARCHAR(85),IN family VARCHAR(85),IN memb VARCHAR(85),IN server VARCHAR(255),IN class VARCHAR(255))
BEGIN
	DECLARE nb_val INT DEFAULT 0;

	SELECT count(*)
	INTO nb_val
	FROM tango.device
	WHERE name = obj_name;

	IF nb_val = 0
	THEN
		INSERT INTO device VALUES (obj_name,NULL,domain,family,memb,'nada','nada','nada',server,'nada',class,'nada','nada','nada','nada');
	END IF;
END |

CREATE PROCEDURE tango.upd_access_address ()
BEGIN
	DECLARE nb_val INT DEFAULT 0;

	SELECT count(*)
	INTO nb_val
	FROM tango.access_address
	WHERE user = '*';

	IF nb_val = 0
	THEN
		INSERT INTO access_address VALUES ('*','*.*.*.*','FF.FF.FF.FF',20060824131221,00000000000000);
	END IF;
END |

CREATE PROCEDURE tango.upd_access_device ()
BEGIN
	DECLARE nb_val INT DEFAULT 0;

	SELECT count(*)
	INTO nb_val
	FROM tango.access_device
	WHERE user = '*';

	IF nb_val = 0
	THEN
		INSERT INTO access_device VALUES ('*','*/*/*','write',20060824131221,00000000000000);
	END IF;
END |

CREATE PROCEDURE tango.upd_history_ids ()
BEGIN
	DECLARE table_defined INT DEFAULT 0;
	DECLARE id_val INT DEFAULT -1;
	
	SELECT count(*)
	INTO table_defined
	FROM information_schema.tables
	WHERE table_schema = 'tango' AND table_name = 'history_ids';

	IF table_defined = 1
	THEN
		SELECT id
		INTO id_val
		FROM device_history_id;

		IF id_val < 1
		THEN
			TRUNCATE TABLE device_history_id;
			INSERT INTO device_history_id SELECT id from history_ids WHERE name='device';
		END IF;

		SET id_val = -1;
		SELECT id
		INTO id_val
		FROM device_attribute_history_id;

		IF id_val < 1
		THEN
			TRUNCATE TABLE device_attribute_history_id;
			INSERT INTO device_attribute_history_id SELECT id from history_ids WHERE name='device_attribute';
		END IF;

		SET id_val = -1;
		SELECT id
		INTO id_val
		FROM class_history_id;

		IF id_val < 1
		THEN
			TRUNCATE TABLE class_history_id;
			INSERT INTO class_history_id SELECT id from history_ids WHERE name='class';
		END IF;

		SET id_val = -1;
		SELECT id
		INTO id_val
		FROM class_attribute_history_id;

		IF id_val < 1
		THEN
			TRUNCATE TABLE class_attribute_history_id;
			INSERT INTO class_attribute_history_id SELECT id from history_ids WHERE name='class_attribute';
		END IF;

		SET id_val = -1;
		SELECT id
		INTO id_val
		FROM object_history_id;

		IF id_val < 1
		THEN
			TRUNCATE TABLE object_history_id;
			INSERT INTO object_history_id SELECT id from history_ids WHERE name='object';
		END IF;
	END IF;
END |

delimiter ;

#
# Init the new history identifier tables from the old history_ids table
#

CALL tango.upd_history_ids();

#
# Be sure to have the device table correctly defined
#

ALTER TABLE device CHANGE alias alias VARCHAR(255) default NULL;

#
# Create entry for Tango Control Access in device table
#

CALL tango.upd_device('sys/access_control/1','sys','access_control','1','TangoAccessControl/1','TangoAccessControl');
CALL tango.upd_device('dserver/TangoAccessControl/1','dserver','TangoAccessControl','1','TangoAccessControl/1','DServer');
CALL tango.upd_server('tangoaccesscontrol/1');

#
# Create default user access
#

CALL tango.upd_access_address();
CALL tango.upd_access_device();

#
# Create entries in the property_class tables for controlled access service
#

DELETE FROM property_class WHERE class = 'Database' and name = 'AllowedAccessCmd';

INSERT INTO property_class VALUES('Database','AllowedAccessCmd',1,'DbGetServerInfo',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',2,'DbGetServerNameList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',3,'DbGetInstanceNameList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',4,'DbGetDeviceServerClassList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',5,'DbGetDeviceList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',6,'DbGetDeviceDomainList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',7,'DbGetDeviceFamilyList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',8,'DbGetDeviceMemberList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',9,'DbGetClassList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',10,'DbGetDeviceAliasList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',11,'DbGetObjectList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',12,'DbGetPropertyList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',13,'DbGetProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',14,'DbGetClassPropertyList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',15,'DbGetClassProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',16,'DbGetDevicePropertyList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',17,'DbGetDeviceProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',18,'DbGetClassAttributeList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',19,'DbGetDeviceAttributeProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',20,'DbGetDeviceAttributeProperty2',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',21,'DbGetLoggingLevel',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',22,'DbGetAliasDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',23,'DbGetClassForDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',24,'DbGetClassInheritanceForDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',25,'DbGetDataForServerCache',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',26,'DbInfo',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',27,'DbGetClassAttributeProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',28,'DbGetClassAttributeProperty2',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',29,'DbMysqlSelect',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',30,'DbGetDeviceInfo',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',31,'DbGetDeviceWideList',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',32,'DbImportEvent',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',33,'DbGetDeviceAlias',NULL,NULL,NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',34,'DbGetCSDbServerList',NULL,NULL,NULL);

#
#
#

DELETE FROM property_class WHERE class = 'DServer' and name = 'AllowedAccessCmd';

INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',1,'QueryClass',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',2,'QueryDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',3,'EventSubscriptionChange',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',4,'DevPollStatus',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',5,'GetLoggingLevel',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',6,'GetLoggingTarget',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',7,'QueryWizardDevProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',8,'QueryWizardClassProperty',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',9,'QuerySubDevice',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',10,'ZMQEventSubscriptionChange',NULL,NULL,NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',11,'EventConfirmSubscription',NULL,NULL,NULL);

#
#
#

DELETE FROM property_class WHERE class = 'Starter' and name = 'AllowedAccessCmd';

INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',1,'DevReadLog',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',2,'DevStart',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',3,'DevGetRunningServers',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',4,'DevGetStopServers',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('Starter','AllowedAccessCmd',5,'UpdateServerList',NULL,NULL,NULL);

#
#
#

DELETE FROM property_class WHERE class = 'TangoAccessControl' and name = 'AllowedAccessCmd';

INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',1,'GetUsers',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',2,'GetAddressByUser',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',3,'GetDeviceByUser',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',4,'GetAccess',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',5,'GetAllowedCommands',NULL,NULL,NULL);
INSERT INTO property_class VALUES ('TangoAccessControl','AllowedAccessCmd',6,'GetAllowedCommandClassList',NULL,NULL,NULL);

#
# Delete the temporary stored procedure
#

DROP PROCEDURE IF EXISTS tango.upd_server;
DROP PROCEDURE IF EXISTS tango.upd_device;
DROP PROCEDURE IF EXISTS tango.upd_access_address;
DROP PROCEDURE IF EXISTS tango.upd_access_device;
DROP PROCEDURE IF EXISTS tango.upd_history_ids;

#
# Load the real stored procedures
#

source stored_proc.sql

#
# Create entry for TangoRestServer device server in device table
#

DELETE FROM device WHERE server='TangoRestServer/rest';

INSERT INTO device VALUES ('sys/rest/0',NULL,'sys','rest','0',0,'nada','nada','TangoRestServer/rest',0,'TangoRestServer','nada',NULL,NULL,'nada');
INSERT INTO device VALUES ('dserver/TangoRestServer/rest',NULL,'dserver','TangoRestServer','rest',0,'nada','nada','TangoRestServer/rest',0,'DServer','nada',NULL,NULL,'nada');
