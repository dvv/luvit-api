#!/usr/bin/env luvit

local API = {}

local Table = require('table')
local Path = require('path')
local JSON = require('json')
local Fs = require('fs')

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
-- parse command line
--
local flags, arguments = parseArguments()

--
-- parse file on given path, return table whose keys are line numbers and values are parsed tokens
--
function API.parseFile(path, callback)

  local items = {}

  Fs.readFile(path, function (err, text)
    if not text then callback(err) ; return end

    -- tags to number lines of text
    -- TODO: nonce?
    local number_head = '~~~<<<'
    local number_tail = '>>>~~~'
    local number_tag = number_head .. '(%d+)' .. number_tail

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

    -- prune empty lines
    --[[numbered = numbered:gsub('\n' .. number_tag .. '\n', function ()
      return '\n'
    end)]]--

    -- collect exported functions
    -- `function MODULE.func(args)` form
    for name, args, line in numbered:gmatch('\nfunction%s+([_%a][_%w]*[.:][_%a][_%w]*)(%b())%s*' .. number_tag) do
      items[line] = {
        line = line,
        type = 'function',
        name = name,
        args = args:sub(2, -2),
      }
    end

    -- collect exported functions
    -- `MODULE.func = function (args)` form
    for name, args, line in numbered:gmatch('\n([_%a][_%w]*[.:][_%a][_%w]*) = function (%b())%s*' .. number_tag) do
      items[line] = {
        line = line,
        type = 'function',
        name = name,
        args = args:sub(2, -2),
      }
    end

    -- collect exposed variables
    for name, value, line in numbered:gmatch('\n([_%a][_%w]*[.:][_%a][_%w]*) = (.-)%s*' .. number_tag) do
      if value:find('function', 1, true) ~= 1 then
        items[line] = {
          line = line,
          type = 'property',
          name = name,
          value = value,
        }
      end
    end

    -- collect requires
    local requires = {}
    for name, value, line in numbered:gmatch('\nlocal ([_%a][_%w]*) = require(%b())%s*' .. number_tag) do
      items[line] = {
        line = line,
        type = 'require',
        name = name,
        value = value:sub(3, -3),
      }
      requires[name] = items[line].value
    end

    --[[
    -- collect inheritance
    --for name, value, line in numbered:gmatch('\nlocal ([_%a][_%w]*) = (.-)%s*' .. number_tag) do
    for name, value, line in numbered:gmatch('\nlocal ([_%a][_%w]*) = ([^\n]-):extend%(%)%s*' .. number_tag) do
      --p('VAR', name, args, line)
      items[line] = {
        line = line,
        type = 'variable',
        name = name,
        value = value,
        extends = requires[value]
      }
    end
    ]]--

    -- collect block comments
    for comment, line in numbered:gmatch('\n%-%-%[(%b[])%]' .. number_tag) do
      items[line] = {
        line = line,
        type = 'comment',
        block = true,
        text = comment:gsub(number_tag, ''):sub(2, -2):gsub('^\n+', ''):gsub('\n+$', ''),
      }
    end

    -- collect single line comments
    for comment, line in numbered:gmatch('\n%-%-%s+(.-)%s*' .. number_tag) do
      -- N.B: we glue adjacent comments
      local prev = tostring(line - 1)
      -- if previous line also contained comment
      if items[prev] and items[prev].type == 'comment' then
        -- glue previous line and this comment
        comment = items[prev].text .. '\n' .. comment
        -- and forget about previous line
        items[prev] = nil
      end
      items[line] = {
        line = line,
        type = 'comment',
        text = comment,
      }
    end

    -- duplicate records sorted by line number
    -- N.B. after that items[1] returns the first item in chronological order,
    --   and items['1'] -- the item at source line 1, if any
    do
      local t = {}
      for k, v in pairs(items) do
        v.line = tonumber(v.line)
        t[#t + 1] = v
      end
      Table.sort(t, function (a, b) return a.line < b.line end)
      for i, r in ipairs(t) do
        items[#items + 1] = r
      end
    end

    -- report collected items
    callback(nil, items, text)

  end)

end

--
-- for each path in `paths` recursively parse all files matching `pattern`
--
function API.parsePath(paths, callback)

  local files = {}
  local processed = 0

  -- for each path
  for _, path in pairs(paths) do

    -- walk over files under that path
    base_path = Path.resolve(process.cwd(), path)
    API.parseFile(path, function (err, file, text)
      -- store parsed tokens
      --p(path, path:sub(#base_path + 2), file)
      files[path] = file
      -- upon walk is complete
      processed = processed + 1
      if processed == #paths then
        -- report all parsed tokens
        callback(nil, files)
      end
    end)

  end

  -- handle empty paths case
  if processed == #paths then
    callback(nil, files)
  end

end

local api = {}
--
-- process arguments
--
API.parsePath(arguments, function (err, files)
  for filename, items in pairs(files) do

    local href = '../../../luvit/luvit/blob/master/lib/' .. Path.basename(filename)

    -- distribute items
    local mod = {
      module = Path.basename(filename):gsub('%..-$', ''),
      href = href,
      --doc = nil,
      functions = {},
      properties = {},
      classes = {},
    }

    for i, r in ipairs(items) do
      -- short name
      if r.name then
        r.short_name = r.name:gsub('^.+[.:]', '')
      end
      -- line to reference
      r.href = href .. '#L' .. r.line
      -- bind comments to lower adjacent items
      local r1 = items[i - 1]
      if r.type ~= 'comment' and r1 and r1.type == 'comment' then
        r.doc = r1.text
      end
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

    api[mod.module] = mod
    api[#api + 1] = mod
    Table.sort(api, function (a, b) return a.module < b.module end)

  end

  --print(JSON.stringify(api['core'], { beautify = true, indent_string = '  ' }))

  -- markdown
  local o = {}
  local function put(s, dont_separate)
    if not dont_separate then
      Table.insert(o, '')
    end
    Table.insert(o, s or '')
  end
  for _, mod in ipairs(api) do
    put('## [' .. mod.module .. '](' .. mod.href .. ')')
    if mod.doc then
      put(mod.doc)
    end
    for _, v in ipairs(mod.properties) do
      put('### [' .. v.short_name .. '](' .. v.href .. ')')
      if v.doc then put(v.doc) end
    end
    for _, v in ipairs(mod.functions) do
      put('### [' .. v.short_name .. '](' .. v.href .. ')')
      if v.signature then put('```lua\n' .. v.signature .. '\n```') end
      if v.doc then put(v.doc) end
    end
    for _, v in ipairs(mod.classes) do
      put('### [' .. v.short_name .. '](' .. v.href .. ')')
      if v.doc then put(v.doc) end
    end
  end
  print(Table.concat(o, '\n') .. '\n')

end)


-- module
return API
