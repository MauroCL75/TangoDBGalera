# vim: filetype=mysql:

USE tango;

#
# Create entry for TangoRestServer device server in device table
#

DELETE FROM device WHERE server='TangoRestServer/rest';

INSERT INTO device VALUES ('sys/rest/0',NULL,'sys','rest','0',0,'nada','nada','TangoRestServer/rest',0,'TangoRestServer','nada',NULL,NULL,'nada');
INSERT INTO device VALUES ('dserver/TangoRestServer/rest',NULL,'dserver','TangoRestServer','rest',0,'nada','nada','TangoRestServer/rest',0,'DServer','nada',NULL,NULL,'nada');

#
# Update entries in the property_class tables for controlled access service
#

DELETE FROM property_class WHERE class='DServer' AND count >= 11;
INSERT INTO property_class VALUES('DServer','AllowedAccessCmd',11,'EventConfirmSubscription',NOW(),NOW(),NULL);
