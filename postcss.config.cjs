/* eslint-disable global-require, import/no-extraneous-dependencies */
/** @type {import('postcss-load-config').Config} */
module.exports = {
  plugins: [
    require('postcss-normalize')({ forceImport: true }),
    require('postcss-nested'),
    require('autoprefixer'),
    require('cssnano')({ preset: 'default', plugins: ['autoprefixer'] }),
  ],
};
