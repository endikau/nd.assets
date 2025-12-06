path_vendor <- local({
  .path_here <- here::here()
  stopifnot(stringi::stri_detect_regex(.path_here, "/nd\\.assets/?"))
  .path_vendor <- fs::path(.path_here, "assets", "vendor")
  if(fs::dir_exists(.path_vendor)){fs::dir_delete(.path_vendor)}
  fs::dir_create(.path_vendor)
  return(.path_vendor)
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "fontawesome")
  gert::git_clone("git@github.com:FortAwesome/Font-Awesome.git", .path_git_tmp)
  # 6.6.0 release
  gert::git_reset_hard(
    ref="37eff7fa00de26db41183a3ad8ed0e9119fbc44b", repo=I(.path_git_tmp)
  )
  fs::dir_create(fs::path(.path_lib_tmp, c("js")))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE.txt"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "js", "all.min.js"), 
    fs::path(.path_lib_tmp, "js", "all.min.js")
  )
  fs::dir_copy(
    fs::path(.path_git_tmp, "svgs"), 
    .path_lib_tmp
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "wordcloud2")
  gert::git_clone("git@github.com:timdream/wordcloud2.js.git", .path_git_tmp)
  # version 2023-07-19
  gert::git_reset_hard(
    ref="61e1a11265fb4be60a9ccd64558b1231ce4a3a72", repo=I(.path_git_tmp)
  )
  fs::dir_create(fs::path(.path_lib_tmp, c("js")))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "src", "wordcloud2.js"),
    fs::path(.path_lib_tmp, "js", "wordcloud2.js")
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "twemoji")
  gert::git_clone("git@github.com:jdecked/twemoji.git", .path_git_tmp)
  # version 15.1.0
  gert::git_reset_hard(
    ref="7407fa31c51be5ab45626b8ab5554d50cc8073f6", repo=I(.path_git_tmp)
  )
  processx::run("npm", c("prune"), wd=.path_git_tmp)
  processx::run("npm", c("run", "build"), wd=.path_git_tmp)
  fs::dir_create(fs::path(.path_lib_tmp, c("js")))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "twemoji.min.js"),
    fs::path(.path_lib_tmp, "js", "twemoji.min.js")
  )
  fs::dir_copy(
    fs::path(.path_git_tmp, "dist", "svg"), 
    .path_lib_tmp
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "jquery")
  gert::git_clone("git@github.com:jquery/jquery.git", .path_git_tmp)
  # version 3.7.1
  gert::git_reset_hard(
    ref="f79d5f1a337528940ab7029d4f8bbba72326f269", repo=I(.path_git_tmp)
  )
  processx::run("npm", "prune", wd=.path_git_tmp)
  processx::run("npm", c("run", "build"), wd=.path_git_tmp)
  fs::dir_create(fs::path(.path_lib_tmp, "js"))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE.txt"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "jquery.min.js"), 
    fs::path(.path_lib_tmp, "js", "jquery.min.js")
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "iframe-resizer")
  gert::git_clone(
    "git@github.com:davidjbradshaw/iframe-resizer.git", .path_git_tmp
  )
  # version 5.3.1
  gert::git_reset_hard(
    ref="251d7421476d439f7542e117e937a93374b56c39", repo=I(.path_git_tmp)
  )
  processx::run("npm", "prune", wd=.path_git_tmp)
  processx::run("npm", c("run", "build:latest"), wd=.path_git_tmp)
  fs::dir_create(fs::path(.path_lib_tmp))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::dir_copy(
    fs::path(.path_git_tmp, "js"), 
    .path_lib_tmp
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "bootstrap")
  gert::git_clone("git@github.com:twbs/bootstrap.git", .path_git_tmp)
  # 5.3.3 release
  gert::git_reset_hard(
    ref="6e1f75f420f68e1d52733b8e407fc7c3766c9dba", repo=I(.path_git_tmp)
  )
  fs::dir_create(fs::path(.path_lib_tmp, c("js", "scss")))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "js", "bootstrap.bundle.min.js"),
    fs::path(.path_lib_tmp, "js", "bootstrap.bundle.min.js")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "js", "bootstrap.bundle.min.js.map"),
    fs::path(.path_lib_tmp, "js", "bootstrap.bundle.min.js.map")
  )
  fs::dir_copy(
    fs::path(.path_git_tmp, "scss/"), 
    .path_lib_tmp
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "d3")
  gert::git_clone("git@github.com:d3/d3.git", .path_git_tmp)
  # 7.9.0 release
  gert::git_reset_hard(
    ref="1f8dd3b92960f58726006532c11e9457864513ec", repo=I(.path_git_tmp)
  )
  processx::run("npm", "prune", wd=.path_git_tmp)
  processx::run("npm", "install", wd=.path_git_tmp)
  fs::dir_create(fs::path(.path_lib_tmp, "js"))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "node_modules", "d3", "dist", "d3.min.js"),
    fs::path(.path_lib_tmp, "js", "d3.min.js")
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "d3-cloud")
  gert::git_clone("git@github.com:jasondavies/d3-cloud.git", .path_git_tmp)
  # 1.2.7 release
  gert::git_reset_hard(
    ref="deea7d7165a4304d8eb123bd6b0e07aaae77ebea", repo=I(.path_git_tmp)
  )
  fs::dir_create(fs::path(.path_lib_tmp, "js"))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "build", "d3.layout.cloud.js"),
    fs::path(.path_lib_tmp, "js", "d3.layout.cloud.js")
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "headroom")
  gert::git_clone("git@github.com:WickyNilliams/headroom.js.git", .path_git_tmp)
  # 0.11.0 release
  gert::git_reset_hard(
    ref="0e00cb6aeeceb3aa83ade314f2055ec7af2118e5", repo=I(.path_git_tmp)
  )
  processx::run("npm", "prune", wd=.path_git_tmp)
  processx::run("npm", "install", wd=.path_git_tmp)
  processx::run("npm", c("run", "build"), wd=.path_git_tmp)
  fs::dir_create(fs::path(.path_lib_tmp, "js"))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"), 
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "headroom.js"),
    fs::path(.path_lib_tmp, "js", "headroom.js")
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "masonry")
  gert::git_clone("git@github.com:desandro/masonry.git", .path_git_tmp)
  # 0.11.0 release
  gert::git_reset_hard(
    ref="3b0883cf4a4a046896719b9cf282ea74be7ffecd", repo=I(.path_git_tmp)
  )
  processx::run("npm", "prune", wd=.path_git_tmp)
  processx::run("npm", "install", wd=.path_git_tmp)
  fs::dir_create(fs::path(.path_lib_tmp, "js"))
  # fs::file_copy(
  #   fs::path(.path_git_tmp, "LICENSE"),
  #   fs::path(.path_lib_tmp, "LICENSE")
  # )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "masonry.pkgd.js"),
    fs::path(.path_lib_tmp, "js", "masonry.pkgd.js")
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "glider")
  gert::git_clone("git@github.com:NickPiscitelli/Glider.js.git", .path_git_tmp)
  # 0.11.0 release
  gert::git_reset_hard(
    ref="1358051cce3b9ae63c55aecb97d97c4fd56796f1", repo=I(.path_git_tmp)
  )
  fs::dir_create(fs::path(.path_lib_tmp, "js"))
  fs::dir_create(fs::path(.path_lib_tmp, "css"))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE.txt"),
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "glider.js"),
    fs::path(.path_lib_tmp, "js", "glider.js")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "glider.css"),
    fs::path(.path_lib_tmp, "css", "glider.css")
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "glider")
  gert::git_clone("git@github.com:NickPiscitelli/Glider.js.git", .path_git_tmp)
  # 0.11.0 release
  gert::git_reset_hard(
    ref="1358051cce3b9ae63c55aecb97d97c4fd56796f1", repo=I(.path_git_tmp)
  )
  fs::dir_create(fs::path(.path_lib_tmp, "js"))
  fs::dir_create(fs::path(.path_lib_tmp, "css"))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE.txt"),
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "glider.js"),
    fs::path(.path_lib_tmp, "js", "glider.js")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "glider.css"),
    fs::path(.path_lib_tmp, "css", "glider.css")
  )
})


