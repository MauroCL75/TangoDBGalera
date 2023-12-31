# vim: filetype=mysql:

#
# Table structure for table 'access_address'
#

CREATE TABLE IF NOT EXISTS access_address (
  user varchar(255) default NULL,
  address varchar(255) default NULL,
  netmask varchar(255) default 'FF.FF.FF.FF',
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00'
) ENGINE=InnoDB;

#
# Table structure for table 'access_device'
#

CREATE TABLE IF NOT EXISTS access_device (
  user varchar(255) default NULL,
  device varchar(255) default NULL,
  rights varchar(255) default NULL,
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00'
) ENGINE=InnoDB;

#
# Table structure for table 'attribute_alias'
#

CREATE TABLE IF NOT EXISTS attribute_alias (
  alias varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  device varchar(255) NOT NULL default '',
  attribute varchar(255) NOT NULL default '',
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_attribute_alias (alias(64),name(64))
) ENGINE=InnoDB;

#
# Table structure for table 'attribute_class'
#

CREATE TABLE IF NOT EXISTS attribute_class (
  class varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_attribute_class (class(64),name(64))
) ENGINE=InnoDB;

#
# Table structure for table 'device'
#

CREATE TABLE IF NOT EXISTS device (
  name varchar(255) NOT NULL default 'nada',
  alias varchar(255) default NULL,
  domain varchar(85) NOT NULL default 'nada',
  family varchar(85) NOT NULL default 'nada',
  member varchar(85) NOT NULL default 'nada',
  exported int(11) default 0,
  ior text,
  host varchar(255) NOT NULL default 'nada',
  server varchar(255) NOT NULL default 'nada',
  pid int(11) default 0,
  class varchar(255) NOT NULL default 'nada',
  version varchar(8) NOT NULL default 'nada',
  started datetime NULL default NULL,
  stopped datetime NULL default NULL,
  comment text,
  KEY name (name(64),alias(64))
) ENGINE=InnoDB;

#
# Table structure for table 'event'
#

CREATE TABLE IF NOT EXISTS event (
  name varchar(255) default NULL,
  exported int(11) default NULL,
  ior text,
  host varchar(255) default NULL,
  server varchar(255) default NULL,
  pid int(11) default NULL,
  version varchar(8) default NULL,
  started datetime NULL default NULL,
  stopped datetime NULL default NULL,
  KEY index_name (name(64))
) ENGINE=InnoDB;

#
# Table structure for table 'property'
#

CREATE TABLE IF NOT EXISTS property (
  object varchar(255) default NULL,
  name varchar(255) default NULL,
  count int(11) default NULL,
  value text default NULL,
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_name (object(64),name(64))
) ENGINE=InnoDB;

#
# Table structure for table 'property_attribute_class'
#

CREATE TABLE IF NOT EXISTS property_attribute_class (
  class varchar(255) NOT NULL default '',
  attribute varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text default NULL,
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_property_attribute_class (class(64),attribute(64),name(64),count)
) ENGINE=InnoDB;

#
# Table structure for table 'property_attribute_device'
#

CREATE TABLE IF NOT EXISTS property_attribute_device (
  device varchar(255) NOT NULL default '',
  attribute varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text default NULL,
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_property_attribute_device (device(64),attribute(64),name(64),count)
) ENGINE=InnoDB;

#
# Table structure for table 'property_class'
#

CREATE TABLE IF NOT EXISTS property_class (
  class varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text default NULL,
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_property (class(64),name(64),count)
) ENGINE=InnoDB;

#
# Table structure for table 'property_device'
#

CREATE TABLE IF NOT EXISTS property_device (
  device varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  domain varchar(255) NOT NULL default '',
  family varchar(255) NOT NULL default '',
  member varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text default NULL,
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_resource (device(64),name(64),count)
) ENGINE=InnoDB;

#
# Table structure for table 'property_pipe_class'
#

CREATE TABLE IF NOT EXISTS property_pipe_class (
  class varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text default NULL,
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_property_pipe_class (class(64),pipe(64),name(64),count)
) ENGINE=InnoDB;

#
# Table structure for table 'property_pipe_device'
#

CREATE TABLE IF NOT EXISTS property_pipe_device (
  device varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text default NULL,
  updated timestamp NOT NULL,
  accessed timestamp NOT NULL default '2000-01-01 00:00:00',
  comment text,
  KEY index_property_pipe_device (device(64),pipe(64),name(64),count)
) ENGINE=InnoDB;

#
# Table structure for table 'server'
#

CREATE TABLE IF NOT EXISTS server (
  name varchar(255) NOT NULL default '',
  host varchar(255) NOT NULL default '',
  mode int(11) default '0',
  level int(11) default '0',
  KEY index_name (name(64))
) ENGINE=InnoDB;

#
# Tables for history identifiers
#

CREATE TABLE IF NOT EXISTS device_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS device_attribute_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS device_pipe_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS class_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS class_attribute_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS class_pipe_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS object_history_id (
  id bigint unsigned NOT NULL default '0'
) ENGINE=InnoDB;

#
# Tables for history
#

CREATE TABLE IF NOT EXISTS property_hist (
  id bigint unsigned NOT NULL default '0',
  date timestamp NOT NULL,
  object varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text,
  PRIMARY KEY (id, count),
  INDEX object_name (object, name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS property_device_hist (
  id bigint unsigned NOT NULL default '0',
  date timestamp NOT NULL,
  device varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text,
  PRIMARY KEY (id, count),
  INDEX device_name (device, name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS property_class_hist (
  id bigint unsigned NOT NULL default '0',
  date timestamp NOT NULL,
  class varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text,
  PRIMARY KEY (id, count),
  INDEX class_name (class, name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS property_attribute_class_hist (
  id bigint unsigned NOT NULL default '0',
  date timestamp NOT NULL,
  class varchar(255) NOT NULL default '',
  attribute varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text,
  PRIMARY KEY (id, count),
  INDEX class_attribute_name (class, attribute, name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS property_attribute_device_hist (
  id bigint unsigned NOT NULL default '0',
  count int(11) NOT NULL default '0',
  date timestamp NOT NULL,
  device varchar(255) NOT NULL default '',
  attribute varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  value text,
  PRIMARY KEY (id, count),
  INDEX device_attribute_name (device, attribute, name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS property_pipe_class_hist (
  id bigint unsigned NOT NULL default '0',
  date timestamp NOT NULL,
  class varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text,
  PRIMARY KEY (id, count),
  INDEX class_pipe_name (class, pipe, name)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS property_pipe_device_hist (
  id bigint unsigned NOT NULL default '0',
  date timestamp NOT NULL,
  device varchar(255) NOT NULL default '',
  pipe varchar(255) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  count int(11) NOT NULL default '0',
  value text,
  PRIMARY KEY (id, count),
  INDEX device_pipe_name (device, pipe, name)
) ENGINE=InnoDB;
