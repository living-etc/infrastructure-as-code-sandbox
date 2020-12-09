#! /usr/bin/env bash

set -euo pipefail

set +e
aws --profile personal --region eu-west-1 cloudformation describe-stacks --stack-name cloudformation-vpc
STACK_EXISTS=$( echo $? )
set -e

if [ ${STACK_EXISTS} == 0 ]; then
  aws --profile personal --region eu-west-1 cloudformation update-stack --stack-name cloudformation-vpc --template-body file://vpc.yaml
else
  aws --profile personal --region eu-west-1 cloudformation create-stack --stack-name cloudformation-vpc --template-body file://vpc.yaml
fi
