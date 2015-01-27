FROM thdevops01.mdx.med:5000/gocd-base
MAINTAINER Andrei Serdeliuc, andrei@apikot.com

RUN wget -O /tmp/go-server.rpm http://download.go.cd/gocd-rpm/go-server-14.4.0-1356.noarch.rpm && \
    yum localinstall -y /tmp/go-server.rpm && \
    rm /tmp/go-server.rpm

VOLUME /var/lib/go-server

EXPOSE 8153 8154

CMD /bootstrap_keys && /etc/init.d/go-server start && tail -f /var/log/go-server/go-server.log
