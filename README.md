# ND Assets (GitHub Packages)

Static front-end assets for ND sites bundled as an npm package (via GitHub Packages). The package ships everything under `dist/` (CSS, JS helpers, SCSS sources, vendored dependencies, fonts, and images).

## Install from GitHub Packages
- Add to your `~/.npmrc` (or project-local `.npmrc`):
  ```
  @m-pilarski:registry=https://npm.pkg.github.com
  //npm.pkg.github.com/:_authToken=YOUR_GITHUB_PAT
  ```
  The token needs `read:packages` to consume and `write:packages` to publish.
- Install: `npm install @m-pilarski/nd-assets`

## Using the assets
- Node helper:
  ```js
  const { distPath, vendorPath, fontsPath, cssPath, jsPath, scssPath, imgPath } = require('@m-pilarski/nd-assets');
  ```
- Serve as static files (example with Express):
  ```js
  const express = require('express');
  const app = express();
  const { distPath } = require('@m-pilarski/nd-assets');

  app.use('/nd-assets', express.static(distPath));
  ```
- Direct file paths (after install):
  - CSS: `node_modules/@m-pilarski/nd-assets/dist/css/nd_site.css`
  - JS helpers: `node_modules/@m-pilarski/nd-assets/dist/js/*.js`
  - SCSS sources: `node_modules/@m-pilarski/nd-assets/dist/scss/`
  - Vendor bundles: `node_modules/@m-pilarski/nd-assets/dist/vendor`
  - Fonts: `node_modules/@m-pilarski/nd-assets/dist/fonts`
  - Images: `node_modules/@m-pilarski/nd-assets/dist/img`

## Publish workflow
1. Refresh the built assets (run the existing R scripts or other pipeline to update `dist/`).
2. Bump the version: `npm version patch` (or `minor`/`major`).
3. Publish to GitHub Packages: `npm publish`.
4. Consumers pull updates with `npm install @m-pilarski/nd-assets@<version>` after registry/auth is configured.
