/** @type {import("eslint").ESLint.ConfigData} */
module.exports = {
  root: true,

  // Global config
  env: {
    browser: true,
    es2022: true,
  },
  extends: [
    'airbnb',
    'airbnb/hooks',
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:react/jsx-runtime',
    'plugin:react-hooks/recommended',
    'plugin:prettier/recommended',
  ],
  parserOptions: {
    sourceType: 'module',
    ecmaFeatures: { jsx: true },
    ecmaVersion: 'latest',
  },
  plugins: ['@typescript-eslint', 'prettier', 'react-refresh', 'import'],
  rules: {
    'prettier/prettier': 'error',
    'max-len': [
      'error',
      {
        code: 100,
        tabWidth: 2,
        comments: 80,
        ignoreComments: false,
        ignoreTrailingComments: false,
      },
    ],
    'import/no-unresolved': 'error',
    'react-refresh/only-export-components': ['warn', { allowConstantExport: true }],
  },
  settings: {
    'import/resolver': {
      alias: {
        map: [
          ['@', './app/frontend'],
          ['~', './app/frontend'],
          ['@components', './app/frontend/components'],
          ['@fonts', './app/frontend/fonts'],
          ['@icons', './app/frontend/icons'],
          ['@images', './app/frontend/images'],
          ['@pages', './app/frontend/pages'],
          ['@stylesheets', './app/frontend/stylesheets'],
          ['@utils', './app/frontend/utils'],
        ],
      },
    },
    react: { version: '18.3' },
  },

  // Configuration Based on Glob Patterns
  // https://eslint.org/docs/latest/use/configure/configuration-files
  overrides: [
    {
      env: {
        node: true,
      },
      files: ['.eslintrc.{js,cjs}'],
      parserOptions: {
        sourceType: 'script',
      },
    },
    // TypeScript files
    {
      files: ['app/frontend/**/*.{ts,tsx}'],
      extends: [
        'airbnb',
        'airbnb/hooks',
        'airbnb-typescript',
        'eslint:recommended',
        'plugin:@typescript-eslint/strict-type-checked',
        'plugin:@typescript-eslint/stylistic-type-checked',
        'plugin:prettier/recommended',
      ],
      parser: '@typescript-eslint/parser',
      parserOptions: {
        project: './tsconfig.json',
        tsconfigRootDir: __dirname,
      },
      rules: {
        '@typescript-eslint/explicit-function-return-type': 'error',
      },
      settings: {
        'import/parsers': {
          '@typescript-eslint/parser': ['.ts', '.tsx'],
        },
        'import/resolver': {
          typescript: {
            alwaysTryTypes: true,
          },
        },
      },
    },
  ],
};
