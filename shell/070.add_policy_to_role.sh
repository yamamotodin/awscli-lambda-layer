#!/bin/bash

ROLE_NAME=$1

aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn arn:aws:iam::aws:policy/AutoScalingFullAccess
