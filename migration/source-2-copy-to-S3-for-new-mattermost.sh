#!/usr/bin/env bash

SOURCE_REGION=ap-northeast-1
SOURCE_BUCKET=ma-mattermost-bucket
DESTINATION_REGION=ap-northeast-1
DESTINATION_BUCKET=debugroom-technical-academy-mattermost-gen2-bucket

ACCOUNT=`aws sts get-caller-identity --output text | cut -f1`
echo $ACCOUNT
TEMPORARY_CREDENTIAL=`aws sts assume-role --role-arn "arn:aws:iam::${ACCOUNT}:role/CopyS3DataAssumeRole" --role-session-name Copy-S3Data`

echo $TEMPORARY_CREDENTIAL

ACCESS_KEY=`echo $TEMPORARY_CREDENTIAL | jq -r .Credentials.AccessKeyId`
SECRET_KEY=`echo $TEMPORARY_CREDENTIAL | jq -r .Credentials.SecretAccessKey`
SESSION_TOKEN=`echo $TEMPORARY_CREDENTIAL | jq -r .Credentials.SessionToken`

echo $ACCESS_KEY
echo $SECRET_KEY
echo $SESSION_TOKEN

export AWS_ACCESS_KEY_ID=$ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$SECRET_KEY
export AWS_SESSION_TOKEN=$SESSION_TOKEN

echo `aws configure list`

aws s3 cp s3://$SOURCE_BUCKET s3://$DESTINATION_BUCKET --recursive --source-region $SOURCE_REGION --region $DESTINATION_REGION --acl bucket-owner-full-control