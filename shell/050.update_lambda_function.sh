#!/bin/bash
if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには1個の引数が必要です。" 1>&2
  echo "$0 [LambdaFunctionName]"
  exit 1
fi
FunctionName=$1
sh shell/025.build.sh

aws lambda update-function-code \
    --function-name ${FunctionName} \
    --zip-file fileb://dist/function.zip
