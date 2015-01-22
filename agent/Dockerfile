FROM thdevops01.mdx.med:5000/gocd-base
MAINTAINER topper.bowers@vitals.com

# taken from https://github.com/jpetazzo/dind

# enable EPEL
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# Let's start with some basic stuff.
RUN yum install -y ca-certificates lxc iptables e2fsprogs curl which

# install docker ( https://docs.docker.com/installation/centos/ )
RUN yum install -y docker-io

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
VOLUME /var/lib/docker

#ruby requirements
RUN yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel \
                   libyaml-devel libffi-devel openssl-devel make bzip2 \
                   autoconf automake libtool bison

# install RVM, Ruby, and Bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1.1"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

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
RUN sed -r -i "s/^(GO_SERVER)=(.*)/\1=\server/g" /etc/default/go-agent

CMD /bootstrap_keys && /usr/local/bin/wrapdocker && su - go -c '/usr/share/go-agent/agent.sh && tail -F /var/log/go-agent/go-agent.log'

