return {
  name = "api",
  version = "0.0.1",
  description = "Build API documentation from sources",
  author = "Vladimir Dronnikov <dronnikov@gmail.com>",
  dependencies = {
    kernel = "https://github.com/luvit/kernel/zipball/master",
  },
  main = "api.lua",
  bin = {
    api = "api.lua",
  },
}
