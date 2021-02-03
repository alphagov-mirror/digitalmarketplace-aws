#!/bin/bash
set -eou pipefail

function validate() {
  validate_path=$1

  echo $validate_path
  cd $validate_path

  if [ ! -e .terraform ]
  then
    terraform init -backend=false
  fi

  terraform validate
  cd - > /dev/null
}

for account in terraform/accounts/*
do
  validate $account
done

for environment in terraform/environments/*
do
  validate $environment
done
