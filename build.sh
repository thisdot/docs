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

root=$(pwd)
args=$*

# Verify a valid NODE_ENV has been set for build
if [ -z "$NODE_ENV" ]
then
  echo "You need to set a valid NODE_ENV variable to build amp.dev!"
  exit 1
fi

# Only build boilerplate if configured via --boilerplate
if [[ $args = *"boilerplate"* ]]
then
  echo "Building boilerplate ..."
  cd $root/boilerplate && node build.js
fi

# Only build playground if configured via --playground
if [[ $args = *"playground"* ]]
then
  cd $root && npm run build:playground
fi

cd $root/platform && node build.js --clean-samples $*
