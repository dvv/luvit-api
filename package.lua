return {
  name = "api",
  version = "0.0.1",
  description = "Build API documentation from sources",
  author = "Vladimir Dronnikov <dronnikov@gmail.com>",
  dependencies = {
    ["meta-fs"] = "https://github.com/dvv/luvit-meta-fs/zipball/master",
  },
  main = "api.lua",
  bin = {
    api = "api",
  },
}
