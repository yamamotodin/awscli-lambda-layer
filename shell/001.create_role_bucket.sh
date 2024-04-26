#!/bin/bash

ROLE_NAME=$1
BUCKET_NAME=$2

aws iam create-role \
 --role-name $ROLE_NAME \
 --assume-role-policy-document file://shell/trust-policy.json
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

aws s3api create-bucket \
 --create-bucket-configuration LocationConstraint=ap-northeast-1 \
 --bucket $BUCKET_NAME
