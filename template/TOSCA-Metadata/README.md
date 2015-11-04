Folder that contains metadata definition for TOSCA archive.

##TOSCA.meta
Metadata file used to initialize the TOSCA process.
Properties used in this file are:

|Name|Description|Example|
|TOSCA-Meta-Version|Version of the file| 1.0
|CSAR-Version|version of the archiving container|1.0
|Created-By|Name of the creator|CSI
|Entry-Definitions|Relative path for the TOSCA XML file|Definitions/Wordpress-Definitions.xml
|Name|TO DO|Templates/Dockerfile.ftl
|Content-Type|Output content type|text/plain

The steps to execute a TOSCA definition are in the diagram below:
![Steps to deploy TOSCA definition](https://raw.githubusercontent.com/CloudOpting/pilots/master/documentation/TOSCA%20Deployment%20steps.png)

The structure of TOSCA definition is depicted in the diagram below:
![TOSCA definition structure](https://raw.githubusercontent.com/CloudOpting/pilots/master/documentation/TOSCA%20folder%20content.png)
