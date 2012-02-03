#!/usr/bin/env luvit

local API = { }

local Table = require('table')
local Path = require('path')
local JSON = require('json')
local Fs = require('meta-fs')

--
-- a simple command line arguments parser
-- N.B. it's bundled version of stripped down dvv/luvit-cmdline
--
local function parseArguments(argv)
  if not argv then argv = process.argv end
  local opts = { }
  local args = { }
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

  local items = { }

  Fs.read_file(path, function (err, text)
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
    numbered = numbered:gsub('\n' .. number_tag .. '\n', function ()
      return '\n'
    end)

    -- collect exported function
    for name, args, line in numbered:gmatch('\nfunction%s+([_%a][_%w]*[.:][_%a][_%w]*)(%b())%s*' .. number_tag) do
      --p('FUNC', name, args, line)
      items[line] = {
        line = line,
        type = 'function',
        name = name,
        args = args:sub(2, -2),
      }
    end

    -- collect exposed variables
    -- FIXME: needed?!
    -- TODO: API.foo.bar['baz']
    -- TODO: catch initial value?
    for name, value, line in numbered:gmatch('\n([_%a][_%w]*[.:][_%a][_%w]*) = (.-)%s*' .. number_tag) do
      --p('VAR', name, args, line)
      items[line] = {
        line = line,
        type = 'prop',
        name = name,
        value = value,
      }
    end

    -- collect requires
    local requires = { }
    for name, value, line in numbered:gmatch('\nlocal ([_%a][_%w]*) = require(%b())%s*' .. number_tag) do
      items[line] = {
        line = line,
        type = 'require',
        name = name,
        value = value:sub(3, -3),
      }
      requires[name] = items[line].value
    end

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

    -- collect block comments
    for comment, line in numbered:gmatch('\n%-%-%[(%b[])%]' .. number_tag) do
      items[line] = {
        line = line,
        type = 'comment',
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

    -- TODO: employ more creationix's parts of parser?
    -- ???

    -- duplicate records sorted by line number
    -- N.B. after that items[1] returns the first item in chronological order,
    --   and items['1'] -- the item at source line 1, if any
    do
      local t = { }
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
function API.parsePath(paths, pattern, callback)

  local files = { }
  local processed = 0

  -- for each path
  for _, base_path in pairs(paths) do

    -- walk over files under that path
    base_path = Path.resolve(process.cwd(), base_path)
    Fs.find(base_path, {
      -- parse all files that match the pattern
      match_fn = function (path, stat, depth, cb)
        if path:find(pattern) then
          API.parseFile(path, function (err, file, text)
            -- store parsed tokens
            --p(path, path:sub(#base_path + 2), file)
            files[path] = file
            cb()
          end)
        else
          cb()
        end
      end,

    -- upon walk is complete
    }, function (err)
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

--
-- process arguments
--
local pattern = flags.pattern or '%.lua$'
API.parsePath(arguments, pattern, function (err, files)
  for filename, items in pairs(files) do

    -- distribute items
    local exports = {
      functions = { },
      props = { },
      variables = { },
      comments = { },
    }

    -- bind comments to corresponding items
    for i, r in ipairs(items) do
      if r.type == 'function' or r.type == 'variable' or r.type == 'comment' then
        local target = exports[r.type .. 's']
        local r1 = items[i - 1]
        if r1 and r1.type == 'comment' then
          r.comment = r1.text
        end
        target[#target + 1] = r
      end
    end
    --p(exports)

    print(filename)
    print('Functions:')
    p(exports.functions)
    print('Properties:')
    p(exports.props)
    print('Variables:')
    p(exports.variables)
    print('Comments:')
    p(exports.comments)

  end
  --p(JSON.stringify(files))
end)

-- module
return API
