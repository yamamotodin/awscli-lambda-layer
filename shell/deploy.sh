#!/bin/bash
PROJECT_NAME=$1
STAGE=$2
FUNCTION_NAME=${PROJECT_NAME}-${STAGE}

sh shell/050.update_lambda_function.sh $FUNCTION_NAME
