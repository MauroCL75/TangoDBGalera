create database if not exists tango;
create user 'tango'@'%' identified by 'changeme';
--create user 'haproxy'@'%';
GRANT ALL PRIVILEGES ON tango.* to 'tango'@'%';
flush privileges;
