#!/usr/bin/env bash

#LABEL script to build docker image, dockerfile and delete unused files

echo"What is the name of your workspace directory?: "

readfolderName

mkdir ${folderName}&&cd${folderName}&&touch Dockerfile

echo"What is your base image? centos, ubuntu or alpine?: "

readbaseName

#Checking for wrong base name
if[ ${baseName}!=ubuntu ] ||[ ${baseName}!=centos ] ||[ ${baseName}!=alpine ]
then
cd-
sudo rm -r ${folderName}
echo"Please enter a valid choice between ubuntu, centos or alpine."
exit1
fi

echo"What port do you wish to use?: "

readportNumber

echo"What is your preferred ${baseName}version?: "

readbaseVersion

#defining condition for each distroType
if[ ${baseName}=ubuntu ]
then
echo-e "FROM ${baseName}:${baseVersion}""\nLABEL maintainer: ${USER}""\nEXPOSE ${portNumber}""\nRUN apt-get update -y">Dockerfile
echo"Building ${baseName}image."
elif[ ${baseName}=centos ]
then
echo-e "FROM ${baseName}:${baseVersion}""\nLABEL maintainer: ${USER}""\nEXPOSE ${portNumber}""\nRUN yum update -y">Dockerfile
echo"Building ${baseName}image."
elif[ ${baseName}=alpine ]
then
echo-e "FROM ${baseName}:${baseVersion}""\nLABEL maintainer: ${USER}""\nEXPOSE ${portNumber}""\nRUN apk update">Dockerfile
echo"Building ${baseName}image."
fi

#build docker image
docker image build -t ${USER}_${baseName}.
if[ $?-eq0 ]
then
rm -f Dockerfile
cd-
rm -r ${folderName}
echo-e "${baseName}image built successfully and Dockerfile and workspace directory deleted. \n Please run the docker images command to check."
exit0
fi


