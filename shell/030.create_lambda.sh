#!/bin/bash

FunctionName=$1
RoleName=$2
AccountID=`aws sts get-caller-identity | jq -r '.Account'`
Layer=`aws lambda list-layers | jq -r '.[][]| select(.LayerName =="aws-cli-layer") | .LatestMatchingVersion.LayerVersionArn'`

sh shell/025.build.sh

aws lambda create-function \
    --function-name ${FunctionName} \
    --zip-file fileb://dist/function.zip \
    --handler function.handler \
    --runtime provided.al2023 \
    --role arn:aws:iam::${AccountID}:role/${RoleName} \
    --layers  ${Layer} \
    --timeout 180
