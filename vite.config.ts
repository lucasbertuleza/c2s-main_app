import eslintPlugin from '@nabla/vite-plugin-eslint';
import { resolve } from 'path';
import { defineConfig } from 'vite';
import checker from 'vite-plugin-checker';
import ViteRails from 'vite-plugin-rails';
import sassGlobImports from 'vite-plugin-sass-glob-import';
import tsconfigPaths from 'vite-tsconfig-paths';
import react from '@vitejs/plugin-react';

function sourceCodeDir(pathOrPattern: string = ''): string {
  return resolve(__dirname, 'app/frontend', pathOrPattern);
}

export default defineConfig({
  clearScreen: true,
  css: {
    devSourcemap: true,
  },
  plugins: [
    checker({
      eslint: {
        lintCommand: `eslint "${sourceCodeDir('**/*.{ts,js,tsx,jsx}')}"`,
      },
    }),
    eslintPlugin({
      eslintOptions: { cache: true, fix: true },
      shouldLint: (path) =>
        !!path.match(new RegExp(`${sourceCodeDir()}\/[^?]*\.(vue|svelte|m?[jt]sx?)$`)),
    }),
    react(),
    sassGlobImports(),
    tsconfigPaths(),
    ViteRails({ fullReload: { delay: 200 }, compress: { gzip: false } }),
  ],
  resolve: {
    alias: {
      '@components': sourceCodeDir('components'),
      '@fonts': sourceCodeDir('fonts'),
      '@icons': sourceCodeDir('icons'),
      '@images': sourceCodeDir('images'),
      '@pages': sourceCodeDir('pages'),
      '@stylesheets': sourceCodeDir('stylesheets'),
      '@utils': sourceCodeDir('utils')
    },
  },
  server: {
    host: true,
    strictPort: true,
    hmr: { host: 'localhost', protocol: 'ws' },
  },
});
