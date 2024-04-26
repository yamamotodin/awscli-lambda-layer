#!/bin/bash

if [ x"$1" = "x" ]; then
  echo "usage: setup.sh project_name STAGE"
  echo "ex: sh setup.sh project_name stg"
  exit 1
fi

PROJECT_NAME=$1
STAGE=$2
ROLE_NAME=${PROJECT_NAME}-lambda-${STAGE}
BUCKET_NAME=${PROJECT_NAME}-${STAGE}
FUNCTION_NAME=${PROJECT_NAME}-${STAGE}

cd `dirname $0`/..
mkdir -p dist

sh shell/001.create_role_bucket.sh $ROLE_NAME $BUCKET_NAME
sh shell/002.create_provided.sh $BUCKET_NAME
sh shell/020.create_aws_layer.sh $BUCKET_NAME
sh shell/025.build.sh $ROLE_NAME $BUCKET_NAME
sh shell/030.create_lambda.sh $FUNCTION_NAME $ROLE_NAME
sh shell/070.add_policy_to_role.sh $ROLE_NAME
