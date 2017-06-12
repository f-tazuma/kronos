CREATE DATABASE kronos CHARACTER SET utf8;

GRANT ALL ON kronos.* TO webapp@'%'  BY 'webappPwd';
GRANT ALL ON kronos.* TO webapp@'localhost';
