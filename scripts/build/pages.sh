#!/bin/bash
#
# Copyright 2019 The AMP HTML Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS-IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the license.

# Exit if one of the below commands fails
set -e

cd $(dirname $0)/../..

root=$(pwd)
args=$*

# Verify a valid NODE_ENV has been set for build
if [ -z "$NODE_ENV" ]
then
  echo "You need to set a valid NODE_ENV variable to build amp.dev!"
  exit 1
fi

mkdir -p artifacts

# Import artifacts from previous build stage if running on Travis
if [ -n "$TRAVIS_BUILD_NUMBER" ]; then
  echo "Fetching artifacts (Imported docs, built samples, ...) from Google Cloud Storage ..."
  echo -e "travis_fold:start:fetch\n"

  gsutil cp gs://us.artifacts.amp-dev-staging.appspot.com/travis/$TRAVIS_BUILD_NUMBER/setup.zip $root/artifacts/setup.zip

  # Unzip artifacts and overwrite possibly existing files
  unzip -o -q -d . artifacts/setup.zip
  echo -e "travis_fold:end:fetch\n"
fi

echo "Building pages ..."
echo -e "travis_fold:start:pages\n"
cd $root/platform && node build.js $*
echo -e "travis_fold:end:pages\n"

cd $root

# Upload built pages to GCS if on Travis
if [ -n "$TRAVIS_BUILD_NUMBER" ]; then
  echo "Uploading built pages to Google Cloud Storage ..."
  echo -e "travis_fold:start:store\n"

  # ZIP artifacts to speed up transfer
  zip -r artifacts/pages-$TRAVIS_JOB_NUMBER.zip platform/pages
  gsutil cp $root/artifacts/pages-$TRAVIS_JOB_NUMBER.zip gs://us.artifacts.amp-dev-staging.appspot.com/travis/$TRAVIS_BUILD_NUMBER/pages-$TRAVIS_JOB_NUMBER.zip
  echo -e "travis_fold:end:store\n"
fi
