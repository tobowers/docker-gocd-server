FROM debian:wheezy
MAINTAINER Topper Bowers topper.bowers@vitals.com

ADD wheezy-backports.list /etc/apt/sources.list.d/wheezy-backports.list

RUN apt-get -y update && \
        apt-get install -t wheezy-backports -y wget git procps openjdk-7-jre-headless curl unzip && \
        apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

#allow github pull to go smoothly
ADD ssh/known_hosts /var/go/.ssh/known_hosts
RUN chmod 644 /var/go/.ssh/known_hosts


