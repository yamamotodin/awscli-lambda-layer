#!/bin/bash
if [ $# -ne 2 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには2個の引数が必要です。" 1>&2
  echo "$0 [LambdaFunctionName] [Role]"
  exit 1
fi
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
    --timeout 30
