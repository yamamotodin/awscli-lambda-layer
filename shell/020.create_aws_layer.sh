#!/bin/bash
if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには1個の引数が必要です。" 1>&2
  echo "$0 [S3 Bucket]"
  exit 1
fi
Bucket=$1
aws lambda publish-layer-version --layer-name aws-cli-layer --content S3Bucket=${Bucket},S3Key=aws_cli_layer.zip
