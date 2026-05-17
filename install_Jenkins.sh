#!/bin/bash


#installing java version
yum update -y
yum install java -y

yum install wget -y
#dowmloading and installing jenkins

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/rpm/jenkins.repo
yum upgrade
yum install jenkins -y
systemctl daemon-reload

#Enable the Jenkins service to start at boot
systemctl enable jenkins


#Start Jenkins as a service:
systemctl start jenkins


#make sure jenkins comeup when reboot
chkconfig jenkins on

#install git
yum install git -y
