#TODO: fix me to mean this repo

# go.cd agent Docker image

Dockerfile for the [Go.cd](http://go.cd) continuous integration agent.

This builds the Go agent, you will also need [a server](https://github.com/extraordinaire/docker-gocd-server).

## Run it

    docker pull extraordinaire/docker-gocd-agent
    docker run -d -link gocd-server:server extraordinaire/docker-gocd-agent

Replace `gocd-server` in the parameter for link with the name of your gocd container,
which you can find in the last column of `docker ps`

If you're running gocd agent on a different host, simply run the agent container like so

    docker run -d extraordinaire/docker-gocd-agent -e SERVER_PORT_8153_TCP_ADDR=<HOST OF GOCD SERVER> -e SERVER_PORT_8153_TCP_PORT=<PORT SERVER LISTENING ON>