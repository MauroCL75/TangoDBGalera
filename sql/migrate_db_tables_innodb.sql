# vim: filetype=mysql:

USE tango;

UPDATE access_address SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE access_address
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

UPDATE access_device SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE access_device
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

UPDATE attribute_alias SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE attribute_alias
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

UPDATE attribute_class SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE attribute_class
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

UPDATE device SET started=NULL WHERE started<'2000-01-01 00:00:00';
UPDATE device SET stopped=NULL WHERE stopped<'2000-01-01 00:00:00';
ALTER TABLE device
  CHANGE started started datetime NULL default NULL,
  CHANGE stopped stopped datetime NULL default NULL,
ENGINE=InnoDB;

UPDATE device SET started=NULL WHERE started<'2000-01-01 00:00:00';
UPDATE device SET stopped=NULL WHERE stopped<'2000-01-01 00:00:00';
ALTER TABLE event
  CHANGE started started datetime NULL default NULL,
  CHANGE stopped stopped datetime NULL default NULL,
ENGINE=InnoDB;

UPDATE property SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE property
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

UPDATE property_attribute_class SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE property_attribute_class
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

UPDATE property_attribute_device SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE property_attribute_device
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

UPDATE property_class SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE property_class
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

UPDATE property_device SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE property_device
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

UPDATE property_pipe_class SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE property_pipe_class
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

UPDATE property_pipe_device SET accessed='2000-01-01 00:00:00' WHERE accessed<'2000-01-01 00:00:00';
ALTER TABLE property_pipe_device
  CHANGE accessed accessed timestamp NOT NULL default '2000-01-01 00:00:00',
ENGINE=InnoDB;

ALTER TABLE server ENGINE=InnoDB;

ALTER TABLE device_history_id ENGINE=InnoDB;
ALTER TABLE device_attribute_history_id ENGINE=InnoDB;
ALTER TABLE device_pipe_history_id ENGINE=InnoDB;
ALTER TABLE class_history_id ENGINE=InnoDB;
ALTER TABLE class_attribute_history_id ENGINE=InnoDB;
ALTER TABLE class_pipe_history_id ENGINE=InnoDB;
ALTER TABLE object_history_id ENGINE=InnoDB;

ALTER TABLE property_hist
  DROP KEY index_id,
  DROP KEY index_object,
  DROP KEY index_name,
  ADD PRIMARY KEY (id, count),
  ADD INDEX object_name_date (object, name, date),
ENGINE=InnoDB;

ALTER TABLE property_device_hist
  DROP KEY index_id,
  DROP KEY index_device,
  DROP KEY index_name,
  ADD PRIMARY KEY (id, count),
  ADD INDEX device_name_date (device, name, date),
ENGINE=InnoDB;

ALTER TABLE property_class_hist
  DROP KEY index_id,
  DROP KEY index_class,
  DROP KEY index_name,
  ADD PRIMARY KEY (id, count),
  ADD INDEX class_name_date (class, name, date),
ENGINE=InnoDB;

ALTER TABLE property_attribute_class_hist
  DROP KEY index_id,
  DROP KEY index_class,
  DROP KEY index_attribute,
  DROP KEY index_name,
  ADD PRIMARY KEY (id, count),
  ADD INDEX class_attribute_name_date (class, attribute, name, date),
ENGINE=InnoDB;

ALTER TABLE property_attribute_device_hist
  DROP KEY index_id,
  DROP KEY index_device,
  DROP KEY index_attribute,
  DROP KEY index_name,
  ADD PRIMARY KEY (id, count),
  ADD KEY device_attribute_name_date (device, attribute, name, date),
ENGINE=InnoDB;

ALTER TABLE property_pipe_class_hist
  DROP KEY index_id,
  DROP KEY index_class,
  DROP KEY index_pipe,
  DROP KEY index_name,
  ADD PRIMARY KEY (id, count),
  ADD INDEX class_pipe_name_date (class, pipe, name, date),
ENGINE=InnoDB;

ALTER TABLE property_pipe_device_hist
  DROP KEY index_id,
  DROP KEY index_device,
  DROP KEY index_pipe,
  DROP KEY index_name,
  ADD PRIMARY KEY (id, count),
  ADD INDEX device_pipe_name_date (device, pipe, name, date),
ENGINE=InnoDB;
