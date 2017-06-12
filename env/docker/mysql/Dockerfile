# ベースイメージ
FROM mysql:5.7

MAINTAINER gaymin

## ENV設定
#ENV MYSQL_ROOT_USER root
#ENV MYSQL_ROOT_PASSWORD rootPwd

# 時刻設定
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime

# 設定ファイルコピー
COPY conf/my.cnf /etc/my.cnf

# 起動時実行SQL
COPY sql/*.sql /docker-entrypoint-initdb.d/
