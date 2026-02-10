#!/bin/sh

# A script to prep the repos as the CI/CD pipeline does, e.g. when you're developing on your local machine
#
# Run as ./checkout-repos.sh <tag name> e.g. ./checkout-repos.sh dev
#

git clone --depth 1 --branch $1 https://github.com/TaskarCenterAtUW/workspaces-backend.git api
git clone --depth 1 --branch $1 https://github.com/TaskarCenterAtUW/workspaces-frontend.git frontend
git clone --depth 1 --branch $1 https://github.com/TaskarCenterAtUW/workspaces-cgimap.git osm-cgimap
git clone --depth 1 --branch $1 https://github.com/TaskarCenterAtUW/workspaces-openstreetmap-website.git osm-rails
git clone --depth 1 --branch $1 https://github.com/TaskarCenterAtUW/workspaces-pathways-editor.git pathways-editor
git clone --depth 1 --branch $1 https://github.com/TaskarCenterAtUW/workspaces-rapid.git rapid
git clone --depth 1 --branch $1 https://github.com/TaskarCenterAtUW/workspaces-tasking-manager.git tasking-manager
git clone --depth 1 --branch $1 https://github.com/TaskarCenterAtUW/workspaces-leaderboard.git leaderboard
