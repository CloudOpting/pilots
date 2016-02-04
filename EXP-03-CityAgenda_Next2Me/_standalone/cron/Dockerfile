FROM cloudopting/ubuntubase:14.04

MAINTAINER Xavier Cases Camats xavier.cases@worldline.com

#Environment variables
WORKDIR 

#
# PUPPET MODULES
#

#Install latest compatible version
RUN puppet module install puppetlabs-

#Adding the puppet manifest and executing it.
ADD Manifest.pp /tmp/Manifest.pp
RUN puppet apply /tmp/Manifest.pp



CMD [""]
