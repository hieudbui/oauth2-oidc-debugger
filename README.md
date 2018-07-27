# Apigee Ping Integration Test app (forked from https://github.com/GetLevvel/oauth2-oidc-debugger)

## Prerequisites
To run this project you will need to install docker.

## Building the docker image
``` 
 cd oauth2-oidc-debugger/client
 docker build -t oauth2-oidc-debugger .
 docker run -p 3000:3000 oauth2-oidc-debugger 
```
On other systems, the commands needed to start the debugger in a local docker container will be similar. The docker Sinatra/Ruby runtime will have to be able to establish connections to remote IdP endpoint (whether locally in other docker containers, on the host VM, or over the network/internet).  On the test system, it was necessary to add "--net=host" to the "docker run" args. The network connectivity details for docker may vary from platform-to-platform.

to push to heroku

git push heroku master