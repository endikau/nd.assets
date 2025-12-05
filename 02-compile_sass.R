path_assets_dir <- local({
  .path_here <- here::here()
  stopifnot(stringi::stri_detect_regex(.path_here, "/nd\\.assets/?"))
  .path_assets_dir <- fs::path(.path_here, "dist")
  stopifnot(fs::dir_exists(.path_assets_dir))
  return(.path_assets_dir)
})

path_css <- local({
  .path_css <- fs::path(path_assets_dir, "css")
  if(fs::dir_exists(.path_css)){fs::dir_delete(.path_css)}
  fs::dir_create(.path_css)
  return(.path_css)
})

sass::sass(
  input=sass::sass_file(
    fs::path(path_assets_dir, "scss", "nd_site.scss")
  ),
  output=fs::path(path_css, "nd_site.css"),
  cache=NULL
)