# Apigee Ping Integration Test app (forked from https://github.com/GetLevvel/oauth2-oidc-debugger)

## Prerequisites

## Run locally
Need to have ruby
cd to client
1) to debug: rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- /Users/hbuib/.rvm/gems/ruby-2.4.1/bin/rackup -o 0.0.0.0 -p 3000
2) to just run: rackup -p 3000
 
## Building the docker image
``` 
 cd oauth2-oidc-debugger/client
 docker build -t oauth2-oidc-debugger .
 docker run -p 3000:3000 oauth2-oidc-debugger 
```

to push to heroku (its a hack right now, we have two git repos, one at the root level, and one in client sub directory ack!)
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
heroku config --app peaceful-temple-59478 (prod-eu)
heroku config --app quiet-eyrie-28276 (stage)
heroku config --app warm-badlands-68435 (dev)

(prod)
heroku config:set CALLBACK_URI=https://blooming-beyond-21033.herokuapp.com/callback --app blooming-beyond-21033
heroku config:set APIGEE_URL="https://merrill-prod.apigee.net" --app blooming-beyond-21033   
heroku config:set EDGEMICRO_URL=https://api.datasiteone.merrillcorp.com --app blooming-beyond-21033

(prod-eu)
heroku config:set CALLBACK_URI=https://peaceful-temple-59478.herokuapp.com/callback --app peaceful-temple-59478
heroku config:set APIGEE_URL="https://merrill-prod.apigee.net" --app peaceful-temple-59478   
heroku config:set EDGEMICRO_URL=https://api.global.datasiteone.merrillcorp.com/eu --app peaceful-temple-59478

(dev)
heroku config:set CALLBACK_URI=https://warm-badlands-68435.herokuapp.com/callback --app warm-badlands-68435
heroku config:set APIGEE_URL=https://merrill-dev.apigee.net --app warm-badlands-68435
heroku config:set EDGEMICRO_URL=https://devapi.core.merrillcorp.com --app warm-badlands-68435

https://warm-badlands-68435.herokuapp.com/ (dev)
https://quiet-eyrie-28276.herokuapp.com/ (stage)
https://blooming-beyond-21033.herokuapp.com/ (prod us)
https://peaceful-temple-59478.herokuapp.com/ (prod eu)


