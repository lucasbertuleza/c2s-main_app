/**
 * https://prettier.io/docs/en/options
 * https://prettier.io/docs/en/configuration#editorconfig
 *
 * @type {import("prettier").Options}
 */
module.exports = {
  trailingComma: 'es5',
  editorconfig: true,
  semi: true,
  singleQuote: true,
  importOrderSeparation: true,
  importOrderSortSpecifiers: true,
  importOrderGroupNamespaceSpecifiers: true,
  importOrder: ['^react$', '<THIRD_PARTY_MODULES>', '^components|assets(.*)$', '^[./]'],
};
