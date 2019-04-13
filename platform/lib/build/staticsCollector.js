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

/* eslint-disable no-invalid-this */
'use strict';

require('module-alias/register');

const {Signale} = require('signale');
const gulp = require('gulp');
const through = require('through2');
const fileType = require('file-type');
const archiver = require('archiver');
const fs = require('fs');
const path = require('path');
const del = require('del');

const utils = require('@lib/utils');

/* Source paths of files that should be collected */
const STATICS_SRC = [
  utils.project.absolute('pages/static/**/*'),
  utils.project.absolute('examples/static/**/*'),
];
/* Path where all collected static files should be written to */
const STATIC_DEST = utils.project.absolute('platform/static');
/* The zip mime type to compare against */
const ZIP_TYPE = 'application/zip';

class StaticsCollector {
  constructor() {
    this._log = new Signale({
      'scope': 'Statics Collector',
    });

    // Keep track of archive handles to finish them when stream ends
    this._files = {
      'archives': {},
    };
  }

  /**
   * Returns a Gulp stream with all static files that matched. While piping the
   * files folders that end on .zip will automatically be packed up as a ZIP
   * @return {Stream}
   */
  start() {
    this._log.await('Collecting static files ...');

    // Ugly but needed to keep scope for .pipe
    const scope = this;
    const stream = gulp.src(STATICS_SRC)
        .pipe(through.obj(async function(file, encoding, callback) {
          // Check if file should be part of ZIP and not already is
          // one itself
          if (file.path.includes('.zip')) {
            const type = file.contents ? fileType(file.contents) : null;
            if (file.stat.isDirectory() || (type && type.mime == ZIP_TYPE)) {
              callback();
              return;
            }

            scope._zip(file, callback);
            return;
          }

          // ... and simply copy all other files
          this.push(file);
          callback();
        }))
        .pipe(gulp.dest(STATIC_DEST));

    stream.on('end', this._onEnd.bind(this));
    return stream;
  }

  /**
  * Watches the static directories for changes and collects them
   * @return {undefined}
   */
  watch() {
    gulp.watch(STATICS_SRC, this.start.bind(this));
  }

  /**
   * Finds the parent path from a vinyl ending with .zip and puts
   * all deeper levels into a ZIP file that is written to STATIC_DEST
   * @param  {Vinyl} file     The vinyl file from the gulp stream
   * @param  {Stream} stream   The initial stream
   * @param  {Function} callback Callback to call after ZIP
   * @return {undefined}
   */
  _zip(file, callback) {
    const relativePath = file.relative.slice(0, file.relative.indexOf('.zip')) + '.zip';
    const archive = this._files.archives[relativePath] || archiver('zip', {
      'zlib': {'level': 9},
    });

    // Only append real files, directories will be created automatically
    const filePath = file.relative.replace(relativePath, '');
    if (!file.stat.isDirectory() && filePath) {
      archive.append(file.contents, {'name': filePath});
    }

    this._files.archives[relativePath] = archive;
    callback();
  }

  /**
   * Takes care of finalizing created archives and writing them to disk
   * together with the normalized inventory
   * @return {undefined}
   */
  async _onEnd() {
    const archives = [];

    for (const archivePath of Object.keys(this._files.archives)) {
      const contents = this._files.archives[archivePath];
      contents.finalize();

      // Make sure the destination is writable
      const dest = path.join(STATIC_DEST, archivePath);
      del.sync(dest);

      const archive = fs.createWriteStream(dest);
      archives.push(new Promise((resolve, reject) => {
        contents.pipe(archive).on('close', () => {
          this._log.success(`Wrote archive ${archivePath}`);
          resolve();
        });
      }));
    };

    await Promise.all(archives);
    this._log.complete('Finished collecting static files.');
  }
}

if (!module.parent) {
  (async () => {
    const staticsCollector = new StaticsCollector();
    staticsCollector.start();
  })();
}

module.exports = {
  staticsCollector: new StaticsCollector(),
};
