#!/bin/bash

FunctionName=$1

Layer=`aws lambda list-layers | jq -r '.[][]| select(.LayerName =="aws-cli-layer") | .LatestMatchingVersion.LayerVersionArn'`
aws lambda update-function-configuration \
    --function-name ${FunctionName} \
    --layers ${Layer}
