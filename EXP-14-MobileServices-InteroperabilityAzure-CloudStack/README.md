This is the folder for the experiment **EXP-14-MobileServices-InteroperabilityAzure-CloudStack**.

The experiment are composed by 4 components:

* Mongo database
* Apache
* Tomcat with applications
* Tomcat with sesame and worckbench

There are links from Apache to Tomcat Sesame and Tomcat.
There are a link from Tomcat to Mongo database.

See the following table:

| Container name    | Software package and version        | Volumes used (size and location)  | OS name and version | Depends on other containers      | Opened/exposed ports |
|:------------------|:------------------------------------|:----------------------------------|:--------------------|:---------------------------------|:---------------------|
| http_c4c          | Apache 2                            | None                              | Ubuntu 14.04        | tomcat_c4c and tomcat_sesame_c4c | 80/80 and 443/443    |
| tomcat_c4c        | Oracle Java 8 and Apache Tomcat 7   | None                              | Ubuntu 14.04        | mongo_c4c                        | 8080/-               |
| mongo_c4c         | Mongo 2.4.14                        | /data/db                          | Ubuntu 14.04        | None                             | 27017/27017          |
| tomcat_sesame_c4c | Oracle Java 8 and Apache Tomcat 7   | None                              | Ubuntu 14.04        | None                             | 8080/8080            |


See the following image: