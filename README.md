# go.cd server Docker image

Dockerfile for the Go.cd continuous integration server.

This builds the Go server.

## Run it

    docker pull extraordinaire/docker-gocd-server
    docker run -d -p 8153:8153 extraordinaire/docker-gocd-server