local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "glider")
  gert::git_clone("git@github.com:NickPiscitelli/Glider.js.git", .path_git_tmp)
  # 0.11.0 release
  gert::git_reset_hard(
    ref="1358051cce3b9ae63c55aecb97d97c4fd56796f1", repo=I(.path_git_tmp)
  )
  fs::dir_create(fs::path(.path_lib_tmp, "js"))
  fs::dir_create(fs::path(.path_lib_tmp, "css"))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE.txt"),
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "glider.js"),
    fs::path(.path_lib_tmp, "js", "glider.js")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "glider.css"),
    fs::path(.path_lib_tmp, "css", "glider.css")
  )
})

local({
  .path_git_tmp <- fs::file_temp(pattern="git")
  .path_lib_tmp <- fs::path(path_vendor, "glide")
  gert::git_clone("git@github.com:glidejs/glide.git", .path_git_tmp)
  # 0.11.0 release
  gert::git_reset_hard(
    ref="03e7f39d3bb4a5fe9c9dd609872113e3a3329afc", repo=I(.path_git_tmp)
  )
  processx::run("npm", "prune", wd=.path_git_tmp)
  processx::run("npm", "install", wd=.path_git_tmp)
  processx::run("npm", c("run", "build"), wd=.path_git_tmp)
  fs::dir_create(fs::path(.path_lib_tmp, "js"))
  fs::dir_create(fs::path(.path_lib_tmp, "css"))
  fs::file_copy(
    fs::path(.path_git_tmp, "LICENSE"),
    fs::path(.path_lib_tmp, "LICENSE")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "glide.js"),
    fs::path(.path_lib_tmp, "js", "glide.js")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "css", "glide.core.css"),
    fs::path(.path_lib_tmp, "css", "glide.core.css")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "css", "glide.core.css.map"),
    fs::path(.path_lib_tmp, "css", "glide.core.css.map")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "css", "glide.theme.css"),
    fs::path(.path_lib_tmp, "css", "glide.theme.css")
  )
  fs::file_copy(
    fs::path(.path_git_tmp, "dist", "css", "glide.theme.css.map"),
    fs::path(.path_lib_tmp, "css", "glide.theme.css.map")
  )
})
