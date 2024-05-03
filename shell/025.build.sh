#!/bin/bash

AccountID=`aws sts get-caller-identity | jq -r '.Account'`
rm dist/function.zip
chmod 755 ./bootstrap
chmod 755 ./function.sh
chmod 755 ./jq
zip dist/function.zip function.sh bootstrap jq
