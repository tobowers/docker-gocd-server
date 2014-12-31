FROM debian:wheezy
MAINTAINER Topper Bowers topper.bowers@vitals.com

ADD sources.list.d/wheezy-backports.list /etc/apt/sources.list.d/wheezy-backports.list

RUN apt-get -y update && \
        apt-get install -t wheezy-backports -y wget git procps openjdk-7-jre-headless curl unzip && \
        apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

ADD bootstrap_keys /bootstrap_keys
RUN chmod 700 /bootstrap_keys

#allow github pull to go smoothly
ADD ssh/known_hosts /var/go/.ssh/known_hosts
RUN chown -R 102:104 /var/go && chmod 700 /var/go/.ssh
RUN chmod 644 /var/go/.ssh/known_hosts
