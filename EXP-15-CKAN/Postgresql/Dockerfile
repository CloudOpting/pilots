# Use base
FROM cloudopting/ubuntubase:14.04
MAINTAINER

# OPTIONAL:

### Specific application stuff
RUN git clone https://github.com/someorg/somerepo
RUN apt-get -yq update && apt-get install -y some-packages

### Cleaning
RUN apt-get clean && rm -rf /var/lib/apt /var/cache/apt/archives/* /tmp/*


# MANDATORY IF YOU WANT TO APPLY A PUPPET MANIFEST:
### Add puppet modules
ADD modules /tmp/modules

### Add manifest to apply
ADD images/apache/manifest.pp /tmp/manifest.pp

### Apply manifest
RUN puppet apply --modulepath=/tmp/modules /tmp/manifest.p
