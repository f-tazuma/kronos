CREATE DATABASE kronos CHARACTER SET utf8;
CREATE DATABASE kronos_test CHARACTER SET utf8;

CREATE USER 'webapp'@'localhost';
GRANT ALL ON kronos.* TO webapp@'%' IDENTIFIED BY 'webappPwd';
GRANT ALL ON kronos_test.* TO webapp@'%' IDENTIFIED BY 'webappPwd';
