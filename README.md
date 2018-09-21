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

## Structure

Currently, we structured the Cloud9 images based on the versions known: namely v2 and v3.

 - ``v2`` - This Cloud9 version is the GPL-licensed Cloud9 IDE before V3. It has officially ended it's development period during
            February 2015 and is the last known Cloud9 version that is GPL-Licensed. We use a 
            [Community Maintenance fork](https://github.com/exsilium/cloud9) to provide us the same functionality albeit in a more
            modern Node.js runtime (Node.js V8 LTS).
            
 - ``v3`` - This Cloud9 version is the current officially maintained [version](https://github.com/c9/core). It's only available
            For plugin development and non-commercial usage. It's currently now named as AWS Cloud9 after being bought by Amazon Inc.

## Installing

You can install the Docker images on DockerHub, like so:
 - ``chinodesuuu/c9:v2``
 - ``chinodesuuu/c9:v3``
 
 As of July 2018, we do not provide a `latest` tag.
 
 ## Contributing
 
 We accept Contributions! We consider several factors before adding your PR though:
  - It builds on CircleCI fine.
  - It works on OpenShift (Make sure to register to [OpenShift Online](https://openshift.com) to recieve a free sandbox to test this!)
  
  ## Copyright
  
  Dockerfiles and shell scripts are licensed under MIT License. Copyright 2018&copy; Clarity. 
  
  Cloud9 IDE is a registered trademarked under Amazon Web Services. All Rights Reserved.
  
  Cloud9 IDE v2 source code is licensed under the GNU General Public License. A copy of the license is provided along with the source
  in `/opt/`.
  
  Cloud9 IDE v3 source code (SDK) is licensed under a Non-Commercial license for personal use. If you're looking for Enterprise usage:
  Please acquire a license from AWS first and please read clear of the terms. Both licenses are provided in `/opt/`.
  
  
