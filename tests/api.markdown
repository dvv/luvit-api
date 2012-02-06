
## Module buffer

### Properties

### [Buffer](../../../luvit/luvit/blob/master/lib/buffer.lua#L31)

### Functions

### [__concat](../../../luvit/luvit/blob/master/lib/buffer.lua#L60)

```lua
function Buffer.meta:__concat(other)
```

### [__index](../../../luvit/luvit/blob/master/lib/buffer.lua#L64)

```lua
function Buffer.meta:__index(key)
```

### [__ipairs](../../../luvit/luvit/blob/master/lib/buffer.lua#L46)

```lua
function Buffer.meta:__ipairs()
```

### [__newindex](../../../luvit/luvit/blob/master/lib/buffer.lua#L72)

```lua
function Buffer.meta:__newindex(key, value)
```

### [__tostring](../../../luvit/luvit/blob/master/lib/buffer.lua#L56)

```lua
function Buffer.meta:__tostring()
```

### [initialize](../../../luvit/luvit/blob/master/lib/buffer.lua#L33)

```lua
function Buffer:initialize(length)
```

### [inspect](../../../luvit/luvit/blob/master/lib/buffer.lua#L81)

```lua
function Buffer:inspect()
```

### [readInt16BE](../../../luvit/luvit/blob/master/lib/buffer.lua#L119)

```lua
function Buffer:readInt16BE(offset)
```

### [readInt16LE](../../../luvit/luvit/blob/master/lib/buffer.lua#L115)

```lua
function Buffer:readInt16LE(offset)
```

### [readInt32BE](../../../luvit/luvit/blob/master/lib/buffer.lua#L141)

```lua
function Buffer:readInt32BE(offset)
```

### [readInt32LE](../../../luvit/luvit/blob/master/lib/buffer.lua#L137)

```lua
function Buffer:readInt32LE(offset)
```

### [readInt8](../../../luvit/luvit/blob/master/lib/buffer.lua#L97)

```lua
function Buffer:readInt8(offset)
```

### [readUInt16BE](../../../luvit/luvit/blob/master/lib/buffer.lua#L110)

```lua
function Buffer:readUInt16BE(offset)
```

### [readUInt16LE](../../../luvit/luvit/blob/master/lib/buffer.lua#L105)

```lua
function Buffer:readUInt16LE(offset)
```

### [readUInt32BE](../../../luvit/luvit/blob/master/lib/buffer.lua#L130)

```lua
function Buffer:readUInt32BE(offset)
```

### [readUInt32LE](../../../luvit/luvit/blob/master/lib/buffer.lua#L123)

```lua
function Buffer:readUInt32LE(offset)
```

### [readUInt8](../../../luvit/luvit/blob/master/lib/buffer.lua#L93)

```lua
function Buffer:readUInt8(offset)
```

### Classes

### Class [Buffer](../../../luvit/luvit/blob/master/lib/buffer.lua#L30)

Extends Object

## Module childprocess

### Properties

### [Process](../../../luvit/luvit/blob/master/lib/childprocess.lua#L25)

### Functions

### [initialize](../../../luvit/luvit/blob/master/lib/childprocess.lua#L27)

```lua
function Process:initialize(command, args, options)
```

### [kill](../../../luvit/luvit/blob/master/lib/childprocess.lua#L51)

```lua
function Process:kill(signal)
```

### [spawn](../../../luvit/luvit/blob/master/lib/childprocess.lua#L55)

```lua
function process.spawn(...)
```

### Classes

### Class [Process](../../../luvit/luvit/blob/master/lib/childprocess.lua#L24)

Extends Handle

## Module core

This module is for various classes and utilities that don't need their own
module.

### Properties

### [meta](../../../luvit/luvit/blob/master/lib/core.lua#L36)

### [Emitter](../../../luvit/luvit/blob/master/lib/core.lua#L98)

### [Error](../../../luvit/luvit/blob/master/lib/core.lua#L286)

### [Handle](../../../luvit/luvit/blob/master/lib/core.lua#L200)

### [Object](../../../luvit/luvit/blob/master/lib/core.lua#L35)

