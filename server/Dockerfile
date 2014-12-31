FROM thdevops01.mdx.med:5000/gocd-base
MAINTAINER Andrei Serdeliuc, andrei@apikot.com

RUN wget -O /tmp/go-server.deb http://download.go.cd/gocd-deb/go-server-14.4.0-1356.deb && dpkg -i /tmp/go-server.deb && rm /tmp/go-server.deb

EXPOSE 8153
EXPOSE 8154

CMD /bootstrap_keys && /etc/init.d/go-server start && tail -f /var/log/go-server/go-server.log
