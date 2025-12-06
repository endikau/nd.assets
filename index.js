const path = require('path');

const distPath = path.join(__dirname, 'dist');

const resolveDist = (...segments) => path.join(distPath, ...segments);

module.exports = {
  distPath,
  vendorPath: resolveDist('vendor'),
  fontsPath: resolveDist('fonts'),
  cssPath: resolveDist('css'),
  jsPath: resolveDist('js'),
  scssPath: resolveDist('scss'),
  imgPath: resolveDist('img'),
  resolveDist
};
