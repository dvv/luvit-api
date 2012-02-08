
## property argv

## property bit

## property coroutine

## property debug

## property dofile

## property getcwd

## property HTTP_VERSION

## property io

clear some globals
This will break lua code written for other lua runtimes

## property jit

## property loadfile

## property LUAJIT_VERSION

## property math

## property module

## property os

## property print

## property string

## property table

## property UV_VERSION

## property VERSION

## property YAJL_VERSION

## module buffer

### class Buffer

Extends [`Object`](../../../luvit/luvit/blob/master/lib/buffer.lua#L30)

```lua
function Buffer:readUInt8(offset)
```

```lua
function Buffer:readUInt32LE(offset)
```

```lua
function Buffer:readUInt32BE(offset)
```

```lua
function Buffer:readUInt16LE(offset)
```

```lua
function Buffer:readUInt16BE(offset)
```

```lua
function Buffer:readInt8(offset)
```

```lua
function Buffer:readInt32LE(offset)
```

```lua
function Buffer:readInt32BE(offset)
```

```lua
function Buffer:readInt16LE(offset)
```

```lua
function Buffer:readInt16BE(offset)
```

```lua
function Buffer:inspect()
```

```lua
function Buffer:initialize(length)
```

## module core

### property Object

This is the most basic object in Luvit. It provides simple prototypal
inheritance and inheritable constructors. All other objects inherit from this.

#### property meta

```lua
function Object:new(...)
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

```lua
function Object:extend()
```

Creates a new sub-class.

    local Square = Rectangle:extend()
    function Square:initialize(w)
      self.w = w
      self.h = h
    end

```lua
function Object:create()
```

Create a new instance of this object

### class Stream

Extends [`Handle`](../../../luvit/luvit/blob/master/lib/core.lua#L234)

This is never used directly.  If you want to create a pure Lua stream, subclass
or instantiate `core.iStream`.

```lua
function Stream:write(chunk, callback)
```

```lua
function Stream:shutdown()
```

```lua
function Stream:readStop()
```

```lua
function Stream:readStart()
```

```lua
function Stream:pipe(target)
```

```lua
function Stream:listen(callback)
```

```lua
function Stream:accept(other_stream)
```

### class iStream

Extends [`Emitter`](../../../luvit/luvit/blob/master/lib/core.lua#L277)

This is an abstract interface that works like `core.Stream` but doesn't actually
contain a uv struct (it's pure lua)

### class Handle

Extends [`Emitter`](../../../luvit/luvit/blob/master/lib/core.lua#L199)

This class is never used directly, but is the inheritance chain of all libuv
objects.

```lua
function Handle:setHandler(name, callback)
```

Set or replace the handler for a native event.  Usually `Emitter:on()` is what
you want, not this.

```lua
function Handle:close()
```

Wrapper around `uv_close`. Closes the underlying file descriptor of a handle.

```lua
function Handle:addHandlerType(name)
```

This is used by Emitters to register with native events when the first listener
is added.

### class Error

Extends [`Object`](../../../luvit/luvit/blob/master/lib/core.lua#L285)

This is for code that wants structured error messages.

```lua
function Error:initialize(message)
```

### class Emitter

Extends [`Object`](../../../luvit/luvit/blob/master/lib/core.lua#L97)

This class can be used directly whenever an event emitter is needed.

    local emitter = Emitter:new()
    emitter:on('foo', p)
    emitter:emit('foo', 1, 2, 3)

Also it can easily be sub-classed.

    local Custom = Emitter:extend()
    local c = Custom:new()
    c:on('bar', onBar)

```lua
function Emitter:wrap(name)
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

```lua
function Emitter:removeListener(name, callback)
```

Remove a listener so that it no longer catches events.

```lua
function Emitter:once(name, callback)
```

Same as `Emitter:on` except it de-registers itself after the first event.

```lua
function Emitter:on(name, callback)
```

Adds an event listener (`callback`) for the named event `name`.

```lua
function Emitter:missingHandlerType(name, ...)
```

By default, and error events that are not listened for should thow errors

```lua
function Emitter:emit(name, ...)
```

Emit a named event to all listeners with optional data argument(s).

```lua
function debug(...)
```

Like p, but prints to stderr using blocking I/O for better debugging

## module dns

```lua
function reverse(ip, callback)
```

```lua
function resolveTxt(domain, callback)
```

```lua
function resolveSrv(domain, callback)
```

```lua
function resolveNs(domain, callback)
```

```lua
function resolveMx(domain, callback)
```

```lua
function resolveCname(domain, callback)
```

```lua
function resolve6(domain, callback)
```

```lua
function resolve4(domain, callback)
```

```lua
function resolve(domain, rrtype, callback)
```

```lua
function lookup(domain, family, callback)
```

```lua
function isIpV6(ip)
```

```lua
function isIpV4(ip)
```

```lua
function isIp(ip)
```

## property error_meta

```lua
function eventSource(name, fn, ...)
```

This is called by all the event sources from C
The user can override it to hook into event sources

## module fiber

```lua
function new(fn)
```

## module fs

```lua
function writeFile(path, data, callback)
```

```lua
function readFileSync(path)
```

```lua
function readFile(path, callback)
```

```lua
function existsSync(path)
```

```lua
function exists(path, callback)
```

Wrap the core fs functions in forced sync and async versions

```lua
function createWriteStream(path, options)
```

```lua
function createReadStream(path, options)
```

TODO: Implement backpressure here and in tcp streams

### class Watcher

Extends [`Handle`](../../../luvit/luvit/blob/master/lib/fs.lua#L235)

```lua
function Watcher:initialize(path)
```

## module http

### property STATUS_CODES

```lua
function request(options, callback)
```

```lua
function createServer(host, port, onConnection)
```

### class Response

Extends [`iStream`](../../../luvit/luvit/blob/master/lib/http.lua#L99)

#### property auto_server

#### property auto_date

#### property auto_content_type

#### property auto_content_length

#### property auto_chunked_encoding

```lua
function Response:writeHead(code, headers, callback)
```

```lua
function Response:writeContinue(callback)
```

```lua
function Response:write(chunk, callback)
```

```lua
function Response:unsetHeader(name)
```

Removes a set header.  Cannot remove headers added with :addHeader

```lua
function Response:setHeader(name, value)
```

This sets a header, replacing any header with the same name (case insensitive)

```lua
function Response:setCode(code)
```

```lua
function Response:initialize(socket)
```

```lua
function Response:flushHead(callback)
```

```lua
function Response:finish(chunk, callback)
```

```lua
function Response:close(...)
```

```lua
function Response:addHeader(name, value)
```

Adds a header line.  This does not replace any header by the same name and
allows duplicate headers.  Returns the index it was inserted at

### class Request

Extends [`iStream`](../../../luvit/luvit/blob/master/lib/http.lua#L86)

```lua
function Request:initialize(socket)
```

```lua
function Request:close(...)
```

## module JSON

```lua
function stringify(value, options)
```

```lua
function streamingParser(callback, options)
```

```lua
function parse(string, options)
```

## module mime

### property table

### property default

```lua
function getType(path)
```

## module net

### property create

```lua
function createServer(connectionCallback)
```

```lua
function createConnection(port, ... --[[ host, cb --]])
```

### class Socket

Extends [`Emitter`](../../../luvit/luvit/blob/master/lib/net.lua#L90)

```lua
function Socket:write(data, callback)
```

```lua
function Socket:setTimeout(msecs, callback)
```

```lua
function Socket:pipe(destination)
```

```lua
function Socket:initialize()
```

```lua
function Socket:connect(port, host, callback)
```

```lua
function Socket:close()
```

```lua
function Socket:_connect(address, port, addressType)
```

### class Server

Extends [`Emitter`](../../../luvit/luvit/blob/master/lib/net.lua#L29)

```lua
function Server:listen(port, ... --[[ ip, callback --]] )
```

```lua
function Server:initialize(...)
```

```lua
function Server:close()
```

## property date

## property time

```lua
function p(...)
```

A nice global data dumper

## property config

## property cpath

## property os

Copy date and binding over from lua os module into luvit os module

## property os_binding

## property loaders

Remove the cwd based loaders, we don't want them

## property path

## property os_binding

## property searchpath

## property seeall

## module path

```lua
function resolve(root, filepath)
```

```lua
function normalize(filepath)
```

Modifies an array of path parts in place by interpreting "." and ".." segments

```lua
function join(...)
```

```lua
function extname(filepath)
```

```lua
function dirname(filepath)
```

```lua
function basename(filepath, expected_ext)
```

## module pipe

### class Pipe

Extends [`Stream`](../../../luvit/luvit/blob/master/lib/pipe.lua#L24)

```lua
function Pipe:open(fd)
```

```lua
function Pipe:initialize(ipc)
```

```lua
function Pipe:connect(name)
```

```lua
function Pipe:bind(name)
```

```lua
function print(...)
```

Replace print

## property process

### property versions

### property version

### property stdout

### property stdin

Load the tty as a pair of pipes
But don't hold the event loop open for them

### property env

Add global access to the environment variables using a dynamic table

### property cwd

### property argv

```lua
function process:missingHandlerType(name, ...)
```

```lua
function process:addHandlerType(name)
```

```lua
function spawn(...)
```

```lua
function exit(exit_code)
```

### class Process

Extends [`Handle`](../../../luvit/luvit/blob/master/lib/childprocess.lua#L24)

```lua
function Process:kill(signal)
```

```lua
function Process:initialize(command, args, options)
```

## module querystring

module

```lua
function urlencode(str)
```

this comment
is
for purpose of documentation

```lua
function urldecode(str)
```

decode %XX sequences
into corresponding
characters.
this comment
is
for purpose of documentation

```lua
function parse(str, sep, eq)
```

## module repl

### property colored_name

```lua
function start()
```

```lua
function evaluateLine(line)
```

```lua
function require(filepath, dirname)
```

## module stack

```lua
function translate(mountpoint, matchpoint, ...)
```

```lua
function stack(...)
```

```lua
function mount(mountpoint, ...)
```

Mounts a substack app at a url subtree

```lua
function errorHandler(req, res, err)
```

```lua
function compose(...)
```

Build a composite stack made of several layers

## module tcp

### class Tcp

Extends [`Stream`](../../../luvit/luvit/blob/master/lib/tcp.lua#L24)

```lua
function Tcp:nodelay(enable)
```

```lua
function Tcp:keepalive(enable, delay)
```

```lua
function Tcp:initialize()
```

```lua
function Tcp:getsockname()
```

```lua
function Tcp:getpeername()
```

```lua
function Tcp:connect6(ip_address, port)
```

```lua
function Tcp:connect(ip_address, port)
```

```lua
function Tcp:bind6(host, port)
```

```lua
function Tcp:bind(host, port)
```

## module timer

```lua
function setTimeout(duration, callback, ...)
```

```lua
function setInterval(period, callback, ...)
```

```lua
function clearTimer(timer)
```

### class Timer

Extends [`Handle`](../../../luvit/luvit/blob/master/lib/timer.lua#L22)

```lua
function Timer:stop()
```

```lua
function Timer:start(timeout, interval, callback)
```

```lua
function Timer:setRepeat(interval)
```

```lua
function Timer:initialize()
```

```lua
function Timer:getRepeat()
```

```lua
function Timer:again()
```

## module tty

```lua
function resetMode()
```

### class Tty

Extends [`Stream`](../../../luvit/luvit/blob/master/lib/tty.lua#L23)

```lua
function Tty:setMode(mode)
```

```lua
function Tty:initialize(fd, readable)
```

```lua
function Tty:getWinsize()
```

## module udp

### class Udp

Extends [`Handle`](../../../luvit/luvit/blob/master/lib/udp.lua#L24)

```lua
function Udp:setMembership(multicast_addr, interface_addr, option)
```

```lua
function Udp:send6(...)
```

```lua
function Udp:send(...)
```

```lua
function Udp:recvStop()
```

```lua
function Udp:recvStart()
```

```lua
function Udp:initialize()
```

```lua
function Udp:getsockname()
```

```lua
function Udp:bind6(host, port)
```

```lua
function Udp:bind(host, port)
```

## module url

```lua
function parse(url)
```

## module utils

```lua
function dump(o, depth)
```

```lua
function colorize(color_name, string, reset_name)
```

```lua
function color(color_name)
```

```lua
function bind(fun, self, ...)
```


