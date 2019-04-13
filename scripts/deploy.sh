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

cd $(dirname $0)/..

root=$(pwd)
args=$*

# Import artifacts from previous build stages if running on Travis
if [ -n "$TRAVIS_BUILD_NUMBER" ]; then
  echo "Fetching artifacts (Imported docs, built samples, built pages, ...) from Google Cloud Storage ..."
  echo -e "travis_fold:start:fetch\n"

  mkdir -p artifacts
  gsutil rsync -r gs://us.artifacts.amp-dev-staging.appspot.com/travis/$TRAVIS_BUILD_NUMBER/ $root/artifacts/

  # Unzip all loaded artifacts
  for filename in artifacts/*.zip; do
    [ -e "$filename" ] || continue
    unzip -o -q -d . $filename
  done
  echo -e "travis_fold:end:fetch\n"
fi

# Persist Travis information in config to identify build via /who-am-i
if [ -n "$TRAVIS_BUILD_NUMBER" ]; then
  sed -i -e "s/TRAVIS_BUILD_NUMBER/${TRAVIS_BUILD_NUMBER}/g" $root/platform/config/build-info.yaml
  sed -i -e "s/TRAVIS_COMMIT_MESSAGE/${TRAVIS_COMMIT_MESSAGE}/g" $root/platform/config/build-info.yaml
  sed -i -e "s/TRAVIS_COMMIT/${TRAVIS_COMMIT}/g" $root/platform/config/build-info.yaml
fi

gcloud app deploy --project=amp-dev-staging --quiet
