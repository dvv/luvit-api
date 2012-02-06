

local bbb = require('bbb')

--[[
Extender module
]]
local foo = require('./good')

Foo.bar1 = 1
-- overloaded
function Foo:baz1() end
-- overloaded
function Foo.bam1() end

Foo.bar1.fu1 = 2

return foo
