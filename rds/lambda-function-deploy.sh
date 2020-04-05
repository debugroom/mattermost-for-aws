#!/usr/bin/env bash

bucket_name=debugroom-cloudformation-lambda-bucket
stack_name="debugroom-technical-academy-s3-for-lambda"
template_path="s3-for-lambda-cfn.yml"
s3_objectkey="lambda-dbinit-0.0.1-SNAPSHOT-aws-lambda.jar"

if [ "" == "`aws s3 ls | grep $bucket_name`" ]; then
    aws cloudformation deploy --stack-name ${stack_name} --template-file ${template_path} --capabilities CAPABILITY_IAM
fi

cd lambda-dbinit
./mvnw package
aws s3 cp target/${s3_objectkey} s3://${bucket_name}/