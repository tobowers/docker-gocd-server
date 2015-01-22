FROM thdevops01.mdx.med:5000/gocd-base
MAINTAINER topper.bowers@vitals.com

# taken from https://github.com/jpetazzo/dind

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    lxc \
    iptables

# Install Docker from Docker Inc. repositories
RUN echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
  && apt-get update -qq \
  && apt-get install -qqy lxc-docker

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
VOLUME /var/lib/docker

#ruby requirements
RUN apt-get install -y build-essential openssl curl libssl-dev libyaml-dev nodejs

# install RVM, Ruby, and Bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1.1"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

#postgres - annoying but for now installing - in the future we should self-host with docker
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update -qq && \
    apt-get install -qqy postgresql-9.3

#GO-cd stuff
RUN wget -O /tmp/go-client.deb http://download.go.cd/gocd-deb/go-agent-14.4.0-1356.deb && dpkg -i /tmp/go-client.deb && rm /tmp/go-client.deb
VOLUME /var/lib/go-agent
RUN sed -r -i "s/^(GO_SERVER)=(.*)/\1=\server/g" /etc/default/go-agent

CMD /bootstrap_keys && /usr/local/bin/wrapdocker && su - go -c '/usr/share/go-agent/agent.sh && tail -F /var/log/go-agent/go-agent.log'

