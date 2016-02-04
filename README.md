# TOSCA definition

[TOSCA](https://www.oasis-open.org/committees/tosca/) is a standard for cloud application orchestration


# pilots

Repository for the TOSCA files of the 12 pilots of [CloudOpting](http://www.cloudopting.eu/) project


## Bootstraping folder

A [template](https://github.com/CloudOpting/pilots/tree/master/template) folder is available to bootstrap a new experiment. Detailed description for the folder structure is inside that folder.

For an hungry eye the high level description of the structure follows :
 - TOSCA-Metadata
 - Types - contains schema definitions for both TOSCA and for custom types used inside CloudOpting.
 - Templates - contains various [FreeMarker](http://freemarker.org/) templates used throughout TOSCA XML file.
 - Definitions - contains the main TOSCA file in XML format. It is referenced from TOSCA.meta file

## Guidelines and recommendations

- [Puppet recommendations](documentation/puppet.md)
- [Docker recommendations](documentation/docker.md)
- [Example Docker+Puppet](documentation/example.md)
