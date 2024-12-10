#!/usr/bin/env bash

MATTERMOST_VERSION=6.0.2

docker build -t debugroom/mattermost-server:$MATTERMOST_VERSION . --no-cache

docker push debugroom/mattermost-server:$MATTERMOST_VERSION
