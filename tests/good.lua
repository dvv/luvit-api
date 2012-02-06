

local aaa = require('aaa')

--[[
Sample module
]]
local foo = {}
local Foo = {}
foo.Foo = Foo

Foo.bar = 1
--
-- this
-- is also
-- a block comment
--
function Foo:baz() end
function Foo.bam() end

-- fake, number with property?!
Foo.bar.fu = 2

return foo
