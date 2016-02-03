FROM cloudopting/ubuntubase:14.04

MAINTAINER Xavier Cases Camats xavier.cases@worldline.com

#Environment variables
WORKDIR /worldline/mongo-cloud4cities/data

#Add configuration
ADD db /data/db

#
# PUPPET MODULES
#

#Install latest compatible version
RUN puppet module install puppetlabs-mongodb

#Adding the puppet manifest and executing it.
ADD Manifest.pp /tmp/Manifest.pp
RUN puppet apply /tmp/Manifest.pp

EXPOSE 27017

CMD ["mongod --smallfiles --directoryperdb --auth"]
