/**
 * Copyright 2019 The AMP HTML Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS-IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

'use strict';

const {series} = require('gulp');
const {sh} = require('@lib/utils/sh');
const mri = require('mri');
const del = require('del');
const {project} = require('@lib/utils');


/**
 * Cleans all directories/files that get created by any of the following
 * tasks
 *
 * @return {undefined}
 */
function clean() {
  return del([
    project.absolute('dist'),
    project.absolute('build'),

    project.absolute('boilerplate/dist'),

    project.absolute('pages/css'),
    project.absolute('pages/extensions/**/*.pyc'),
    project.absolute('pages/icons'),
    project.absolute('pages/layouts'),
    project.absolute('pages/macros'),
    project.absolute('pages/views'),
    project.absolute('pages/.depcache.json'),
    project.absolute('pages/podspec.yaml'),

    project.absolute('platform/pages'),
    project.absolute('platform/static'),

    project.absolute('playground/dist'),
  ], {'force': true});
}


exports.clean = clean;
