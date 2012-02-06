
## Module buffer

### Properties

### [Buffer](../../../luvit/luvit/blob/master/lib/buffer.lua#L31)

### Classes

### Class [Buffer](../../../luvit/luvit/blob/master/lib/buffer.lua#L30)

Extends Object

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/buffer.lua#L33)

#### [inspect](../../../luvit/luvit/blob/master/lib/buffer.lua#L81)

#### [readUInt8](../../../luvit/luvit/blob/master/lib/buffer.lua#L93)

#### [readInt8](../../../luvit/luvit/blob/master/lib/buffer.lua#L97)

#### [readUInt16LE](../../../luvit/luvit/blob/master/lib/buffer.lua#L105)

#### [readUInt16BE](../../../luvit/luvit/blob/master/lib/buffer.lua#L110)

#### [readInt16LE](../../../luvit/luvit/blob/master/lib/buffer.lua#L115)

#### [readInt16BE](../../../luvit/luvit/blob/master/lib/buffer.lua#L119)

#### [readUInt32LE](../../../luvit/luvit/blob/master/lib/buffer.lua#L123)

#### [readUInt32BE](../../../luvit/luvit/blob/master/lib/buffer.lua#L130)

#### [readInt32LE](../../../luvit/luvit/blob/master/lib/buffer.lua#L137)

#### [readInt32BE](../../../luvit/luvit/blob/master/lib/buffer.lua#L141)

## Module childprocess

### Properties

### [Process](../../../luvit/luvit/blob/master/lib/childprocess.lua#L25)

### Functions

### [spawn](../../../luvit/luvit/blob/master/lib/childprocess.lua#L55)

```lua
function spawn(...)
```

### Classes

### Class [Process](../../../luvit/luvit/blob/master/lib/childprocess.lua#L24)

Extends Handle

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/childprocess.lua#L27)

#### [kill](../../../luvit/luvit/blob/master/lib/childprocess.lua#L51)

## Module core

This module is for various classes and utilities that don't need their own
module.

### Properties

### [Emitter](../../../luvit/luvit/blob/master/lib/core.lua#L98)

### [Error](../../../luvit/luvit/blob/master/lib/core.lua#L286)

### [Handle](../../../luvit/luvit/blob/master/lib/core.lua#L200)

### [Object](../../../luvit/luvit/blob/master/lib/core.lua#L35)

This is the most basic object in Luvit. It provides simple prototypal
inheritance and inheritable constructors. All other objects inherit from this.

### [Stream](../../../luvit/luvit/blob/master/lib/core.lua#L235)

### [iStream](../../../luvit/luvit/blob/master/lib/core.lua#L278)

### [meta](../../../luvit/luvit/blob/master/lib/core.lua#L36)

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

#### Methods

#### [missingHandlerType](../../../luvit/luvit/blob/master/lib/core.lua#L101)

By default, and error events that are not listened for should thow errors

#### [once](../../../luvit/luvit/blob/master/lib/core.lua#L109)

Same as `Emitter:on` except it de-registers itself after the first event.

#### [on](../../../luvit/luvit/blob/master/lib/core.lua#L118)

Adds an event listener (`callback`) for the named event `name`.

#### [emit](../../../luvit/luvit/blob/master/lib/core.lua#L136)

Emit a named event to all listeners with optional data argument(s).

#### [removeListener](../../../luvit/luvit/blob/master/lib/core.lua#L159)

Remove a listener so that it no longer catches events.

#### [wrap](../../../luvit/luvit/blob/master/lib/core.lua#L185)

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

### Class [Error](../../../luvit/luvit/blob/master/lib/core.lua#L285)

Extends Object

This is for code that wants structured error messages.

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/core.lua#L293)

Make errors tostringable

### Class [Handle](../../../luvit/luvit/blob/master/lib/core.lua#L199)

Extends Emitter

This class is never used directly, but is the inheritance chain of all libuv
objects.

#### Methods

#### [close](../../../luvit/luvit/blob/master/lib/core.lua#L203)

Wrapper around `uv_close`. Closes the underlying file descriptor of a handle.

#### [addHandlerType](../../../luvit/luvit/blob/master/lib/core.lua#L212)

