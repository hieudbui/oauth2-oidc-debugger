# Apigee Ping Integration Test app (forked from https://github.com/GetLevvel/oauth2-oidc-debugger)

## Prerequisites
To run this project you will need to install docker.

## Run locally
Need to have ruby
cd to client
rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- /Users/hbuib/.rvm/gems/ruby-2.4.1/bin/rackup -o 0.0.0.0 -p 3000
 
## Building the docker image
``` 
 cd oauth2-oidc-debugger/client
 docker build -t oauth2-oidc-debugger .
 docker run -p 3000:3000 oauth2-oidc-debugger 
```
On other systems, the commands needed to start the debugger in a local docker container will be similar. The docker Sinatra/Ruby runtime will have to be able to establish connections to remote IdP endpoint (whether locally in other docker containers, on the host VM, or over the network/internet).  On the test system, it was necessary to add "--net=host" to the "docker run" args. The network connectivity details for docker may vary from platform-to-platform.

to push to heroku (its a hack right now, we have two git repos, one at the root leve, and one in client sub directory ack!)
the git repo under client is registered for heroku
cd client
git add -u
git commit -m 'blah'
git push heroku master


not sure why yet but commit at the root level doesn't work
do the following:
git add -u
git commit -m 'whatever'
git push

there are three heroku apps configured for this repo
heroku config --app blooming-beyond-21033 (prod)
heroku config --app quiet-eyrie-28276 (stage)
heroku config --app warm-badlands-68435 (dev)

(prod)
heroku config:set CALLBACK_URI=https://blooming-beyond-21033.herokuapp.com/callback --app blooming-beyond-21033
heroku config:set APIGEE_URL="https://merrill-prod.apigee.net" --app blooming-beyond-21033   
heroku config:set EDGEMICRO_URL=https://edgemicro-prod.apps.us2.prod.foundry.mrll.com --app blooming-beyond-21033

(dev)
heroku config:set CALLBACK_URI=https://warm-badlands-68435.herokuapp.com/callback --app warm-badlands-68435
heroku config:set APIGEE_URL=https://merrill-dev.apigee.net --app warm-badlands-68435
heroku config:set EDGEMICRO_URL=https://devapi.core.merrillcorp.com --app warm-badlands-68435

https://warm-badlands-68435.herokuapp.com/ (dev)
https://quiet-eyrie-28276.herokuapp.com/ (stage)
https://blooming-beyond-21033.herokuapp.com/ (prod us)
https://peaceful-temple-59478.herokuapp.com/ (prod eu)


