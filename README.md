# Contents of This Repo

## Frontend Tier
* ```frontend```: The Workspaces frontend (VueJS app).
  * Code here: https://github.com/TaskarCenterAtUW/workspaces-frontend.
  * Uses the other components within this repo, e.g. ```osm-rails```, ```osm-cgimap``` and ```tasking-manager``` as an API backend.
* ```pathways-editor```: fork of ID editor, with pathways editing support added by Raina at UW. 
* ```rapid```: UW fork of Rapid OSM editor.
  * Two versions (branches):
    * Workspaces version in the ```workspaces``` branch. Need to pull from public version periodically to keep up to date. 
    * Public version: tries to be a match to ```main``` of upstream. 

## Backend Tier
* ```osm-web```: Reverse proxy that dispatches requests to osm-cgimap or osm-rails depending on performance requirements.   
  * ```osm-log-proxy```: sits in front of the below two services, logs requests for debugging purposes.
    * ```osm-rails```: “reference implementation” for OSM API for editing. Slow.
    * ```osm-cgimap```: Faster version of osm-rails. API format the same as osm-rails. Only some functions of osm-rails. 
* ```tasking-manager```: Not currently using, but task manager for OSM. 
  
# To build images

```docker-compose -f docker-compose.build.yml -env XXX.env build```

Replace XXX.env with the environment definition file of the environment for which you want to build an image. This can be overridden when running (see below). 


# To update docker daemon to run with latest images

```docker-compose -f docker-compose.deploy.yml --env-file XXX.env up -d -pull always --force-recreate --remove-orphans```

Replace XXX.env with the environment definition file of the environment for which you are deploying.
