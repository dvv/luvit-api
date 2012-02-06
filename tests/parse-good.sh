#!/bin/sh
../api.lua --json good.lua better.lua >api.json
../api.lua good.lua better.lua >api.markdown
