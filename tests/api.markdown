
## property _G.argv

## property _G.bit

## property _G.coroutine

## property _G.debug

## property _G.dofile

## property _G.getcwd

## property _G.HTTP_VERSION

## property _G.io

clear some globals
This will break lua code written for other lua runtimes

## property _G.jit

## property _G.loadfile

## property _G.LUAJIT_VERSION

## property _G.math

## property _G.module

## property _G.os

## property _G.print

## property _G.string

## property _G.table

## property _G.UV_VERSION

## property _G.VERSION

## property _G.YAJL_VERSION

## module buffer

### class buffer.Buffer

Extends `buffer.Object`

#### function buffer.Buffer:readUInt8

```lua
function buffer.Buffer:readUInt8(offset)
```

#### function buffer.Buffer:readUInt32LE

```lua
function buffer.Buffer:readUInt32LE(offset)
```

#### function buffer.Buffer:readUInt32BE

```lua
function buffer.Buffer:readUInt32BE(offset)
```

#### function buffer.Buffer:readUInt16LE

```lua
function buffer.Buffer:readUInt16LE(offset)
```

#### function buffer.Buffer:readUInt16BE

```lua
function buffer.Buffer:readUInt16BE(offset)
```

#### function buffer.Buffer:readInt8

```lua
function buffer.Buffer:readInt8(offset)
```

#### function buffer.Buffer:readInt32LE

```lua
function buffer.Buffer:readInt32LE(offset)
```

#### function buffer.Buffer:readInt32BE

```lua
function buffer.Buffer:readInt32BE(offset)
```

#### function buffer.Buffer:readInt16LE

```lua
function buffer.Buffer:readInt16LE(offset)
```

#### function buffer.Buffer:readInt16BE

```lua
function buffer.Buffer:readInt16BE(offset)
```

#### function buffer.Buffer:inspect

```lua
function buffer.Buffer:inspect()
```

#### function buffer.Buffer:initialize

```lua
function buffer.Buffer:initialize(length)
```

## module core

### property core.Object

This is the most basic object in Luvit. It provides simple prototypal
inheritance and inheritable constructors. All other objects inherit from this.

#### property core.Object.meta

#### function core.Object:new

```lua
function core.Object:new(...)
```

Creates a new instance and calls `obj:initialize(...)` if it exists.

    local Rectangle = Object:extend()
    function Rectangle:initialize(w, h)
      self.w = w
      self.h = h
    end
    function Rectangle:getArea()
      return self.w * self.h
    end
    local rect = Rectangle:new(3, 4)
    p(rect:getArea())

#### function core.Object:extend

```lua
function core.Object:extend()
```

Creates a new sub-class.

    local Square = Rectangle:extend()
    function Square:initialize(w)
      self.w = w
      self.h = h
    end

#### function core.Object:create

```lua
function core.Object:create()
```

Create a new instance of this object

### class core.Stream

Extends `core.Handle`

This is never used directly.  If you want to create a pure Lua stream, subclass
or instantiate `core.iStream`.

#### function core.Stream:write

```lua
function core.Stream:write(chunk, callback)
```

#### function core.Stream:shutdown

```lua
function core.Stream:shutdown()
```

#### function core.Stream:readStop

```lua
function core.Stream:readStop()
```

#### function core.Stream:readStart

```lua
function core.Stream:readStart()
```

#### function core.Stream:pipe

```lua
function core.Stream:pipe(target)
```

#### function core.Stream:listen

```lua
function core.Stream:listen(callback)
```

#### function core.Stream:accept

```lua
function core.Stream:accept(other_stream)
```

### class core.iStream

Extends `core.Emitter`

