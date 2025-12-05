# nd.assets

Static front-end assets for EnDiKaU sites bundled as an npm package (via GitHub Packages). The package ships everything under `dist/` (CSS, JS helpers, SCSS sources, vendored dependencies, fonts, and images).

## Install from GitHub Packages
- Add to your `~/.npmrc` (or project-local `.npmrc`):
  ```
  @endikau:registry=https://npm.pkg.github.com
  //npm.pkg.github.com/:_authToken=YOUR_GITHUB_PAT
  ```
- Install: `npm install @endikau/nd-assets`
