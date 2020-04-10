#!/usr/bin/env bash

stack_name="ma-common-ecs-service-mattermost"
#stack_name="ma-common-targetgroup-mattermost"
#stack_name="ma-common-public-alb"
#stack_name="ma-common-ecs-task-mattermost"
#stack_name="ma-common-public-ecs-cluster"
#stack_name="ma-common-customresource-dbinit"
#stack_name="ma-common-lambda-dbinit"
#stack_name="ma-common-s3-lambda"
#stack_name="ma-common-natgw"
#stack_name="ma-common-rds"
#stack_name="ma-common-sg"
#stack_name="ma-common-vpc"

aws cloudformation delete-stack --stack-name ${stack_name}