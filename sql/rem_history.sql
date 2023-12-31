# vim: filetype=mysql:

USE tango;

#
# Update all history ids to 0
#

UPDATE class_attribute_history_id SET id=0;
UPDATE class_history_id SET id=0;
UPDATE class_pipe_history_id SET id=0;
UPDATE device_attribute_history_id SET id=0;
UPDATE device_history_id SET id=0;
UPDATE device_pipe_history_id SET id=0;
UPDATE object_history_id SET id=0;

#
# Clean up history tables
#

DELETE FROM property_attribute_class_hist;
DELETE FROM property_attribute_device_hist;
DELETE FROM property_class_hist;
DELETE FROM property_device_hist;
DELETE FROM property_hist;
DELETE FROM property_pipe_class_hist;
DELETE FROM property_pipe_device_hist;
