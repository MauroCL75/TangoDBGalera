# vim: filetype=mysql:

USE tango;

#
# Table structure for table 'property_pipe_class'
#

CREATE TABLE IF NOT EXISTS property_pipe_class (
  class varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text default NULL,
  updated timestamp NOT NULL default '2000-01-01 00:00:00',
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_property_pipe_class (class(64),pipe(64),name(64),count)
) ENGINE=MyISAM;

#
# Table structure for table 'property_pipe_device'
#

CREATE TABLE IF NOT EXISTS property_pipe_device (
  device varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text default NULL,
  updated timestamp NOT NULL default '2000-01-01 00:00:00',
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_property_pipe_device (device(64),pipe(64),name(64),count)
) ENGINE=MyISAM;

#
# For history ID
#

CREATE TABLE IF NOT EXISTS device_pipe_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS class_pipe_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=MyISAM;

#
# History tables
#

CREATE TABLE IF NOT EXISTS property_pipe_class_hist (
  id bigint unsigned NOT NULL default '0',
  date timestamp NOT NULL default '2000-01-01 00:00:00',
  class varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text,
  KEY index_id (id),
  KEY index_class (class),
  KEY index_pipe (pipe),
  KEY index_name (name)  
) ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS property_pipe_device_hist (
  id bigint unsigned NOT NULL default '0',
  date timestamp NOT NULL default '2000-01-01 00:00:00',
  device varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text,
  KEY index_id (id),
  KEY index_device (device),
  KEY index_pipe (pipe),
  KEY index_name (name)  
) ENGINE=MyISAM;

#
# Load the new stored procedures
#

source stored_proc.sql

#
# Init new history ID
#

CALL init_history_ids();

#
# Update history id columns to support id on more than 32 bits
#

ALTER TABLE property_attribute_device_hist MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE property_attribute_class_hist MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE property_class_hist MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE property_device_hist MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE property_hist MODIFY id bigint unsigned NOT NULL default '0';

ALTER TABLE class_attribute_history_id MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE class_history_id MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE device_attribute_history_id MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE device_history_id MODIFY id bigint unsigned NOT NULL default '0';
ALTER TABLE object_history_id MODIFY id bigint unsigned NOT NULL default '0';

#
# Create entry for TangoRestServer device server in device table
#

DELETE FROM device WHERE server='TangoRestServer/rest';

INSERT INTO device VALUES ('sys/rest/0',NULL,'sys','rest','0',0,'nada','nada','TangoRestServer/rest',0,'TangoRestServer','nada',NULL,NULL,'nada');
INSERT INTO device VALUES ('dserver/TangoRestServer/rest',NULL,'dserver','TangoRestServer','rest',0,'nada','nada','TangoRestServer/rest',0,'DServer','nada',NULL,NULL,'nada');

#
# Create entries in the property_class tables for controlled access service
#

DELETE FROM property_class WHERE class='Database' AND count >= 32;

INSERT INTO property_class VALUES('Database','AllowedAccessCmd',32,'DbImportEvent',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',33,'DbGetDeviceAlias',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',34,'DbGetCSDbServerList',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',35,'DbGetDeviceClassList',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',36,'DbGetDeviceExportedList',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',37,'DbGetHostServerList',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',38,'DbGetAttributeAlias2',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',39,'DbGetAliasAttribute',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',40,'DbGetClassPipeProperty',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',41,'DbGetDevicePipeProperty',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',42,'DbGetClassPipeList',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',43,'DbGetDevicePipeList',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',44,'DbGetAttributeAliasList',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('Database','AllowedAccessCmd',45,'DbGetForwardedAttributeListForDevice',NOW(),NOW(),NULL);

DELETE FROM property_class WHERE class='DServer' AND count >= 10;
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',10,'ZMQEventSubscriptionChange',NOW(),NOW(),NULL);
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',11,'EventConfirmSubscription',NOW(),NOW(),NULL);

DELETE FROM property_class WHERE class='Starter' AND count >= 5;
INSERT INTO property_class VALUES('Starter','AllowedAccessCmd',5,'UpdateServerList',NOW(),NOW(),NULL);
