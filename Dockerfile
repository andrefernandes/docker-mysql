# CentOS 7 with MySQL

FROM andrefernandes/docker-centos7-base

MAINTAINER Andre Fernandes

RUN groupadd -r mysql && useradd -r -g mysql mysql

# installs from mysql public repo
RUN wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm -d && \
    yum localinstall mysql-community-release-el7-5.noarch.rpm -y && \
    yum install mysql-community-server -y && \
    rm mysql-community-release-el7-5.noarch.rpm && \
    yum clean all

ENV PATH $PATH:/usr/local/mysql/bin:/usr/local/mysql/scripts

WORKDIR /usr/local/mysql
VOLUME /var/lib/mysql

ADD docker-entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["/entrypoint.sh","mysqld", "--datadir=/var/lib/mysql", "--user=mysql"]

