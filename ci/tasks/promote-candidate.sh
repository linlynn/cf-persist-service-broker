#!/usr/bin/env bash

set -e -x

source cf-persist-service-broker/ci/tasks/util.sh

# Creates an integer version number from the semantic version format
# May be changed when we decide to fully use semantic versions for releases
export integer_version=`cut -d "." -f1 version-semver/version`
cp -r cf-persist-service-broker promote/cf-persist-service-broker

echo ${integer_version} > promote/number
echo ${tag_message} >> promote/cf-persist-service-broker/release_log.txt
pushd promote/cf-persist-service-broker/
  git config --global user.email emccmd-eng@emc.com
  git config --global user.name EMCCMD-CI
  git commit -m ":airplane: New final release v ${integer_version}" -m "[ci skip]"
popd
