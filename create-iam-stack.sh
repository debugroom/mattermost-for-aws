#!/usr/bin/env bash

# For Migration New Account
#stack_name="debugroom-technical-academy-S3-for-new-mattermost"
#template_path="migration/destination-1-s3-for-new-mattermost-cfn.yml"

stack_name="debugroom-technical-academy-iam-user-for-migration-mattermost"
#stack_name="debugroom-technical-academy-ecs-service-mattermost"
#stack_name="debugroom-technical-academy-targetgroup-mattermost"
#stack_name="debugroom-technical-academy-alb"
#stack_name="debugroom-technical-academy-ecs-task-mattermost"
#stack_name="debugroom-technical-academy-ecs-cluster"
#stack_name="debugroom-technical-academy-s3-mattermost"
#stack_name="debugroom-technical-academy-custom"
#stack_name="debugroom-technical-academy-lambda"
#stack_name="debugroom-technical-academy-natgw"
#stack_name="debugroom-technical-academy-rds"
#stack_name="debugroom-technical-academy-sg"
#stack_name="debugroom-technical-academy-vpc"
template_path="migration/source-1-iam-user-for-copying-bucket-cfn.yml"
#template_path="mattermost-server/ecs-service-cfn.yml"
#template_path="mattermost-server/tg-cfn.yml"
#template_path="base/alb-cfn.yml"
#template_path="mattermost-server/ecs-task-cfn.yml"
#template_path="base/ecs-cluster-cfn.yml"
#template_path="mattermost-server/s3-for-mattermost-cfn.yml"
#template_path="rds/lambda-trigger-cfn.yml"
#template_path="rds/lambda-cfn.yml"
#template_path="rds/natgw-cfn.yml"
#template_path="rds/rds-postgres-cfn.yml"
#template_path="base/sg-cfn.yml"
#template_path="base/vpc-cfn.yml"
parameters=""

#aws cloudformation create-stack --stack-name ${stack_name} --template-body file://${template_path} --capabilities CAPABILITY_IAM
# It is better cloudformation deploy option because command can execute even if stack existing(no need to delete existing stack).

if [ "$parameters" == "" ]; then
#    aws cloudformation deploy --stack-name ${stack_name} --template-file ${template_path} --capabilities CAPABILITY_IAM
    #if the Resources includes IAM, You should specify CAPABILITY_NAMED_IAM options in capabilities
    aws cloudformation deploy --stack-name ${stack_name} --template-file ${template_path} --capabilities CAPABILITY_NAMED_IAM
else
#    aws cloudformation deploy --stack-name ${stack_name} --template-file ${template_path} --parameter-overrides ${parameters} --capabilities CAPABILITY_IAM
    #if the Resources includes IAM, You should specify CAPABILITY_NAMED_IAM options in capabilities
    aws cloudformation deploy --stack-name ${stack_name} --template-file ${template_path} --parameter-overrides ${parameters} --capabilities CAPABILITY_NAMED_IAM
fi