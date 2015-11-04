# TOSCA definition
[TOSCA](https://www.oasis-open.org/committees/tosca/) is a standard for cloud application orchestration
# pilots
Repository for the TOSCA files of the 12 pilots of [CloudOpting](http://www.cloudopting.eu/) project
##Bootstraping folder
A [template](https://github.com/CloudOpting/pilots/tree/master/template) folder is available to bootstrap a new experiment.

Structure of the folders is the following:
 - TOSCA-Metadata
  - TOSCA.meta - **main** entry point of the solution - it contains the definition of main source files that will be used by the application
 - Types - contains schema definitions for both TOSCA and for custom types used inside CloudOpting.
 - Templates - contains various [FreeMarker](http://freemarker.org/) templates used throughout TOSCA XML file.
 - Definitions - contains the main TOSCA file in XML format. It is referenced from TOSCA.meta file


The steps to execute a TOSCA definition are in the diagram below:
![Steps to deploy TOSCA definition](https://raw.githubusercontent.com/CloudOpting/pilots/master/documentation/TOSCA%20Deployment%20steps.png)

The structure of TOSCA definition is depicted in the diagram below:
![TOSCA definition structure](https://raw.githubusercontent.com/CloudOpting/pilots/master/documentation/TOSCA%20folder%20content.png)
