#! /usr/bin/env bash

set -euo pipefail

aws --profile personal --region eu-west-1 cloudformation deploy --stack-name cloudformation-vpc --template-body file://vpc.yaml
