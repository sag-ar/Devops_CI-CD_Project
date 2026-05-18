#!/bin/bash

#installing java version
yum update -y
yum install java-21 -y

yum install wget -y
#dowmloading and installing jenkins
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/rpm/jenkins.repo
yum upgrade
# Add required dependencies for the jenkins package

yum install jenkins -y

#Enable the Jenkins service to start at boot
systemctl enable jenkins

#Start Jenkins as a service:
systemctl start jenkins

#make sure jenkins comeup when reboot
chkconfig jenkins on

#install git
yum install git -y