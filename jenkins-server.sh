#!/bin/bash
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
sudo amazon-linux-extras install epel -y
sudo yum install java-11-amazon-corretto -y
sudo yum update -y
sudo wget https://mirror.esuni.jp/jenkins/redhat/jenkins-2.349-1.1.noarch.rpm
sudo rpm -Uvh jenkins-2.349-1.1.noarch.rpm
sudo systemctl enable jenkins
sudo systemctl start jenkins
