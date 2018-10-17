Based on [ClarityMoe's Cloud9 v3](https://github.com/ClarityMoe/cloud9-on-openshift).

# Cloud9 Docker Images for OpenShift Online/OpenShift Dedicated/OCP/OpenShift Origin
[![pipeline status](https://gitlab.com/sr229/c9/badges/master/pipeline.svg)](https://gitlab.com/sr229/c9/commits/master)
[![CircleCI](https://circleci.com/gh/ClarityMoe/cloud9-on-openshift.svg?style=svg)](https://circleci.com/gh/ClarityMoe/cloud9-on-openshift)

Cloud9 is a IDE created by Cloud9 IDE, Inc. (now owned wholly by Amazon Web Services) that uses HTML5 technologies to deliver a
coding experience in the cloud.

The following Dockerfiles allow Cloud9 to work on OpenShift - as traditional images won't work on OpenShift due to some limitations
(but not limted to):

- UIDs are scrambled, breaking usermode images even if done adequately. It still works but operates under a nonexisting UID.
- Root is prohibited due to security reasons (OpenShift Online).
- Mounting of volumes must be added with permissions adequately by making the target folder to where to mount the volume else it'll
  result in a OCI Runtime error (OpenShift Online).

## Installing

 
## Copyright
  
Dockerfiles and shell scripts are licensed under MIT License. Copyright 2018&copy; Clarity. 
  
Cloud9 IDE is a registered trademarked under Amazon Web Services. All Rights Reserved.
  
Cloud9 IDE v3 source code (SDK) is licensed under a Non-Commercial license for personal use. If you're looking for Enterprise usage:
Please acquire a license from AWS first and please read clear of the terms. Both licenses are provided in `/opt/`.
  
  
