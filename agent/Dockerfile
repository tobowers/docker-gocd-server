FROM thdevops01.mdx.med:5000/gocd-base
MAINTAINER topper.bowers@vitals.com

# Let's start with some basic stuff.
RUN yum install -y ca-certificates lxc iptables e2fsprogs

RUN groupadd docker && gpasswd -a go docker

RUN wget https://get.docker.com/builds/Linux/x86_64/docker-1.4.1 -O /usr/bin/docker && \
    chmod +x /usr/bin/docker

# Install the magic docker wrapper. Taken from https://github.com/jpetazzo/dind
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# the docker daemon depends on not being inside the aufs - so we declare a volume
VOLUME /var/lib/docker

# setup yum repos for node
RUN curl -sL https://rpm.nodesource.com/setup | bash -

#ruby requirements / node / phantomjs requirements
RUN yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel \
                   libyaml-devel libffi-devel openssl-devel make bzip2 \
                   autoconf automake libtool bison nodejs \
                   fontconfig freetype libfreetype.so.6 libfontconfig.so.1 libstdc++.so.6 #this line is phantomjs dependencies

#install phantomjs
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 -O /tmp/phantomjs-1.9.8-linux-x86_64.tar.bz2 && \
    cd /tmp && tar xvf /tmp/phantomjs-1.9.8-linux-x86_64.tar.bz2 && \
    cp /tmp/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs && \
    rm /tmp/phantomjs-1.9.8-linux-x86_64.tar.bz2 && rm -rf /tmp/phantomjs-1.9.8-linux-x86_64/bin/phantomjs

# install RVM, Ruby, and Bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.1,2.1.5 --with-gems=bundler,rake
RUN ["/bin/bash", "-l", "-c", "rvm requirements"]

#postgres - annoying but for now installing - in the future we should self-host with docker
RUN yum localinstall -y http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
RUN yum update -y && yum install -y postgresql93-libs postgresql93-contrib postgresql93-debuginfo \
                                 postgresql93-devel postgresql93-docs postgresql93-pltcl \
                                 postgresql93-plpython postgresql93

#gocd-agent install
RUN wget -O /tmp/go-agent.rpm http://download.go.cd/gocd-rpm/go-agent-14.4.0-1356.noarch.rpm && \
    yum localinstall -y /tmp/go-agent.rpm && \
    rm /tmp/go-agent.rpm

VOLUME /var/lib/go-agent
RUN sed -r -i "s/^(GO_SERVER)=(.*)/\1=\gocd-server/g" /etc/default/go-agent
RUN sed -r -i "s/^(DAEMON)=(.*)/\1=\N/g" /etc/default/go-agent

ADD profile.d/pgsql /var/go/.profile.d/pgsql
RUN chown -R go:go /var/go/.profile.d && chmod 755 -R /var/go/.profile.d

ENV DOCKER_DAEMON_ARGS="--insecure-registry thdevops01.mdx.med:5000" LOG=file

CMD /bootstrap_keys && /usr/local/bin/wrapdocker && rm /var/lib/go-agent/.agent-bootstrapper.running && su - go -c 'eval `ssh-agent -s` && ssh-add ~/.ssh/id_rsa && /usr/share/go-agent/agent.sh'