This is used by Emitters to register with native events when the first listener
is added.

#### [setHandler](../../../luvit/luvit/blob/master/lib/core.lua#L223)

Set or replace the handler for a native event.  Usually `Emitter:on()` is what
you want, not this.

### Class [Stream](../../../luvit/luvit/blob/master/lib/core.lua#L234)

Extends Handle

This is never used directly.  If you want to create a pure Lua stream, subclass
or instantiate `core.iStream`.

#### Methods

#### [shutdown](../../../luvit/luvit/blob/master/lib/core.lua#L237)

#### [listen](../../../luvit/luvit/blob/master/lib/core.lua#L241)

#### [accept](../../../luvit/luvit/blob/master/lib/core.lua#L246)

#### [readStart](../../../luvit/luvit/blob/master/lib/core.lua#L250)

#### [readStop](../../../luvit/luvit/blob/master/lib/core.lua#L254)

#### [write](../../../luvit/luvit/blob/master/lib/core.lua#L258)

#### [pipe](../../../luvit/luvit/blob/master/lib/core.lua#L262)

### Class [iStream](../../../luvit/luvit/blob/master/lib/core.lua#L277)

Extends Emitter

This is an abstract interface that works like `core.Stream` but doesn't actually
contain a uv struct (it's pure lua)

## Module dns

### Functions

### [isIp](../../../luvit/luvit/blob/master/lib/dns.lua#L108)

```lua
function isIp(ip)
```

### [isIpV4](../../../luvit/luvit/blob/master/lib/dns.lua#L112)

```lua
function isIpV4(ip)
```

### [isIpV6](../../../luvit/luvit/blob/master/lib/dns.lua#L116)

```lua
function isIpV6(ip)
```

### [lookup](../../../luvit/luvit/blob/master/lib/dns.lua#L74)

```lua
function lookup(domain, family, callback)
```

### [resolve](../../../luvit/luvit/blob/master/lib/dns.lua#L58)

```lua
function resolve(domain, rrtype, callback)
```

### [resolve4](../../../luvit/luvit/blob/master/lib/dns.lua#L26)

```lua
function resolve4(domain, callback)
```

### [resolve6](../../../luvit/luvit/blob/master/lib/dns.lua#L30)

```lua
function resolve6(domain, callback)
```

### [resolveCname](../../../luvit/luvit/blob/master/lib/dns.lua#L34)

```lua
function resolveCname(domain, callback)
```

### [resolveMx](../../../luvit/luvit/blob/master/lib/dns.lua#L50)

```lua
function resolveMx(domain, callback)
```

### [resolveNs](../../../luvit/luvit/blob/master/lib/dns.lua#L38)

```lua
function resolveNs(domain, callback)
```

### [resolveSrv](../../../luvit/luvit/blob/master/lib/dns.lua#L42)

```lua
function resolveSrv(domain, callback)
```

### [resolveTxt](../../../luvit/luvit/blob/master/lib/dns.lua#L46)

```lua
function resolveTxt(domain, callback)
```

### [reverse](../../../luvit/luvit/blob/master/lib/dns.lua#L54)

```lua
function reverse(ip, callback)
```

## Module fiber

### Functions

### [new](../../../luvit/luvit/blob/master/lib/fiber.lua#L22)

```lua
function new(fn)
```

## Module fs

### Properties

### [Watcher](../../../luvit/luvit/blob/master/lib/fs.lua#L236)

### Functions

### [createReadStream](../../../luvit/luvit/blob/master/lib/fs.lua#L129)

```lua
function createReadStream(path, options)
```

TODO: Implement backpressure here and in tcp streams

### [createWriteStream](../../../luvit/luvit/blob/master/lib/fs.lua#L174)

```lua
function createWriteStream(path, options)
```

### [exists](../../../luvit/luvit/blob/master/lib/fs.lua#L94)

```lua
function exists(path, callback)
```

Wrap the core fs functions in forced sync and async versions

### [existsSync](../../../luvit/luvit/blob/master/lib/fs.lua#L106)

```lua
function existsSync(path)
```

### [readFile](../../../luvit/luvit/blob/master/lib/fs.lua#L201)

```lua
function readFile(path, callback)
```

### [readFileSync](../../../luvit/luvit/blob/master/lib/fs.lua#L184)

```lua
function readFileSync(path)
```

### [writeFile](../../../luvit/luvit/blob/master/lib/fs.lua#L215)

```lua
function writeFile(path, data, callback)
```

### Classes

### Class [Watcher](../../../luvit/luvit/blob/master/lib/fs.lua#L235)

Extends Handle

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/fs.lua#L238)

## Module http

### Properties

### [Request](../../../luvit/luvit/blob/master/lib/http.lua#L87)

### [Response](../../../luvit/luvit/blob/master/lib/http.lua#L100)

### [STATUS_CODES](../../../luvit/luvit/blob/master/lib/http.lua#L82)

### [auto_chunked_encoding](../../../luvit/luvit/blob/master/lib/http.lua#L112)

### [auto_content_length](../../../luvit/luvit/blob/master/lib/http.lua#L113)

### [auto_content_type](../../../luvit/luvit/blob/master/lib/http.lua#L114)

### [auto_date](../../../luvit/luvit/blob/master/lib/http.lua#L110)

### [auto_server](../../../luvit/luvit/blob/master/lib/http.lua#L111)

### Functions

### [createServer](../../../luvit/luvit/blob/master/lib/http.lua#L382)

```lua
function createServer(host, port, onConnection)
```

### [request](../../../luvit/luvit/blob/master/lib/http.lua#L307)

```lua
function request(options, callback)
```

### Classes

### Class [Request](../../../luvit/luvit/blob/master/lib/http.lua#L86)

Extends iStream

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/http.lua#L89)

#### [close](../../../luvit/luvit/blob/master/lib/http.lua#L93)

### Class [Response](../../../luvit/luvit/blob/master/lib/http.lua#L99)

Extends iStream

#### Properties

#### [auto_date](../../../luvit/luvit/blob/master/lib/http.lua#L110)

#### [auto_server](../../../luvit/luvit/blob/master/lib/http.lua#L111)

#### [auto_chunked_encoding](../../../luvit/luvit/blob/master/lib/http.lua#L112)

#### [auto_content_length](../../../luvit/luvit/blob/master/lib/http.lua#L113)

#### [auto_content_type](../../../luvit/luvit/blob/master/lib/http.lua#L114)

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/http.lua#L102)

#### [setCode](../../../luvit/luvit/blob/master/lib/http.lua#L116)

#### [setHeader](../../../luvit/luvit/blob/master/lib/http.lua#L122)

This sets a header, replacing any header with the same name (case insensitive)

#### [addHeader](../../../luvit/luvit/blob/master/lib/http.lua#L136)

Adds a header line.  This does not replace any header by the same name and
allows duplicate headers.  Returns the index it was inserted at

#### [unsetHeader](../../../luvit/luvit/blob/master/lib/http.lua#L143)

Removes a set header.  Cannot remove headers added with :addHeader

#### [flushHead](../../../luvit/luvit/blob/master/lib/http.lua#L152)

#### [writeHead](../../../luvit/luvit/blob/master/lib/http.lua#L234)

#### [writeContinue](../../../luvit/luvit/blob/master/lib/http.lua#L248)

#### [write](../../../luvit/luvit/blob/master/lib/http.lua#L252)

#### [finish](../../../luvit/luvit/blob/master/lib/http.lua#L266)

#### [close](../../../luvit/luvit/blob/master/lib/http.lua#L301)

## Module json

### Functions

### [parse](../../../luvit/luvit/blob/master/lib/json.lua#L101)

```lua
function parse(string, options)
```

### [streamingParser](../../../luvit/luvit/blob/master/lib/json.lua#L25)

```lua
function streamingParser(callback, options)
```

### [stringify](../../../luvit/luvit/blob/master/lib/json.lua#L111)

```lua
function stringify(value, options)
```

## Module luvit

### Properties

### [HTTP_VERSION](../../../luvit/luvit/blob/master/lib/luvit.lua#L70)

### [LUAJIT_VERSION](../../../luvit/luvit/blob/master/lib/luvit.lua#L68)

### [UV_VERSION](../../../luvit/luvit/blob/master/lib/luvit.lua#L69)

### [VERSION](../../../luvit/luvit/blob/master/lib/luvit.lua#L66)

### [YAJL_VERSION](../../../luvit/luvit/blob/master/lib/luvit.lua#L67)

### [argv](../../../luvit/luvit/blob/master/lib/luvit.lua#L95)

### [argv](../../../luvit/luvit/blob/master/lib/luvit.lua#L96)

### [bit](../../../luvit/luvit/blob/master/lib/luvit.lua#L27)

### [config](../../../luvit/luvit/blob/master/lib/luvit.lua#L308)

### [coroutine](../../../luvit/luvit/blob/master/lib/luvit.lua#L25)

### [cpath](../../../luvit/luvit/blob/master/lib/luvit.lua#L305)

### [cwd](../../../luvit/luvit/blob/master/lib/luvit.lua#L93)

### [date](../../../luvit/luvit/blob/master/lib/luvit.lua#L53)

### [debug](../../../luvit/luvit/blob/master/lib/luvit.lua#L28)

### [dofile](../../../luvit/luvit/blob/master/lib/luvit.lua#L31)

### [env](../../../luvit/luvit/blob/master/lib/luvit.lua#L169)

Add global access to the environment variables using a dynamic table

### [getcwd](../../../luvit/luvit/blob/master/lib/luvit.lua#L94)

### [io](../../../luvit/luvit/blob/master/lib/luvit.lua#L21)

clear some globals
This will break lua code written for other lua runtimes

### [jit](../../../luvit/luvit/blob/master/lib/luvit.lua#L26)

### [loaders](../../../luvit/luvit/blob/master/lib/luvit.lua#L303)

Remove the cwd based loaders, we don't want them

### [loadfile](../../../luvit/luvit/blob/master/lib/luvit.lua#L30)

### [math](../../../luvit/luvit/blob/master/lib/luvit.lua#L23)

### [module](../../../luvit/luvit/blob/master/lib/luvit.lua#L309)

### [os](../../../luvit/luvit/blob/master/lib/luvit.lua#L22)

### [path](../../../luvit/luvit/blob/master/lib/luvit.lua#L304)

### [print](../../../luvit/luvit/blob/master/lib/luvit.lua#L33)

### [searchpath](../../../luvit/luvit/blob/master/lib/luvit.lua#L306)

### [seeall](../../../luvit/luvit/blob/master/lib/luvit.lua#L307)

### [stdin](../../../luvit/luvit/blob/master/lib/luvit.lua#L123)

Load the tty as a pair of pipes
But don't hold the event loop open for them

### [stdout](../../../luvit/luvit/blob/master/lib/luvit.lua#L124)

### [string](../../../luvit/luvit/blob/master/lib/luvit.lua#L24)

### [table](../../../luvit/luvit/blob/master/lib/luvit.lua#L29)

### [time](../../../luvit/luvit/blob/master/lib/luvit.lua#L54)

### [version](../../../luvit/luvit/blob/master/lib/luvit.lua#L58)

### [versions](../../../luvit/luvit/blob/master/lib/luvit.lua#L59)

### Functions

### [exit](../../../luvit/luvit/blob/master/lib/luvit.lua#L72)

```lua
function exit(exit_code)
```

## Module mime

### Properties

### [default](../../../luvit/luvit/blob/master/lib/mime.lua#L197)

### [table](../../../luvit/luvit/blob/master/lib/mime.lua#L196)

### Functions

### [getType](../../../luvit/luvit/blob/master/lib/mime.lua#L199)

```lua
function getType(path)
```

## Module net

### Properties

### [Server](../../../luvit/luvit/blob/master/lib/net.lua#L175)

### [Socket](../../../luvit/luvit/blob/master/lib/net.lua#L177)

### [create](../../../luvit/luvit/blob/master/lib/net.lua#L193)

### Classes

### Class [Server](../../../luvit/luvit/blob/master/lib/net.lua#L29)

Extends Emitter

#### Methods

#### [listen](../../../luvit/luvit/blob/master/lib/net.lua#L31)

#### [close](../../../luvit/luvit/blob/master/lib/net.lua#L65)

#### [initialize](../../../luvit/luvit/blob/master/lib/net.lua#L73)

### Class [Socket](../../../luvit/luvit/blob/master/lib/net.lua#L90)

Extends Emitter

#### Methods

#### [_connect](../../../luvit/luvit/blob/master/lib/net.lua#L92)

#### [setTimeout](../../../luvit/luvit/blob/master/lib/net.lua#L105)

#### [close](../../../luvit/luvit/blob/master/lib/net.lua#L117)

#### [pipe](../../../luvit/luvit/blob/master/lib/net.lua#L123)

#### [write](../../../luvit/luvit/blob/master/lib/net.lua#L127)

#### [connect](../../../luvit/luvit/blob/master/lib/net.lua#L132)

#### [initialize](../../../luvit/luvit/blob/master/lib/net.lua#L168)

## Module path

### Functions

### [basename](../../../luvit/luvit/blob/master/lib/path.lua#L110)

```lua
function basename(filepath, expected_ext)
```

### [dirname](../../../luvit/luvit/blob/master/lib/path.lua#L92)

```lua
function dirname(filepath)
```

### [extname](../../../luvit/luvit/blob/master/lib/path.lua#L114)

```lua
function extname(filepath)
```

### [join](../../../luvit/luvit/blob/master/lib/path.lua#L81)

```lua
function join(...)
```

### [normalize](../../../luvit/luvit/blob/master/lib/path.lua#L55)

```lua
function normalize(filepath)
```

Modifies an array of path parts in place by interpreting "." and ".." segments

### [resolve](../../../luvit/luvit/blob/master/lib/path.lua#L85)

```lua
function resolve(root, filepath)
```

## Module pipe

### Properties

### [Pipe](../../../luvit/luvit/blob/master/lib/pipe.lua#L25)

### Classes

### Class [Pipe](../../../luvit/luvit/blob/master/lib/pipe.lua#L24)

Extends Stream

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/pipe.lua#L27)

#### [open](../../../luvit/luvit/blob/master/lib/pipe.lua#L31)

#### [bind](../../../luvit/luvit/blob/master/lib/pipe.lua#L35)

#### [connect](../../../luvit/luvit/blob/master/lib/pipe.lua#L39)

## Module querystring

parse querystring into table.
urldecode tokens.

### Functions

### [parse](../../../luvit/luvit/blob/master/lib/querystring.lua#L68)

```lua
function parse(str, sep, eq)
```

parse querystring into table.
urldecode tokens.

### [urldecode](../../../luvit/luvit/blob/master/lib/querystring.lua#L38)

```lua
function urldecode(str)
```

decode %XX sequences
into corresponding
characters.
this comment
is
for purpose of documentation

### [urlencode](../../../luvit/luvit/blob/master/lib/querystring.lua#L53)

```lua
function urlencode(str)
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
function evaluateLine(line)
```

### [start](../../../luvit/luvit/blob/master/lib/repl.lua#L80)

```lua
function start()
```

## Module stack

### Functions

### [compose](../../../luvit/luvit/blob/master/lib/stack.lua#L49)

```lua
function compose(...)
```

Build a composite stack made of several layers

### [errorHandler](../../../luvit/luvit/blob/master/lib/stack.lua#L114)

```lua
function errorHandler(req, res, err)
```

### [mount](../../../luvit/luvit/blob/master/lib/stack.lua#L76)

```lua
function mount(mountpoint, ...)
```

Mounts a substack app at a url subtree

### [stack](../../../luvit/luvit/blob/master/lib/stack.lua#L22)

```lua
function stack(...)
```

### [translate](../../../luvit/luvit/blob/master/lib/stack.lua#L88)

```lua
function translate(mountpoint, matchpoint, ...)
```

## Module tcp

### Properties

### [Tcp](../../../luvit/luvit/blob/master/lib/tcp.lua#L25)

### Classes

### Class [Tcp](../../../luvit/luvit/blob/master/lib/tcp.lua#L24)

Extends Stream

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/tcp.lua#L27)

#### [nodelay](../../../luvit/luvit/blob/master/lib/tcp.lua#L32)

#### [keepalive](../../../luvit/luvit/blob/master/lib/tcp.lua#L37)

#### [bind](../../../luvit/luvit/blob/master/lib/tcp.lua#L43)

#### [bind6](../../../luvit/luvit/blob/master/lib/tcp.lua#L48)

#### [getsockname](../../../luvit/luvit/blob/master/lib/tcp.lua#L53)

#### [getpeername](../../../luvit/luvit/blob/master/lib/tcp.lua#L58)

#### [connect](../../../luvit/luvit/blob/master/lib/tcp.lua#L63)

#### [connect6](../../../luvit/luvit/blob/master/lib/tcp.lua#L68)

## Module timer

### Properties

### [Timer](../../../luvit/luvit/blob/master/lib/timer.lua#L24)

### Functions

### [clearTimer](../../../luvit/luvit/blob/master/lib/timer.lua#L69)

```lua
function clearTimer(timer)
```

### [setInterval](../../../luvit/luvit/blob/master/lib/timer.lua#L60)

```lua
function setInterval(period, callback, ...)
```

### [setTimeout](../../../luvit/luvit/blob/master/lib/timer.lua#L50)

```lua
function setTimeout(duration, callback, ...)
```

### Classes

### Class [Timer](../../../luvit/luvit/blob/master/lib/timer.lua#L22)

Extends Handle

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/timer.lua#L26)

#### [start](../../../luvit/luvit/blob/master/lib/timer.lua#L30)

#### [stop](../../../luvit/luvit/blob/master/lib/timer.lua#L34)

#### [again](../../../luvit/luvit/blob/master/lib/timer.lua#L38)

#### [setRepeat](../../../luvit/luvit/blob/master/lib/timer.lua#L42)

#### [getRepeat](../../../luvit/luvit/blob/master/lib/timer.lua#L46)

## Module tty

### Properties

### [Tty](../../../luvit/luvit/blob/master/lib/tty.lua#L24)

### Functions

### [resetMode](../../../luvit/luvit/blob/master/lib/tty.lua#L41)

```lua
function resetMode()
```

### Classes

### Class [Tty](../../../luvit/luvit/blob/master/lib/tty.lua#L23)

Extends Stream

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/tty.lua#L26)

#### [setMode](../../../luvit/luvit/blob/master/lib/tty.lua#L31)

#### [getWinsize](../../../luvit/luvit/blob/master/lib/tty.lua#L36)

## Module udp

### Properties

### [Udp](../../../luvit/luvit/blob/master/lib/udp.lua#L25)

### Classes

### Class [Udp](../../../luvit/luvit/blob/master/lib/udp.lua#L24)

Extends Handle

#### Methods

#### [initialize](../../../luvit/luvit/blob/master/lib/udp.lua#L27)

#### [bind](../../../luvit/luvit/blob/master/lib/udp.lua#L31)

#### [bind6](../../../luvit/luvit/blob/master/lib/udp.lua#L35)

#### [setMembership](../../../luvit/luvit/blob/master/lib/udp.lua#L39)

#### [getsockname](../../../luvit/luvit/blob/master/lib/udp.lua#L43)

#### [send](../../../luvit/luvit/blob/master/lib/udp.lua#L47)

#### [send6](../../../luvit/luvit/blob/master/lib/udp.lua#L51)

#### [recvStart](../../../luvit/luvit/blob/master/lib/udp.lua#L55)

#### [recvStop](../../../luvit/luvit/blob/master/lib/udp.lua#L59)

## Module url

### Functions

### [parse](../../../luvit/luvit/blob/master/lib/url.lua#L21)

```lua
function parse(url)
```

## Module utils

### Functions

### [bind](../../../luvit/luvit/blob/master/lib/utils.lua#L135)

```lua
function bind(fun, self, ...)
```

### [color](../../../luvit/luvit/blob/master/lib/utils.lua#L42)

```lua
function color(color_name)
```

### [colorize](../../../luvit/luvit/blob/master/lib/utils.lua#L46)

```lua
function colorize(color_name, string, reset_name)
```

### [dump](../../../luvit/luvit/blob/master/lib/utils.lua#L60)

```lua
function dump(o, depth)
```























