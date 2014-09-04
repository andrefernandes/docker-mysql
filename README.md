docker-mysql
============

CentOS 7 + Oracle MySQL Community

This is a MySQL image meant for general use. This work
is heavily based on the official MySQL image, but uses
a base CentOS image instead of Ubuntu.

Original work can be found at "https://github.com/docker-library/mysql".

CentOS and RHEL-based images might be a better fit
for RHEL shops.

### Useful scripts

* **build.sh** : builds the image locally (docker build);
* **runmysqld.sh** : convenient way to start MySQL on a named
daemon container (fast-food, auto-destroy);
* **runbash.sh** : convenient way to run commands on a new
container (fast-food, auto-destroy) or even to just
open a bash shell to play.

### How to use this image

#### start a MySQL instance

    docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -d andrefernandes/docker-mysql

This image includes EXPOSE 6379 (the mysql port), so standard container 
linking will make it automatically available to the linked containers 
(as the following examples illustrate).

#### start with persistent storage

Mounting the container VOLUME "/var/lib/mysql" on the "/opt/mysql-data" host folder:

    docker run --name some-mysql -v /opt/mysql-data:/var/lib/mysql -d andrefernandes/docker-mysql

Persistent data for VOLUME "/var/lib/mysql" can also be stored in a volume container,
which can be used with --volumes-from some-volume-container:

    docker run --name some-mysql-data -d -v /var/lib/mysql busybox echo "Data volume container for MySQL"
    docker run -d --volumes-from some-mysql-data --name some-mysql andrefernandes/docker-mysql

Using persistent data is an obvious need. You must decide whether to use host-mounted 
folders or volume containers. It it your call.

#### connect to it from an application

    docker run --name some-app --link some-mysql:mysql -t -i --rm application-that-uses-mysql

The above command starts a named container application that sees "some-mysql" container
with a "mysql" hostname. The exposed "some-mysql" ports are available to the application.

#### … or play with mysql client

    # starts mysql with our convenient script (creates named "mysql" container)
    ./runmysqld.sh
    # now start ANOTHER container, linked to "mysql", to run mysql client
    # yes, using the same image, why not?
    docker run -it --link mysql:mysql --rm andrefernandes/docker-mysql mysql -h mysql -ppassword

