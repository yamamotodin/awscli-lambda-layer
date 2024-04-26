#!/bin/bash

os=`uname -s`
arch=`uname -m`
BUCKET_NAME=$1

if [ -e dist/aws_cli_layer.zip ]; then
  echo "target file dist/aws_cli_layer.zip is exists, transfer to S3."
  aws s3 cp dist/aws_cli_layer.zip s3://$BUCKET_NAME/
  exit
fi

if [ $os != "Linux" -o $arch != "x86_64" ]; then
  echo "error: your environment is not fill for build. Required: OS=Linux and CPU=x86_64."
  echo "advice: Get aws_cli_layer.zip and put that file into dist/aws_cli_layer.zip then you can skip this shell."
  exit 1
fi

if [ ! -e dist/awscliv2.zip ]; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o dist/awscliv2.zip
fi

cd dist/
unzip awscliv2.zip
mkdir aws_cli_layer
./aws/install -i ./aws_cli_layer/aws-cli -b ./aws_cli_layer/aws-bin
mkdir -p bin
cp -r ./aws_cli_layer/aws-cli/v2/2.*/dist/* ./bin
zip -r9 aws_cli_layer.zip bin

aws s3 cp dist/aws_cli_layer.zip s3://${BUCKET_NAME}/

cd ..
