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

# Build boilerplate and playground ...
echo "Building boilerplate ..."
echo -e "travis_fold:start:boilerplate\n"
cd $root/boilerplate && node build.js
echo -e "travis_fold:end:boilerplate\n"

echo "Building playground ..."
echo -e "travis_fold:start:playground\n"
cd $root && npm run build:playground
echo -e "travis_fold:end:playground\n"

# Build samples
cd $root && node platform/lib/build/samplesBuilder.js

# Import documents
cd $root && node platform/lib/pipeline/componentReferenceImporter.js
cd $root && node platform/lib/pipeline/specImporter.js
cd $root && node platform/lib/pipeline/roadmapImporter.js

# Store new (built or imported) data in GCS if on Traivs
if [ -n "$TRAVIS_BUILD_NUMBER" ]; then
  echo "Storing artifacts in Google Cloud Storage ..."
  echo -e "travis_fold:start:store\n"
  cd $root
  mkdir -p artifacts

  # ZIP artifacts to speed up transfer
  zip -r artifacts/setup.zip pages/content dist boilerplate/dist playground/dist .cache
  gsutil cp $root/artifacts/setup.zip gs://us.artifacts.amp-dev-staging.appspot.com/travis/$TRAVIS_BUILD_NUMBER/setup.zip
  echo -e "travis_fold:end:store\n"
fi
