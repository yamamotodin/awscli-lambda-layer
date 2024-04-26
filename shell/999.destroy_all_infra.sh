#!/bin/bash

PROJECT_NAME=$1
STAGE=$2
ROLE_NAME=${PROJECT_NAME}-lambda-${STAGE}
BUCKET_NAME=${PROJECT_NAME}-${STAGE}
FUNCTION_NAME=${PROJECT_NAME}-${STAGE}

aws lambda delete-function --function-name ${FUNCTION_NAME}

version=`aws lambda list-layers | jq -r '.Layers[] | select(.LayerName="aws-cli-layer") | .LatestMatchingVersion.Version'`
aws lambda delete-layer-version --layer-name aws-cli-layer --version-number $version

arns=`aws iam list-attached-role-policies --role-name $ROLE_NAME | jq -r .AttachedPolicies[].PolicyArn`
for arn in $arns ;do
  aws iam detach-role-policy --role-name $ROLE_NAME --policy-arn $arn
done

aws iam delete-role --role-name $ROLE_NAME

aws s3 rm s3://${BUCKET_NAME}/ --recursive
aws s3api delete-bucket --bucket $BUCKET_NAME


