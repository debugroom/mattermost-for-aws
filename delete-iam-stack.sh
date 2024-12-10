#!/usr/bin/env bash

# For Migration New Account
#stack_name="debugroom-technical-academy-S3-for-new-mattermost"

stack_name="debugroom-technical-academy-iam-user-for-migration-mattermost"
#stack_name="debugroom-technical-academy-ecs-service-mattermost"
#stack_name="debugroom-technical-academy-ecs-task-mattermost"
#stack_name="debugroom-technical-academy-targetgroup-mattermost"
#stack_name="debugroom-technical-academy-alb"
#stack_name="debugroom-technical-academy-custom"
#stack_name="debugroom-technical-academy-ecs-cluster"
#stack_name="debugroom-technical-academy-lambda"
#stack_name="debugroom-technical-academy-natgw"
#stack_name="debugroom-technical-academy-rds"
#stack_name="debugroom-technical-academy-sg"
#stack_name="debugroom-technical-academy-vpc"

aws cloudformation delete-stack --stack-name ${stack_name}