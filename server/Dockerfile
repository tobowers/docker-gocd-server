FROM thdevops01.mdx.med:5000/gocd-base
MAINTAINER Andrei Serdeliuc, andrei@apikot.com

RUN wget -O /tmp/go-server.deb http://download.go.cd/gocd-deb/go-server-14.4.0-1356.deb && dpkg -i /tmp/go-server.deb && rm /tmp/go-server.deb

ADD ssh/id_rsa /var/go/.ssh/id_rsa
RUN chown go:go /var/go/.ssh/id_rsa && chmod 600 /var/go/.ssh/id_rsa

RUN chown -R go:go /var/go/.ssh && chmod 700 /var/go/.ssh

EXPOSE 8153
EXPOSE 8154

CMD /etc/init.d/go-server start && tail -f /var/log/go-server/go-server.log
