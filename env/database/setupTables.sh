#!/bin/bash
# -----------------------------
# Attention
# Before execute this shell, make .my.cnf file at current directory for executing without password.
# -----------------------------

mysql --defaults-extra-file=.my.cnf -h 127.0.0.1 --port 13307 -u webapp kronos < kronos.sql
mysql --defaults-extra-file=.my.cnf -h 127.0.0.1 --port 13307 -u webapp kronos_test < kronos.sql