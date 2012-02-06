#!/usr/bin/env luvit

local Table = require('table')
local Path = require('path')
local JSON = require('json')
local Fs = require('fs')

local Object = require('core').Object
local API = Object:extend()

--
-- a simple command line arguments parser
-- N.B. it's bundled version of stripped down dvv/luvit-cmdline
--
local function parseArguments(argv)
  if not argv then argv = process.argv end
  local opts = {}
  local args = {}
  for i, arg in ipairs(argv) do
    local opt = arg:match("^%-%-(.*)")
    if opt then
      local key, value = opt:match("([a-z_%-]*)=(.*)")
      if value then
        if type(opts[key]) == 'string' then
          opts[key] = { opts[key], value }
        elseif type(opts[key]) == 'table' then
          opts[key][#opts[key] + 1] = value
        else
          opts[key] = value
        end
      elseif opt ~= '' then
        opts[opt] = true
      else
        for i = i + 1, #argv do
          args[#args + 1] = argv[i]
        end
        break
      end
    else
      args[#args + 1] = arg
    end
  end
  return opts, args
end

--
-- parser constructor
--
function API:initialize(...)
  self.items = {}
end

--
-- parse one file
--
function API:parseFile(path, callback)

  Fs.readFile(path, function (err, text)
    if not text then callback(err) ; return end

    -- tags to number lines of text
    -- TODO: nonce?
    local number_head = '~~~<<<'
    local number_tail = '>>>~~~'
    local number_tag = number_head .. '(%d+)' .. number_tail

    local name_re = '([_%w.:]*)'

    -- ensure final EOL
    -- FIXME: ensure we need this
    if text:sub(-1, -1) ~= '\n' then text = text .. '\n' end

    -- number the lines
    local numbered
    do
      local lnum = 0
      numbered = text:gsub('\n', function ()
        lnum = lnum + 1
        return number_head .. lnum .. number_tail .. '\n'
      end)
    end

    -- table of seen items
    local items = {}

    -- define module
    local module = {
      requires = {},
      items = items,
    }

    -- guess exports table
    for name, line in numbered:gmatch('\nreturn ' .. name_re .. '[^\n]*' .. number_tag) do
      module.name = name
      local item = {
        line = line,
        type = 'module',
        name = name,
      }
      items[name] = item
    end

    -- collect requires
    for name, value, line in numbered:gmatch('\nlocal ' .. name_re .. ' = require(%b())[^\n]*' .. number_tag) do
      module.requires[name] = value:sub(3, -3)
    end

    -- helper to compose the full name of an item
    local function full_name(name)
      if not module.name or name:find('^' .. module.name .. '%.') then
        return name
      else
        return module.name .. '.' .. name
      end
    end

    -- collect classes
    for name, extends, line in numbered:gmatch('\nlocal ' .. name_re .. ' = ' .. name_re .. ':extend%b()[^\n]*' .. number_tag) do
      local item = {
        line = line,
        type = 'class',
        name = full_name(name),
        meta = {},
        extends = extends:find('.', 1, true) and extends or full_name(extends),
      }
      items[item.name] = item
    end

    -- collect exported module-level functions
    -- `function MODULE.func(args)` form
    for name, args, line in numbered:gmatch('\nfunction ' .. name_re .. '(%b())[^\n]*' .. number_tag) do
      local item = {
        line = line,
        type = 'function',
        name = full_name(name),
        args = args:sub(2, -2),
      }
      items[item.name] = item
    end

    -- collect exposed properties
    for name, value, line in numbered:gmatch('\n' .. name_re .. ' = (.-)[^\n]*' .. number_tag) do
      local item = {
        line = line,
        type = 'property',
        name = full_name(name),
      }
      if value:find('function', 1, true) ~= 1 and not items[item.name] then
        items[item.name] = item
      end
    end

    -- collect block comments
    for text, line in numbered:gmatch('\n%-%-%[(%b[])%]' .. number_tag) do
      local item = {
        line = line,
        type = 'comment',
        text = text:gsub(number_tag, ''):sub(2, -2):gsub('^\n+', ''):gsub('\n+$', ''),
      }
      -- N.B. the first block comment is module description
      if not module.doc then
        module.doc = item.text
      else
        -- N.B. line number starts with digit, hence no clashes to other items
        items[line] = item
      end
    end

    -- collect single line comments
    for text, line in numbered:gmatch('\n%-%-%s+(.-)%s*' .. number_tag) do
      -- N.B: we glue adjacent comments
      local prev = tostring(line - 1)
      -- if previous line also contained comment
      if items[prev] and items[prev].type == 'comment' then
        -- glue previous line and this comment
        text = items[prev].text .. '\n' .. text
        -- and forget about previous line
        items[prev] = nil
      end
      local item = {
        line = line,
        type = 'comment',
        text = text,
      }
      -- N.B. line number starts with digit, hence no clashes to other items
      items[line] = item
    end

    -- bind comments to lower adjacent items.
    do
      local href = (self.flags.href_prefix or '') .. Path.basename(path)
      local t = {}
      for k, v in pairs(items) do
        -- reference source code
        v.href = href .. '#L' .. v.line
        -- numeric lines, for sorting
        v.line = tonumber(v.line)
        -- short name
        if v.name then
          ---v.short_name = v.name:gsub('^.+[.:]', '')
        end
        -- children
        v.children = {}
        --
        t[#t + 1] = v
      end
      -- sort items by line number
      Table.sort(t, function (a, b) return a.line < b.line end)
      -- bind comments to lower adjacent items
      for i, r in ipairs(t) do
        local r1 = t[i + 1]
        if r.type == 'comment' then
          if r1 and r1.type ~= 'comment' then
            r1.doc = r.text
          end
          -- remove comment items
          items[tostring(r.line)] = nil
        end
        -- housekeep
        r.line = nil
      end
    end

    -- report parsed module
    callback(nil, module)

  end)

end

--
-- parse many files into self.items
--
function API:parse(paths, callback)

  local function sort()
    -- convert hash to array, to ease sorting
    local items = self.items
    local tree = {}
    for k, v in pairs(items) do tree[#tree + 1] = v end
    -- sort items by name, case doesn't matter
    Table.sort(tree, function (a, b) return a.name:lower() < b.name:lower() end)
    local q = {}
    for i, r in ipairs(tree) do q[#q + 1] = r.name .. ':' .. r.type .. ':' .. (r.doc or '') end
    Fs.writeFile('api.list', JSON.stringify(q, { beautify = true, indent_string = '  ' }), print)
    -- starting from the most lengthy name...
    for i = #tree, 2, -1 do
      local r = tree[i]
      -- compose guessed parent name, by removing the latest name chunk
      local pname = r.name:gsub('[.:][^.:]-$', '')
      -- parent name is not the same as this item name?
      if pname ~= r.name then
        -- parent is explicitly seen
        if items[pname] then
          -- move this item to parent's children
          Table.insert(items[pname].children, r)
          Table.remove(tree, i)
        -- parent is a class' meta
        elseif pname:sub(-5, -1) == '.meta' then
          -- move this item to that class' meta
          pname = pname:sub(1, -6)
          if items[pname] and items[pname].type == 'class' then
            Table.insert(items[pname].meta, r)
            Table.remove(tree, i)
          -- no class found?!
          else
            -- hard error
            printStderr('Meta defined on non-class for "' .. pname .. '"\n')
          end
        -- no parent class or namespace found?!
        else
          -- hard error
          printStderr('No parent found for "' .. r.name .. '"\n')
        end
      end
    end
    --
    self.tree = tree
    callback()
  end

  local processed = 0

  -- for each path
  for _, path in pairs(paths) do

    -- walk over files under that path
    self:parseFile(path, function (err, module)
      -- collect parsed items
      for k, v in pairs(module.items) do
        self.items[k] = v
      end
      -- upon walk is complete
      processed = processed + 1
      if processed == #paths then
        -- report all parsed items at once
        sort()
      end
    end)

  end

  -- handle empty paths case
  if processed == #paths then
    sort()
  end

end

function API:toJSON()
  print(JSON.stringify(self.tree, { beautify = true, indent_string = '  ' }))
end

function API:toMarkdown()

  local o = {}
  local function put(s, dont_separate)
    if not dont_separate then
      Table.insert(o, '')
    end
    Table.insert(o, s or '')
  end

  local function filter(list, fn)
    local r = {}
    for k, v in ipairs(list) do
      if fn(v, k, list) then
        r[#r + 1] = v
      end
    end
    return r
  end

  local function map(list, fn)
    local r = {}
    for k, v in ipairs(list) do
      r[k] = fn(v, k, list)
    end
    return r
  end

  local function output_tree(tree, depth)
    for _, item in ipairs(tree) do
      put(('#'):rep(depth + 2) .. ' ' .. item.type .. ' ' .. item.name)
      if item.type == 'class' then
        put('Extends `' .. item.extends .. '`')
      end
      if item.type == 'function' then
        put('```lua\n' .. 'function ' .. item.name .. '(' .. item.args .. ')' .. '\n```')
      end
      if item.doc then put(item.doc) end
      local props = filter(item.children, function (x) return x.type == 'property' end)
      if #props > 0 then
        --put(('#'):rep(depth + 3) .. ' Properties')
        output_tree(props, depth + 1)
        --[[for _, v in ipairs(props) do
          put(('#'):rep(depth + 3) .. '[' .. v.name .. '](' .. v.href .. ')')
          if v.doc then put(v.doc) end
        end]]--
      end
      local funcs = filter(item.children, function (x) return x.type == 'function' end)
      if #funcs > 0 then
        --put(('#'):rep(depth + 3) .. 'Functions')
        output_tree(funcs, depth + 1)
        --[[for _, v in ipairs(funcs) do
          put(('#'):rep(depth + 3) .. '[' .. v.name .. '](' .. v.href .. ')')
          put('```lua\n' .. 'function ' .. v.name .. '(' .. v.args .. ')' .. '\n```')
          if v.doc then put(v.doc) end
        end]]--
      end
      local classes = filter(item.children, function (x) return x.type == 'class' end)
      if #classes > 0 then
        output_tree(classes, depth + 1)
      end
    end
  end

  output_tree(self.tree, 0)
  print(Table.concat(o, '\n') .. '\n')

end

--
-- parse process arguments
--
local parser = API:new()
parser.flags, arguments = parseArguments(process.argv)
parser:parse(arguments, function ()
  if parser.flags.json then
    parser:toJSON()
  else
    parser:toMarkdown()
  end
end)

--[[
    for i, r in ipairs(items) do
      -- the first block comment is module description
      if r.type == 'comment' and r.block and not mod.doc then
        mod.doc = r.text
      end
      -- distribute
      if r.type == 'function' then
        r.signature = 'function ' .. r.name .. '(' .. r.args .. ')'
        mod.functions[#mod.functions + 1] = r
      elseif r.type == 'property' then
        mod.properties[#mod.properties + 1] = r
      elseif r.type == 'class' then
        mod.classes[#mod.classes + 1] = r
      end
    end
    Table.sort(mod.properties, function (a, b) return a.name < b.name end)
    Table.sort(mod.functions, function (a, b) return a.name < b.name end)
    Table.sort(mod.classes, function (a, b) return a.name < b.name end)
    --p(mod)
    --require('fs').writeFile('api.json', JSON.stringify(api['core'], { beautify = true, indent_string = '  ' }), print)

    api[mod.module] = mod
    api[#api + 1] = mod
    Table.sort(api, function (a, b) return a.module < b.module end)

  end

  --print(JSON.stringify(api['core'], { beautify = true, indent_string = '  ' }))

  ]]--


-- module
return API
