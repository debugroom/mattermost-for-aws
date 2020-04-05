#!/usr/bin/env bash

stack_name="debugroom-technical-academy-ecs-service-mattermost"
#stack_name="debugroom-technical-academy-targetgroup-mattermost"
#stack_name="debugroom-technical-academy-alb"
#stack_name="debugroom-technical-academy-ecs-task-mattermost"
#stack_name="debugroom-technical-academy-ecs-cluster"
#stack_name="debugroom-technical-academy-lambda"
#stack_name="debugroom-technical-academy-rds"
#stack_name="debugroom-technical-academy-sg"
#stack_name="debugroom-technical-academy-vpc"

aws cloudformation delete-stack --stack-name ${stack_name}