This is the most basic object in Luvit. It provides simple prototypal
inheritance and inheritable constructors. All other objects inherit from this.

### [Stream](../../../luvit/luvit/blob/master/lib/core.lua#L235)

### [iStream](../../../luvit/luvit/blob/master/lib/core.lua#L278)

### Functions

### [emit](../../../luvit/luvit/blob/master/lib/core.lua#L136)

```lua
function Emitter:emit(name, ...)
```

Emit a named event to all listeners with optional data argument(s).

### [missingHandlerType](../../../luvit/luvit/blob/master/lib/core.lua#L101)

```lua
function Emitter:missingHandlerType(name, ...)
```

By default, and error events that are not listened for should thow errors

### [on](../../../luvit/luvit/blob/master/lib/core.lua#L118)

```lua
function Emitter:on(name, callback)
```

Adds an event listener (`callback`) for the named event `name`.

### [once](../../../luvit/luvit/blob/master/lib/core.lua#L109)

```lua
function Emitter:once(name, callback)
```

Same as `Emitter:on` except it de-registers itself after the first event.

### [removeListener](../../../luvit/luvit/blob/master/lib/core.lua#L159)

```lua
function Emitter:removeListener(name, callback)
```

Remove a listener so that it no longer catches events.

### [wrap](../../../luvit/luvit/blob/master/lib/core.lua#L185)

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

### [__tostring](../../../luvit/luvit/blob/master/lib/core.lua#L289)

```lua
function Error.meta.__tostring(table)
```

Make errors tostringable

### [initialize](../../../luvit/luvit/blob/master/lib/core.lua#L293)

```lua
function Error:initialize(message)
```

### [addHandlerType](../../../luvit/luvit/blob/master/lib/core.lua#L212)

```lua
function Handle:addHandlerType(name)
```

This is used by Emitters to register with native events when the first listener
is added.

### [close](../../../luvit/luvit/blob/master/lib/core.lua#L203)

```lua
function Handle:close()
```

Wrapper around `uv_close`. Closes the underlying file descriptor of a handle.

### [setHandler](../../../luvit/luvit/blob/master/lib/core.lua#L223)

```lua
function Handle:setHandler(name, callback)
```

Set or replace the handler for a native event.  Usually `Emitter:on()` is what
you want, not this.

### [create](../../../luvit/luvit/blob/master/lib/core.lua#L39)

```lua
function Object:create()
```

Create a new instance of this object

### [extend](../../../luvit/luvit/blob/master/lib/core.lua#L76)

```lua
function Object:extend()
```

Creates a new sub-class.

    local Square = Rectangle:extend()
    function Square:initialize(w)
      self.w = w
      self.h = h
    end

### [new](../../../luvit/luvit/blob/master/lib/core.lua#L59)

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

### [accept](../../../luvit/luvit/blob/master/lib/core.lua#L246)

```lua
function Stream:accept(other_stream)
```

### [listen](../../../luvit/luvit/blob/master/lib/core.lua#L241)

```lua
function Stream:listen(callback)
```

### [pipe](../../../luvit/luvit/blob/master/lib/core.lua#L262)

```lua
function Stream:pipe(target)
```

### [readStart](../../../luvit/luvit/blob/master/lib/core.lua#L250)

```lua
function Stream:readStart()
```

### [readStop](../../../luvit/luvit/blob/master/lib/core.lua#L254)

```lua
function Stream:readStop()
```

### [shutdown](../../../luvit/luvit/blob/master/lib/core.lua#L237)

```lua
function Stream:shutdown()
```

### [write](../../../luvit/luvit/blob/master/lib/core.lua#L258)

```lua
function Stream:write(chunk, callback)
```

### Classes

### Class [Emitter](../../../luvit/luvit/blob/master/lib/core.lua#L97)

Extends Object

This class can be used directly whenever an event emitter is needed.

    local emitter = Emitter:new()
    emitter:on('foo', p)
    emitter:emit('foo', 1, 2, 3)

Also it can easily be sub-classed.

    local Custom = Emitter:extend()
    local c = Custom:new()
    c:on('bar', onBar)

### Class [Error](../../../luvit/luvit/blob/master/lib/core.lua#L285)

