# go.cd server Docker image

Dockerfile for the [Go.cd](http://go.cd) continuous integration server.

This builds the Go server. You will probably also want [agents](https://github.com/mdx-dev/docker-gocd).

## Run it

    docker pull thdevops01.mdx.med:5000/gocd-server
    docker run -d -p 8153:8153 -name gocd-server thdevops01.mdx.med:5000/gocd-server
