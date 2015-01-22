FROM centos:centos6
MAINTAINER Topper Bowers topper.bowers@vitals.com

RUN yum install -y initscripts postfix rsyslog sudo zip tar \
    redhat-lsb-core rsync openssh-clients wget curl openssh-server unzip \
    pcre-devel pcre git java-1.7.0-openjdk

#ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

ADD bootstrap_keys /bootstrap_keys
RUN chmod 700 /bootstrap_keys

RUN groupadd -g 104 go && \
    useradd -m -u 102 -g 104 -d /var/go -s /bin/bash go

RUN ssh-keyscan -H github.com >> /etc/ssh/ssh_known_hosts

USER go
RUN mkdir /var/go/.ssh && \
    chmod 700 /var/go/.ssh

USER root

