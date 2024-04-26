#!/bin/bash

Bucket=$1

aws lambda publish-layer-version --layer-name aws-cli-layer --content S3Bucket=${Bucket},S3Key=aws_cli_layer.zip
