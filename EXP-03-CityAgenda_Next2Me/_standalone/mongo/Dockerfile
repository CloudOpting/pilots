FROM cloudopting/ubuntubase:14.04

MAINTAINER Xavier Cases Camats xavier.cases@worldline.com
ENV ADMIN_USER_NAME superAdmin
ENV ADMIN_USER_PASSWORD XxxXXXxxxX

ENV APP_DATABASE_NAME cloud4cities
ENV APP_USER_NAME cloud4cities
ENV APP_USER_PASSWORD koko1234

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates curl \
		numactl \
		supervisor \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/supervisor

# grab gosu for easy step-down from root
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.6/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.6/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys CEA1E18DDA77EF4E67884FF2A6982D0160456C5A

ENV MONGO_VERSION 2.4.14

RUN curl -SL "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-$MONGO_VERSION.tgz" -o mongo.tgz \
	&& curl -SL "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-$MONGO_VERSION.tgz.sig" -o mongo.tgz.sig \
	&& gpg --verify mongo.tgz.sig \
	&& tar -xvf mongo.tgz -C /usr/local --strip-components=1 \
	&& rm mongo.tgz*

RUN mkdir -p /data/db /data/configdb \
	&& chown -R mongodb:mongodb /data/db /data/configdb
VOLUME /data/db /data/configdb

# Initial loading script
RUN echo "#!/bin/bash" >> /initialScript.sh
RUN echo "if [[ -e /.firstrun ]]; then " >> /initialScript.sh
RUN echo "	RET=1" >> /initialScript.sh
RUN echo "	while [[ RET -ne 0 ]]; do" >> /initialScript.sh
RUN echo "    	sleep 20" >> /initialScript.sh
RUN echo "    	echo \"Test if database is down\"" >> /initialScript.sh
RUN echo "    	mongo admin --eval "help" >/dev/null 2>&1" >> /initialScript.sh
RUN echo "    	RET=$?" >> /initialScript.sh
RUN echo "	done" >> /initialScript.sh
RUN echo "	echo \"Database configuration\"" >> /initialScript.sh
# Create database users
RUN echo "	mongo admin --eval \"db.addUser({ user: '${ADMIN_USER_NAME}', pwd: '${ADMIN_USER_PASSWORD}', roles: [ 'clusterAdmin', 'dbAdminAnyDatabase', 'readWriteAnyDatabase','userAdminAnyDatabase' ] }); \"" >> /initialScript.sh
RUN echo "	mongo ${APP_DATABASE_NAME} --authenticationDatabase admin -u ${ADMIN_USER_NAME} -p ${ADMIN_USER_PASSWORD} --eval \"db.addUser({ user: '${APP_USER_NAME}', pwd: '${APP_USER_PASSWORD}', roles: [ 'readWrite' ] }); \"" >> /initialScript.sh

# Load some data from files on /dataImport dir... file pattern <database>.<collection>.json

RUN echo "	for jsonFile in /dataImport/*.json" >> /initialScript.sh
RUN echo "	do" >> /initialScript.sh
RUN echo "		echo \"Processing $jsonFile file...\"" >> /initialScript.sh
RUN echo "		jsonFile=\$(basename \$jsonFile)" >> /initialScript.sh
RUN echo "		IFS='.' read -r -a array <<< \$jsonFile  " >> /initialScript.sh
RUN echo "		echo \"\${array[0]}  \${array[1]}\" " >> /initialScript.sh
RUN echo "		mongoimport  -authenticationDatabase admin -u ${ADMIN_USER_NAME} -p ${ADMIN_USER_PASSWORD} -d \${array[0]} --drop -c \${array[1]} < /dataImport/\${jsonFile}" >> /initialScript.sh
 
RUN echo "	done" >> /initialScript.sh

# End Load some data
RUN echo "	rm -f /.firstrun" >> /initialScript.sh
RUN echo "fi" >> /initialScript.sh
		 
RUN chmod 0755 /initialScript.sh

#COPY Data files

COPY data /dataImport

RUN touch /.firstrun

#supervisor configuration file
RUN echo "[supervisord]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "nodaemon=true" >> /etc/supervisor/conf.d/supervisord.conf

RUN echo "[program:mongod]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "command=/usr/local/bin/mongod --smallfiles --directoryperdb --auth" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "stdout_logfile=/dev/stdout" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "stdout_logfile_maxbytes=0" >> /etc/supervisor/conf.d/supervisord.conf


RUN echo "[program:initialScript]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "command=/initialScript.sh" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "startsecs=10" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "stdout_logfile=/dev/stdout" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "stdout_logfile_maxbytes=0" >> /etc/supervisor/conf.d/supervisord.conf

EXPOSE  27017

CMD ["/usr/bin/supervisord"]