Extends Object

This is for code that wants structured error messages.

### Class [Handle](../../../luvit/luvit/blob/master/lib/core.lua#L199)

Extends Emitter

This class is never used directly, but is the inheritance chain of all libuv
objects.

### Class [Stream](../../../luvit/luvit/blob/master/lib/core.lua#L234)

Extends Handle

This is never used directly.  If you want to create a pure Lua stream, subclass
or instantiate `core.iStream`.

### Class [iStream](../../../luvit/luvit/blob/master/lib/core.lua#L277)

Extends Emitter

This is an abstract interface that works like `core.Stream` but doesn't actually
contain a uv struct (it's pure lua)

## Module dns

### Functions

### [isIp](../../../luvit/luvit/blob/master/lib/dns.lua#L108)

```lua
function dns.isIp(ip)
```

### [isIpV4](../../../luvit/luvit/blob/master/lib/dns.lua#L112)

```lua
function dns.isIpV4(ip)
```

### [isIpV6](../../../luvit/luvit/blob/master/lib/dns.lua#L116)

```lua
function dns.isIpV6(ip)
```

### [lookup](../../../luvit/luvit/blob/master/lib/dns.lua#L74)

```lua
function dns.lookup(domain, family, callback)
```

### [resolve](../../../luvit/luvit/blob/master/lib/dns.lua#L58)

```lua
function dns.resolve(domain, rrtype, callback)
```

### [resolve4](../../../luvit/luvit/blob/master/lib/dns.lua#L26)

```lua
function dns.resolve4(domain, callback)
```

### [resolve6](../../../luvit/luvit/blob/master/lib/dns.lua#L30)

```lua
function dns.resolve6(domain, callback)
```

### [resolveCname](../../../luvit/luvit/blob/master/lib/dns.lua#L34)

```lua
function dns.resolveCname(domain, callback)
```

### [resolveMx](../../../luvit/luvit/blob/master/lib/dns.lua#L50)

```lua
function dns.resolveMx(domain, callback)
```

### [resolveNs](../../../luvit/luvit/blob/master/lib/dns.lua#L38)

```lua
function dns.resolveNs(domain, callback)
```

### [resolveSrv](../../../luvit/luvit/blob/master/lib/dns.lua#L42)

```lua
function dns.resolveSrv(domain, callback)
```

### [resolveTxt](../../../luvit/luvit/blob/master/lib/dns.lua#L46)

```lua
function dns.resolveTxt(domain, callback)
```

### [reverse](../../../luvit/luvit/blob/master/lib/dns.lua#L54)

```lua
function dns.reverse(ip, callback)
```

## Module fiber

### Functions

### [new](../../../luvit/luvit/blob/master/lib/fiber.lua#L22)

```lua
function fiber.new(fn)
```

## Module fs

### Properties

### [Watcher](../../../luvit/luvit/blob/master/lib/fs.lua#L236)

### Functions

### [initialize](../../../luvit/luvit/blob/master/lib/fs.lua#L238)

```lua
function Watcher:initialize(path)
```

### [createReadStream](../../../luvit/luvit/blob/master/lib/fs.lua#L129)

```lua
function fs.createReadStream(path, options)
```

TODO: Implement backpressure here and in tcp streams

### [createWriteStream](../../../luvit/luvit/blob/master/lib/fs.lua#L174)

```lua
function fs.createWriteStream(path, options)
```

### [exists](../../../luvit/luvit/blob/master/lib/fs.lua#L94)

```lua
function fs.exists(path, callback)
```

Wrap the core fs functions in forced sync and async versions

### [existsSync](../../../luvit/luvit/blob/master/lib/fs.lua#L106)

```lua
function fs.existsSync(path)
```

### [readFile](../../../luvit/luvit/blob/master/lib/fs.lua#L201)

```lua
function fs.readFile(path, callback)
```

### [readFileSync](../../../luvit/luvit/blob/master/lib/fs.lua#L184)

```lua
function fs.readFileSync(path)
```

### [writeFile](../../../luvit/luvit/blob/master/lib/fs.lua#L215)

```lua
function fs.writeFile(path, data, callback)
```

### Classes

### Class [Watcher](../../../luvit/luvit/blob/master/lib/fs.lua#L235)

Extends Handle

## Module http

### Properties

### [auto_chunked_encoding](../../../luvit/luvit/blob/master/lib/http.lua#L112)

### [auto_content_length](../../../luvit/luvit/blob/master/lib/http.lua#L113)

### [auto_content_type](../../../luvit/luvit/blob/master/lib/http.lua#L114)

### [auto_date](../../../luvit/luvit/blob/master/lib/http.lua#L110)

### [auto_server](../../../luvit/luvit/blob/master/lib/http.lua#L111)

### [Request](../../../luvit/luvit/blob/master/lib/http.lua#L87)

### [Response](../../../luvit/luvit/blob/master/lib/http.lua#L100)

### [STATUS_CODES](../../../luvit/luvit/blob/master/lib/http.lua#L82)

### Functions

### [close](../../../luvit/luvit/blob/master/lib/http.lua#L93)

```lua
function Request:close(...)
```

### [initialize](../../../luvit/luvit/blob/master/lib/http.lua#L89)

```lua
function Request:initialize(socket)
```

### [addHeader](../../../luvit/luvit/blob/master/lib/http.lua#L136)

```lua
function Response:addHeader(name, value)
```

Adds a header line.  This does not replace any header by the same name and
allows duplicate headers.  Returns the index it was inserted at

### [close](../../../luvit/luvit/blob/master/lib/http.lua#L301)

```lua
function Response:close(...)
```

### [finish](../../../luvit/luvit/blob/master/lib/http.lua#L266)

```lua
function Response:finish(chunk, callback)
```

### [flushHead](../../../luvit/luvit/blob/master/lib/http.lua#L152)

```lua
function Response:flushHead(callback)
```

### [initialize](../../../luvit/luvit/blob/master/lib/http.lua#L102)

```lua
function Response:initialize(socket)
```

### [setCode](../../../luvit/luvit/blob/master/lib/http.lua#L116)

```lua
function Response:setCode(code)
```

### [setHeader](../../../luvit/luvit/blob/master/lib/http.lua#L122)

```lua
function Response:setHeader(name, value)
```

This sets a header, replacing any header with the same name (case insensitive)

### [unsetHeader](../../../luvit/luvit/blob/master/lib/http.lua#L143)

```lua
function Response:unsetHeader(name)
```

Removes a set header.  Cannot remove headers added with :addHeader

### [write](../../../luvit/luvit/blob/master/lib/http.lua#L252)

```lua
function Response:write(chunk, callback)
```

### [writeContinue](../../../luvit/luvit/blob/master/lib/http.lua#L248)

```lua
function Response:writeContinue(callback)
```

### [writeHead](../../../luvit/luvit/blob/master/lib/http.lua#L234)

```lua
function Response:writeHead(code, headers, callback)
```

### [createServer](../../../luvit/luvit/blob/master/lib/http.lua#L382)

```lua
function http.createServer(host, port, onConnection)
```

### [request](../../../luvit/luvit/blob/master/lib/http.lua#L307)

```lua
function http.request(options, callback)
```

### Classes

### Class [Request](../../../luvit/luvit/blob/master/lib/http.lua#L86)

Extends iStream

### Class [Response](../../../luvit/luvit/blob/master/lib/http.lua#L99)

Extends iStream

## Module json

### Functions

### [parse](../../../luvit/luvit/blob/master/lib/json.lua#L101)

```lua
function JSON.parse(string, options)
```

### [streamingParser](../../../luvit/luvit/blob/master/lib/json.lua#L25)

```lua
function JSON.streamingParser(callback, options)
```

### [stringify](../../../luvit/luvit/blob/master/lib/json.lua#L111)

```lua
function JSON.stringify(value, options)
```

## Module luvit

### Properties

### [date](../../../luvit/luvit/blob/master/lib/luvit.lua#L53)

### [time](../../../luvit/luvit/blob/master/lib/luvit.lua#L54)

### [HTTP_VERSION](../../../luvit/luvit/blob/master/lib/luvit.lua#L70)

### [LUAJIT_VERSION](../../../luvit/luvit/blob/master/lib/luvit.lua#L68)

### [UV_VERSION](../../../luvit/luvit/blob/master/lib/luvit.lua#L69)

### [VERSION](../../../luvit/luvit/blob/master/lib/luvit.lua#L66)

### [YAJL_VERSION](../../../luvit/luvit/blob/master/lib/luvit.lua#L67)

### [argv](../../../luvit/luvit/blob/master/lib/luvit.lua#L96)

### [bit](../../../luvit/luvit/blob/master/lib/luvit.lua#L27)

### [coroutine](../../../luvit/luvit/blob/master/lib/luvit.lua#L25)

### [debug](../../../luvit/luvit/blob/master/lib/luvit.lua#L28)

### [dofile](../../../luvit/luvit/blob/master/lib/luvit.lua#L31)

### [getcwd](../../../luvit/luvit/blob/master/lib/luvit.lua#L94)

### [io](../../../luvit/luvit/blob/master/lib/luvit.lua#L21)

clear some globals
This will break lua code written for other lua runtimes

### [jit](../../../luvit/luvit/blob/master/lib/luvit.lua#L26)

### [loadfile](../../../luvit/luvit/blob/master/lib/luvit.lua#L30)

### [math](../../../luvit/luvit/blob/master/lib/luvit.lua#L23)

### [module](../../../luvit/luvit/blob/master/lib/luvit.lua#L309)

### [os](../../../luvit/luvit/blob/master/lib/luvit.lua#L22)

### [print](../../../luvit/luvit/blob/master/lib/luvit.lua#L33)

### [string](../../../luvit/luvit/blob/master/lib/luvit.lua#L24)

### [table](../../../luvit/luvit/blob/master/lib/luvit.lua#L29)

### [error_meta](../../../luvit/luvit/blob/master/lib/luvit.lua#L202)

### [config](../../../luvit/luvit/blob/master/lib/luvit.lua#L308)

### [cpath](../../../luvit/luvit/blob/master/lib/luvit.lua#L305)

### [os](../../../luvit/luvit/blob/master/lib/luvit.lua#L50)

### [os_binding](../../../luvit/luvit/blob/master/lib/luvit.lua#L52)

### [loaders](../../../luvit/luvit/blob/master/lib/luvit.lua#L303)

Remove the cwd based loaders, we don't want them

### [path](../../../luvit/luvit/blob/master/lib/luvit.lua#L304)

### [os_binding](../../../luvit/luvit/blob/master/lib/luvit.lua#L51)

### [searchpath](../../../luvit/luvit/blob/master/lib/luvit.lua#L306)

### [seeall](../../../luvit/luvit/blob/master/lib/luvit.lua#L307)

### [process](../../../luvit/luvit/blob/master/lib/luvit.lua#L56)

### [argv](../../../luvit/luvit/blob/master/lib/luvit.lua#L95)

### [cwd](../../../luvit/luvit/blob/master/lib/luvit.lua#L93)

### [env](../../../luvit/luvit/blob/master/lib/luvit.lua#L169)

Add global access to the environment variables using a dynamic table

### [stdin](../../../luvit/luvit/blob/master/lib/luvit.lua#L123)

Load the tty as a pair of pipes
But don't hold the event loop open for them

### [stdout](../../../luvit/luvit/blob/master/lib/luvit.lua#L124)

### [version](../../../luvit/luvit/blob/master/lib/luvit.lua#L58)

### [versions](../../../luvit/luvit/blob/master/lib/luvit.lua#L59)

### Functions

### [debug](../../../luvit/luvit/blob/master/lib/luvit.lua#L156)

```lua
function debug(...)
```

Like p, but prints to stderr using blocking I/O for better debugging

### [eventSource](../../../luvit/luvit/blob/master/lib/luvit.lua#L195)

```lua
function eventSource(name, fn, ...)
```

This is called by all the event sources from C
The user can override it to hook into event sources

### [p](../../../luvit/luvit/blob/master/lib/luvit.lua#L143)

```lua
function p(...)
```

A nice global data dumper

### [print](../../../luvit/luvit/blob/master/lib/luvit.lua#L131)

```lua
function print(...)
```

Replace print

### [exit](../../../luvit/luvit/blob/master/lib/luvit.lua#L72)

```lua
function process.exit(exit_code)
```

### [addHandlerType](../../../luvit/luvit/blob/master/lib/luvit.lua#L77)

```lua
function process:addHandlerType(name)
```

### [missingHandlerType](../../../luvit/luvit/blob/master/lib/luvit.lua#L85)

```lua
function process:missingHandlerType(name, ...)
```

### [require](../../../luvit/luvit/blob/master/lib/luvit.lua#L311)

```lua
function require(filepath, dirname)
```

## Module mime

### Properties

### [default](../../../luvit/luvit/blob/master/lib/mime.lua#L197)

### [table](../../../luvit/luvit/blob/master/lib/mime.lua#L196)

### Functions

### [getType](../../../luvit/luvit/blob/master/lib/mime.lua#L199)

```lua
function mime.getType(path)
```

## Module net

### Properties

### [Server](../../../luvit/luvit/blob/master/lib/net.lua#L175)

### [Socket](../../../luvit/luvit/blob/master/lib/net.lua#L177)

### [create](../../../luvit/luvit/blob/master/lib/net.lua#L193)

### Functions

### [close](../../../luvit/luvit/blob/master/lib/net.lua#L65)

```lua
function Server:close()
```

### [initialize](../../../luvit/luvit/blob/master/lib/net.lua#L73)

```lua
function Server:initialize(...)
```

### [listen](../../../luvit/luvit/blob/master/lib/net.lua#L31)

```lua
function Server:listen(port, ... --[[ ip, callback --]] )
```

### [_connect](../../../luvit/luvit/blob/master/lib/net.lua#L92)

```lua
function Socket:_connect(address, port, addressType)
```

### [close](../../../luvit/luvit/blob/master/lib/net.lua#L117)

```lua
function Socket:close()
```

### [connect](../../../luvit/luvit/blob/master/lib/net.lua#L132)

```lua
function Socket:connect(port, host, callback)
```

### [initialize](../../../luvit/luvit/blob/master/lib/net.lua#L168)

```lua
function Socket:initialize()
```

### [pipe](../../../luvit/luvit/blob/master/lib/net.lua#L123)

```lua
function Socket:pipe(destination)
```

### [setTimeout](../../../luvit/luvit/blob/master/lib/net.lua#L105)

```lua
function Socket:setTimeout(msecs, callback)
```

### [write](../../../luvit/luvit/blob/master/lib/net.lua#L127)

```lua
function Socket:write(data, callback)
```

### Classes

### Class [Server](../../../luvit/luvit/blob/master/lib/net.lua#L29)

Extends Emitter

### Class [Socket](../../../luvit/luvit/blob/master/lib/net.lua#L90)

Extends Emitter

## Module path

### Functions

### [basename](../../../luvit/luvit/blob/master/lib/path.lua#L110)

```lua
function path.basename(filepath, expected_ext)
```

### [dirname](../../../luvit/luvit/blob/master/lib/path.lua#L92)

```lua
function path.dirname(filepath)
```

### [extname](../../../luvit/luvit/blob/master/lib/path.lua#L114)

```lua
function path.extname(filepath)
```

### [join](../../../luvit/luvit/blob/master/lib/path.lua#L81)

```lua
function path.join(...)
```

### [normalize](../../../luvit/luvit/blob/master/lib/path.lua#L55)

```lua
function path.normalize(filepath)
```

Modifies an array of path parts in place by interpreting "." and ".." segments

### [resolve](../../../luvit/luvit/blob/master/lib/path.lua#L85)

```lua
function path.resolve(root, filepath)
```

## Module pipe

### Properties

### [Pipe](../../../luvit/luvit/blob/master/lib/pipe.lua#L25)

### Functions

### [bind](../../../luvit/luvit/blob/master/lib/pipe.lua#L35)

```lua
function Pipe:bind(name)
```

### [connect](../../../luvit/luvit/blob/master/lib/pipe.lua#L39)

```lua
function Pipe:connect(name)
```

### [initialize](../../../luvit/luvit/blob/master/lib/pipe.lua#L27)

```lua
function Pipe:initialize(ipc)
```

### [open](../../../luvit/luvit/blob/master/lib/pipe.lua#L31)

```lua
function Pipe:open(fd)
```

### Classes

### Class [Pipe](../../../luvit/luvit/blob/master/lib/pipe.lua#L24)

Extends Stream

## Module querystring

parse querystring into table.
urldecode tokens.

### Functions

### [parse](../../../luvit/luvit/blob/master/lib/querystring.lua#L68)

```lua
function querystring.parse(str, sep, eq)
```

parse querystring into table.
urldecode tokens.

### [urldecode](../../../luvit/luvit/blob/master/lib/querystring.lua#L38)

```lua
function querystring.urldecode(str)
```

decode %XX sequences
into corresponding
characters.
this comment
is
for purpose of documentation

### [urlencode](../../../luvit/luvit/blob/master/lib/querystring.lua#L53)

```lua
function querystring.urlencode(str)
```

this comment
is
for purpose of documentation

## Module repl

### Properties

### [colored_name](../../../luvit/luvit/blob/master/lib/repl.lua#L78)

### Functions

### [evaluateLine](../../../luvit/luvit/blob/master/lib/repl.lua#L39)

```lua
function repl.evaluateLine(line)
```

### [start](../../../luvit/luvit/blob/master/lib/repl.lua#L80)

```lua
function repl.start()
```

## Module stack

### Functions

### [compose](../../../luvit/luvit/blob/master/lib/stack.lua#L49)

```lua
function stack.compose(...)
```

Build a composite stack made of several layers

### [errorHandler](../../../luvit/luvit/blob/master/lib/stack.lua#L114)

```lua
function stack.errorHandler(req, res, err)
```

### [mount](../../../luvit/luvit/blob/master/lib/stack.lua#L76)

```lua
function stack.mount(mountpoint, ...)
```

Mounts a substack app at a url subtree

### [stack](../../../luvit/luvit/blob/master/lib/stack.lua#L22)

```lua
function stack.stack(...)
```

### [translate](../../../luvit/luvit/blob/master/lib/stack.lua#L88)

```lua
function stack.translate(mountpoint, matchpoint, ...)
```

## Module tcp

### Properties

### [Tcp](../../../luvit/luvit/blob/master/lib/tcp.lua#L25)

### Functions

### [bind](../../../luvit/luvit/blob/master/lib/tcp.lua#L43)

```lua
function Tcp:bind(host, port)
```

### [bind6](../../../luvit/luvit/blob/master/lib/tcp.lua#L48)

```lua
function Tcp:bind6(host, port)
```

### [connect](../../../luvit/luvit/blob/master/lib/tcp.lua#L63)

```lua
function Tcp:connect(ip_address, port)
```

### [connect6](../../../luvit/luvit/blob/master/lib/tcp.lua#L68)

```lua
function Tcp:connect6(ip_address, port)
```

### [getpeername](../../../luvit/luvit/blob/master/lib/tcp.lua#L58)

```lua
function Tcp:getpeername()
```

### [getsockname](../../../luvit/luvit/blob/master/lib/tcp.lua#L53)

```lua
function Tcp:getsockname()
```

### [initialize](../../../luvit/luvit/blob/master/lib/tcp.lua#L27)

```lua
function Tcp:initialize()
```

### [keepalive](../../../luvit/luvit/blob/master/lib/tcp.lua#L37)

```lua
function Tcp:keepalive(enable, delay)
```

### [nodelay](../../../luvit/luvit/blob/master/lib/tcp.lua#L32)

```lua
function Tcp:nodelay(enable)
```

### Classes

### Class [Tcp](../../../luvit/luvit/blob/master/lib/tcp.lua#L24)

Extends Stream

## Module timer

### Properties

### [Timer](../../../luvit/luvit/blob/master/lib/timer.lua#L24)

### Functions

### [again](../../../luvit/luvit/blob/master/lib/timer.lua#L38)

```lua
function Timer:again()
```

### [getRepeat](../../../luvit/luvit/blob/master/lib/timer.lua#L46)

```lua
function Timer:getRepeat()
```

### [initialize](../../../luvit/luvit/blob/master/lib/timer.lua#L26)

```lua
function Timer:initialize()
```

### [setRepeat](../../../luvit/luvit/blob/master/lib/timer.lua#L42)

```lua
function Timer:setRepeat(interval)
```

### [start](../../../luvit/luvit/blob/master/lib/timer.lua#L30)

```lua
function Timer:start(timeout, interval, callback)
```

### [stop](../../../luvit/luvit/blob/master/lib/timer.lua#L34)

```lua
function Timer:stop()
```

### [clearTimer](../../../luvit/luvit/blob/master/lib/timer.lua#L69)

```lua
function timer.clearTimer(timer)
```

### [setInterval](../../../luvit/luvit/blob/master/lib/timer.lua#L60)

```lua
function timer.setInterval(period, callback, ...)
```

### [setTimeout](../../../luvit/luvit/blob/master/lib/timer.lua#L50)

```lua
function timer.setTimeout(duration, callback, ...)
```

### Classes

### Class [Timer](../../../luvit/luvit/blob/master/lib/timer.lua#L22)

Extends Handle

## Module tty

### Properties

### [Tty](../../../luvit/luvit/blob/master/lib/tty.lua#L24)

### Functions

### [getWinsize](../../../luvit/luvit/blob/master/lib/tty.lua#L36)

```lua
function Tty:getWinsize()
```

### [initialize](../../../luvit/luvit/blob/master/lib/tty.lua#L26)

```lua
function Tty:initialize(fd, readable)
```

### [setMode](../../../luvit/luvit/blob/master/lib/tty.lua#L31)

```lua
function Tty:setMode(mode)
```

### [resetMode](../../../luvit/luvit/blob/master/lib/tty.lua#L41)

```lua
function tty.resetMode()
```

### Classes

### Class [Tty](../../../luvit/luvit/blob/master/lib/tty.lua#L23)

Extends Stream

## Module udp

### Properties

### [Udp](../../../luvit/luvit/blob/master/lib/udp.lua#L25)

### Functions

### [bind](../../../luvit/luvit/blob/master/lib/udp.lua#L31)

```lua
function Udp:bind(host, port)
```

### [bind6](../../../luvit/luvit/blob/master/lib/udp.lua#L35)

```lua
function Udp:bind6(host, port)
```

### [getsockname](../../../luvit/luvit/blob/master/lib/udp.lua#L43)

```lua
function Udp:getsockname()
```

### [initialize](../../../luvit/luvit/blob/master/lib/udp.lua#L27)

```lua
function Udp:initialize()
```

### [recvStart](../../../luvit/luvit/blob/master/lib/udp.lua#L55)

```lua
function Udp:recvStart()
```

### [recvStop](../../../luvit/luvit/blob/master/lib/udp.lua#L59)

```lua
function Udp:recvStop()
```

### [send](../../../luvit/luvit/blob/master/lib/udp.lua#L47)

```lua
function Udp:send(...)
```

### [send6](../../../luvit/luvit/blob/master/lib/udp.lua#L51)

```lua
function Udp:send6(...)
```

### [setMembership](../../../luvit/luvit/blob/master/lib/udp.lua#L39)

```lua
function Udp:setMembership(multicast_addr, interface_addr, option)
```

### Classes

### Class [Udp](../../../luvit/luvit/blob/master/lib/udp.lua#L24)

Extends Handle

## Module url

### Functions

### [parse](../../../luvit/luvit/blob/master/lib/url.lua#L21)

```lua
function url.parse(url)
```

## Module utils

### Functions

### [bind](../../../luvit/luvit/blob/master/lib/utils.lua#L135)

```lua
function utils.bind(fun, self, ...)
```

### [color](../../../luvit/luvit/blob/master/lib/utils.lua#L42)

```lua
function utils.color(color_name)
```

### [colorize](../../../luvit/luvit/blob/master/lib/utils.lua#L46)

```lua
function utils.colorize(color_name, string, reset_name)
```

### [dump](../../../luvit/luvit/blob/master/lib/utils.lua#L60)

```lua
function utils.dump(o, depth)
```


