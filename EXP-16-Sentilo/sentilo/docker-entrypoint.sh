#!/bin/bash


# mongo startup config if directory is empty
if ! [ "$(ls -A /mongodb)" ]; then 

    # this is SQL dump for mysql
    mv /2-agent_mysql.sql /docker-entrypoint-init.db.d/

    chown -R mongodb:mongodb /mongodb
    /usr/bin/mongod --smallfiles --dbpath /mongodb &
    sleep 1 # time for mongo server start

    # insert data
    mongo < /create-sentilo-user.js
    mongo -u sentilo -p sentilo sentilo /opt/sentilo/scripts/mongodb/init_data.js
    mongo -u sentilo -p sentilo sentilo /opt/sentilo/scripts/mongodb/init_test_data.js

    /usr/bin/mongod --shutdown --dbpath /mongodb &

fi

exec /usr/bin/supervisord
