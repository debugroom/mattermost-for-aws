#!/usr/bin/env bash

stack_name="ma-common-ecs-service-mattermost"
#stack_name="ma-common-targetgroup-mattermost"
#stack_name="ma-common-public-alb"
#stack_name="ma-common-ecs-task-mattermost"
#stack_name="ma-common-public-ecs-cluster"
#stack_name="ma-common-s3-mattermost"
#stack_name="ma-common-customresource-dbinit"
#stack_name="ma-common-lambda-dbinit"
#stack_name="ma-common-s3-lambda"
#stack_name="ma-common-natgw"
#stack_name="ma-common-rds"
#stack_name="ma-common-sg"
#stack_name="ma-common-vpc"
template_path="mattermost-server/ecs-service-cfn.yml"
#template_path="mattermost-server/tg-cfn.yml"
#template_path="base/alb-cfn.yml"
#template_path="mattermost-server/ecs-task-cfn.yml"
#template_path="base/ecs-cluster-cfn.yml"
#template_path="mattermost-server/s3-for-mattermost-cfn.yml"
#template_path="rds/lambda-trigger-cfn.yml"
#template_path="rds/lambda-cfn.yml"
#template_path="rds/s3-for-lambda-cfn.yml"
#template_path="rds/natgw-cfn.yml"
#template_path="rds/rds-postgres-cfn.yml"
#template_path="base/sg-cfn.yml"
#template_path="base/vpc-cfn.yml"
#parameters=""
parameters="EnvType=Production Certificate=arn:aws:acm:ap-northeast-1:XXXXXXX:certificate/XXXXX"

#aws cloudformation create-stack --stack-name ${stack_name} --template-body file://${template_path} --capabilities CAPABILITY_IAM
# It is better cloudformation deploy option because command can execute even if stack existing(no need to delete existing stack).

if [ "$parameters" == "" ]; then
    aws cloudformation deploy --stack-name ${stack_name} --template-file ${template_path} --capabilities CAPABILITY_IAM
else
    aws cloudformation deploy --stack-name ${stack_name} --template-file ${template_path} --parameter-overrides ${parameters} --capabilities CAPABILITY_IAM
fi