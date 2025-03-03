# Dev Standards

### Branch Strategy

* **main**: day to day work goes here. 
* **dev**: current code of the dev environment. No commits allowed directly; you'll need to open a PR from main. Committing/pushing here causes a deployment to the dev infrastructure. 

### GH Actions

See GitHub's actions tab in this repo for more deployment examples/steps. 

# System Overview

### Frontend Tier
* ```frontend```: The Workspaces frontend (VueJS app).
  * Code here: https://github.com/TaskarCenterAtUW/workspaces-frontend.
  * Uses the other components within this repo, e.g. ```osm-rails```, ```osm-cgimap``` and ```tasking-manager``` as an API backend.
* ```pathways-editor```: fork of ID editor, with pathways editing support added by Raina at UW. 
* ```rapid```: UW fork of Rapid OSM editor.
  * Two versions (branches):
    * Workspaces version in the ```workspaces``` branch. Need to pull from public version periodically to keep up to date. 
    * Public version: tries to be a match to ```main``` of upstream. 

### Backend Tier
* ```osm-web```: Reverse proxy that dispatches requests to osm-cgimap or osm-rails depending on performance requirements.   
  * ```osm-log-proxy```: sits in front of the below two services, logs requests for debugging purposes.
    * ```osm-rails```: “reference implementation” for OSM API for editing. Slow.
    * ```osm-cgimap```: Faster version of osm-rails. API format the same as osm-rails. Only some functions of osm-rails. 
* ```tasking-manager```: Not currently using, but task manager for OSM. 

# Getting Started

### To build images for deploy

```git clone --recursive https://github.com/TaskarCenterAtUW/workspaces-stack.git```

```docker-compose -f docker-compose.build.yml --env-file XXX.env build```

```docker-compose -f docker-compose.build.yml push```

Replace XXX.env with the environment definition file of the environment for which you want to build an image. This can be overridden when running (see below). 

### To update docker daemon to run with latest images

```docker-compose -f docker-compose.deploy.yml --env-file XXX.env up -d -pull always --force-recreate --remove-orphans```

Replace XXX.env with the environment definition file of the environment for which you are deploying.

### Other Files

* ```example.env```: template of the .env file required by the Docker compose YAML files
* ```tdei_uw.env```: .env for deployment at UW's TDEI center. Only UW should use this, new users should adapt example.env to suit their needs. LTG: remove this file from this repo.

# Local Development

### To build images for local development

You will need access to prepopulated .env files that are not in version control.  Specifically local.dev.env for the rest of these steps, which is assumed to be found in the workspaces-stack root directory.

Add (or merge) the following to your ```/etc/hosts``` file:

```127.0.0.1	localhost workspaces.local api.workspaces.local rapid.workspaces.local osm.workspaces.local pathways.workspaces.local tasks.workspaces.local```

You will also need to increase the total amount of system memory available to Docker containers to 10+ GB.  In Docker Desktop you find this in Settings -> Resources -> Memory Limit.

```git clone --recursive https://github.com/TaskarCenterAtUW/workspaces-stack.git```

Comment out the ```osm-log-proxy``` section from ```docker-compose.yml``` as aggregate logging is not available locally.

```docker-compose build```
  
```cp local.dev.env .env```
  
```docker-compose up -d```

Now we are ready to finalize configuration on each container.

```
docker-compose run --rm --entrypoint=bash frontend
npm i
exit
```  

```
docker-compose run --rm --entrypoint=bash rapid
npm i
exit
```  

```
docker-compose run --rm --entrypoint=bash pathways-editor
npm i
exit
```  

```
docker-compose run --rm --entrypoint=bash osm-rails
cp /config/example.storage.yml /config/storage.yml
bundle install
exit
```  

Note that there are two different ways to run individual containers depending on your dev context.

Using the frontend container as an example:
* To debug / step through run ```docker-compose run --rm frontend```
* To run while working on another service run ```docker-compose up -d frontend```