This is an abstract interface that works like `core.Stream` but doesn't actually
contain a uv struct (it's pure lua)

### class core.Handle

Extends `core.Emitter`

This class is never used directly, but is the inheritance chain of all libuv
objects.

#### function core.Handle:setHandler

```lua
function core.Handle:setHandler(name, callback)
```

Set or replace the handler for a native event.  Usually `Emitter:on()` is what
you want, not this.

#### function core.Handle:close

```lua
function core.Handle:close()
```

Wrapper around `uv_close`. Closes the underlying file descriptor of a handle.

#### function core.Handle:addHandlerType

```lua
function core.Handle:addHandlerType(name)
```

This is used by Emitters to register with native events when the first listener
is added.

### class core.Error

Extends `core.Object`

This is for code that wants structured error messages.

#### function core.Error:initialize

```lua
function core.Error:initialize(message)
```

### class core.Emitter

Extends `core.Object`

This class can be used directly whenever an event emitter is needed.

    local emitter = Emitter:new()
    emitter:on('foo', p)
    emitter:emit('foo', 1, 2, 3)

Also it can easily be sub-classed.

    local Custom = Emitter:extend()
    local c = Custom:new()
    c:on('bar', onBar)

#### function core.Emitter:wrap

```lua
function core.Emitter:wrap(name)
```

Utility that binds the named method `self[name]` for use as a callback.  The
first argument (`err`) is re-routed to the "error" event instead.

    local Joystick = Emitter:extend()
    function Joystick:initialize(device)
      self:wrap("onOpen")
      FS.open(device, self.onOpen)
    end

    function Joystick:onOpen(fd)
      -- and so forth
    end

#### function core.Emitter:removeListener

```lua
function core.Emitter:removeListener(name, callback)
```

Remove a listener so that it no longer catches events.

#### function core.Emitter:once

```lua
function core.Emitter:once(name, callback)
```

Same as `Emitter:on` except it de-registers itself after the first event.

#### function core.Emitter:on

```lua
function core.Emitter:on(name, callback)
```

Adds an event listener (`callback`) for the named event `name`.

#### function core.Emitter:missingHandlerType

```lua
function core.Emitter:missingHandlerType(name, ...)
```

By default, and error events that are not listened for should thow errors

#### function core.Emitter:emit

```lua
function core.Emitter:emit(name, ...)
```

Emit a named event to all listeners with optional data argument(s).

## function debug

```lua
function debug(...)
```

Like p, but prints to stderr using blocking I/O for better debugging

## module dns

### function dns.reverse

```lua
function dns.reverse(ip, callback)
```

### function dns.resolveTxt

```lua
function dns.resolveTxt(domain, callback)
```

### function dns.resolveSrv

```lua
function dns.resolveSrv(domain, callback)
```

### function dns.resolveNs

```lua
function dns.resolveNs(domain, callback)
```

### function dns.resolveMx

```lua
function dns.resolveMx(domain, callback)
```

### function dns.resolveCname

```lua
function dns.resolveCname(domain, callback)
```

### function dns.resolve6

```lua
function dns.resolve6(domain, callback)
```

### function dns.resolve4

```lua
function dns.resolve4(domain, callback)
```

### function dns.resolve

```lua
function dns.resolve(domain, rrtype, callback)
```

### function dns.lookup

```lua
function dns.lookup(domain, family, callback)
```

### function dns.isIpV6

```lua
function dns.isIpV6(ip)
```

### function dns.isIpV4

```lua
function dns.isIpV4(ip)
```

### function dns.isIp

```lua
function dns.isIp(ip)
```

## property error_meta

## function eventSource

```lua
function eventSource(name, fn, ...)
```

This is called by all the event sources from C
The user can override it to hook into event sources

## module fiber

### function fiber.new

```lua
function fiber.new(fn)
```

## module fs

### function fs.writeFile

```lua
function fs.writeFile(path, data, callback)
```

### function fs.readFileSync

```lua
function fs.readFileSync(path)
```

### function fs.readFile

```lua
function fs.readFile(path, callback)
```

### function fs.existsSync

```lua
function fs.existsSync(path)
```

### function fs.exists

```lua
function fs.exists(path, callback)
```

Wrap the core fs functions in forced sync and async versions

### function fs.createWriteStream

```lua
function fs.createWriteStream(path, options)
```

### function fs.createReadStream

```lua
function fs.createReadStream(path, options)
```

TODO: Implement backpressure here and in tcp streams

### class fs.Watcher

Extends `fs.Handle`

#### function fs.Watcher:initialize

```lua
function fs.Watcher:initialize(path)
```

## module http

### property http.STATUS_CODES

### function http.request

```lua
function http.request(options, callback)
```

### function http.createServer

```lua
function http.createServer(host, port, onConnection)
```

### class http.Response

Extends `http.iStream`

#### property http.Response.auto_server

#### property http.Response.auto_date

#### property http.Response.auto_content_type

#### property http.Response.auto_content_length

#### property http.Response.auto_chunked_encoding

#### function http.Response:writeHead

```lua
function http.Response:writeHead(code, headers, callback)
```

#### function http.Response:writeContinue

```lua
function http.Response:writeContinue(callback)
```

#### function http.Response:write

```lua
function http.Response:write(chunk, callback)
```

#### function http.Response:unsetHeader

```lua
function http.Response:unsetHeader(name)
```

Removes a set header.  Cannot remove headers added with :addHeader

#### function http.Response:setHeader

```lua
function http.Response:setHeader(name, value)
```

This sets a header, replacing any header with the same name (case insensitive)

#### function http.Response:setCode

```lua
function http.Response:setCode(code)
```

#### function http.Response:initialize

```lua
function http.Response:initialize(socket)
```

#### function http.Response:flushHead

```lua
function http.Response:flushHead(callback)
```

#### function http.Response:finish

```lua
function http.Response:finish(chunk, callback)
```

#### function http.Response:close

```lua
function http.Response:close(...)
```

#### function http.Response:addHeader

```lua
function http.Response:addHeader(name, value)
```

Adds a header line.  This does not replace any header by the same name and
allows duplicate headers.  Returns the index it was inserted at

### class http.Request

Extends `http.iStream`

#### function http.Request:initialize

```lua
function http.Request:initialize(socket)
```

#### function http.Request:close

```lua
function http.Request:close(...)
```

## module JSON

### function JSON.stringify

```lua
function JSON.stringify(value, options)
```

### function JSON.streamingParser

```lua
function JSON.streamingParser(callback, options)
```

### function JSON.parse

```lua
function JSON.parse(string, options)
```

## module mime

### property mime.table

### property mime.default

### function mime.getType

```lua
function mime.getType(path)
```

## module net

### property net.createServer

### property net.createConnection

### property net.create

### class net.Socket

Extends `net.Emitter`

#### function net.Socket:write

```lua
function net.Socket:write(data, callback)
```

#### function net.Socket:setTimeout

```lua
function net.Socket:setTimeout(msecs, callback)
```

#### function net.Socket:pipe

```lua
function net.Socket:pipe(destination)
```

#### function net.Socket:initialize

```lua
function net.Socket:initialize()
```

#### function net.Socket:connect

```lua
function net.Socket:connect(port, host, callback)
```

#### function net.Socket:close

```lua
function net.Socket:close()
```

#### function net.Socket:_connect

```lua
function net.Socket:_connect(address, port, addressType)
```

### class net.Server

Extends `net.Emitter`

#### function net.Server:listen

```lua
function net.Server:listen(port, ... --[[ ip, callback --]] )
```

#### function net.Server:initialize

```lua
function net.Server:initialize(...)
```

#### function net.Server:close

```lua
function net.Server:close()
```

## property OS_BINDING.date

## property OS_BINDING.time

## function p

```lua
function p(...)
```

A nice global data dumper

## property package.config

## property package.cpath

## property package.loaded.os

Copy date and binding over from lua os module into luvit os module

## property package.loaded.os_binding

## property package.loaders

Remove the cwd based loaders, we don't want them

## property package.path

## property package.preload.os_binding

## property package.searchpath

## property package.seeall

## module path

### function path.resolve

```lua
function path.resolve(root, filepath)
```

### function path.normalize

```lua
function path.normalize(filepath)
```

Modifies an array of path parts in place by interpreting "." and ".." segments

### function path.join

```lua
function path.join(...)
```

### function path.extname

```lua
function path.extname(filepath)
```

### function path.dirname

```lua
function path.dirname(filepath)
```

### function path.basename

```lua
function path.basename(filepath, expected_ext)
```

## module pipe

### class pipe.Pipe

Extends `pipe.Stream`

#### function pipe.Pipe:open

```lua
function pipe.Pipe:open(fd)
```

#### function pipe.Pipe:initialize

```lua
function pipe.Pipe:initialize(ipc)
```

#### function pipe.Pipe:connect

```lua
function pipe.Pipe:connect(name)
```

#### function pipe.Pipe:bind

```lua
function pipe.Pipe:bind(name)
```

## function print

```lua
function print(...)
```

Replace print

## property process

### property process.versions

### property process.version

### property process.stdout

### property process.stdin

Load the tty as a pair of pipes
But don't hold the event loop open for them

### property process.env

Add global access to the environment variables using a dynamic table

### property process.cwd

### property process.argv

### function process:missingHandlerType

```lua
function process:missingHandlerType(name, ...)
```

### function process:addHandlerType

```lua
function process:addHandlerType(name)
```

### function process.spawn

```lua
function process.spawn(...)
```

### function process.exit

```lua
function process.exit(exit_code)
```

### class process.Process

Extends `process.Handle`

#### function process.Process:kill

```lua
function process.Process:kill(signal)
```

#### function process.Process:initialize

```lua
function process.Process:initialize(command, args, options)
```

## module querystring

module

### function querystring.urlencode

```lua
function querystring.urlencode(str)
```

### function querystring.urldecode

```lua
function querystring.urldecode(str)
```

querystring helpers

### function querystring.parse

```lua
function querystring.parse(str, sep, eq)
```

parse querystring into table. urldecode tokens

## module repl

### property repl.colored_name

### function repl.start

```lua
function repl.start()
```

### function repl.evaluateLine

```lua
function repl.evaluateLine(line)
```

## function require

```lua
function require(filepath, dirname)
```

## module stack

### function stack.translate

```lua
function stack.translate(mountpoint, matchpoint, ...)
```

### function stack.stack

```lua
function stack.stack(...)
```

### function stack.mount

```lua
function stack.mount(mountpoint, ...)
```

Mounts a substack app at a url subtree

### function stack.errorHandler

```lua
function stack.errorHandler(req, res, err)
```

### function stack.compose

```lua
function stack.compose(...)
```

Build a composite stack made of several layers

## module tcp

### class tcp.Tcp

Extends `tcp.Stream`

#### function tcp.Tcp:nodelay

```lua
function tcp.Tcp:nodelay(enable)
```

#### function tcp.Tcp:keepalive

```lua
function tcp.Tcp:keepalive(enable, delay)
```

#### function tcp.Tcp:initialize

```lua
function tcp.Tcp:initialize()
```

#### function tcp.Tcp:getsockname

```lua
function tcp.Tcp:getsockname()
```

#### function tcp.Tcp:getpeername

```lua
function tcp.Tcp:getpeername()
```

#### function tcp.Tcp:connect6

```lua
function tcp.Tcp:connect6(ip_address, port)
```

#### function tcp.Tcp:connect

```lua
function tcp.Tcp:connect(ip_address, port)
```

#### function tcp.Tcp:bind6

```lua
function tcp.Tcp:bind6(host, port)
```

#### function tcp.Tcp:bind

```lua
function tcp.Tcp:bind(host, port)
```

## module timer

### function timer.setTimeout

```lua
function timer.setTimeout(duration, callback, ...)
```

### function timer.setInterval

```lua
function timer.setInterval(period, callback, ...)
```

### function timer.clearTimer

```lua
function timer.clearTimer(timer)
```

### class timer.Timer

Extends `timer.Handle`

#### function timer.Timer:stop

```lua
function timer.Timer:stop()
```

#### function timer.Timer:start

```lua
function timer.Timer:start(timeout, interval, callback)
```

#### function timer.Timer:setRepeat

```lua
function timer.Timer:setRepeat(interval)
```

#### function timer.Timer:initialize

```lua
function timer.Timer:initialize()
```

#### function timer.Timer:getRepeat

```lua
function timer.Timer:getRepeat()
```

#### function timer.Timer:again

```lua
function timer.Timer:again()
```

## module tty

### function tty.resetMode

```lua
function tty.resetMode()
```

### class tty.Tty

Extends `tty.Stream`

#### function tty.Tty:setMode

```lua
function tty.Tty:setMode(mode)
```

#### function tty.Tty:initialize

```lua
function tty.Tty:initialize(fd, readable)
```

#### function tty.Tty:getWinsize

```lua
function tty.Tty:getWinsize()
```

## module udp

### class udp.Udp

Extends `udp.Handle`

#### function udp.Udp:setMembership

```lua
function udp.Udp:setMembership(multicast_addr, interface_addr, option)
```

#### function udp.Udp:send6

```lua
function udp.Udp:send6(...)
```

#### function udp.Udp:send

```lua
function udp.Udp:send(...)
```

#### function udp.Udp:recvStop

```lua
function udp.Udp:recvStop()
```

#### function udp.Udp:recvStart

```lua
function udp.Udp:recvStart()
```

#### function udp.Udp:initialize

```lua
function udp.Udp:initialize()
```

#### function udp.Udp:getsockname

```lua
function udp.Udp:getsockname()
```

#### function udp.Udp:bind6

```lua
function udp.Udp:bind6(host, port)
```

#### function udp.Udp:bind

```lua
function udp.Udp:bind(host, port)
```

## module url

### function url.parse

```lua
function url.parse(url)
```

## module utils

### function utils.dump

```lua
function utils.dump(o, depth)
```

### function utils.colorize

```lua
function utils.colorize(color_name, string, reset_name)
```

### function utils.color

```lua
function utils.color(color_name)
```

### function utils.bind

```lua
function utils.bind(fun, self, ...)
```


