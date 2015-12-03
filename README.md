# lua-resty-xxhash

`lua-resty-xxhash` contains a LuaJIT FFI-bindings to xxHash, an Extremely fast non-cryptographic hash algorithm.

## Installation

Just place [`xxhash.lua`](https://github.com/bungle/lua-resty-xxhash/blob/master/lib/resty/xxhash.lua) somewhere in your `package.path`, preferably under `resty` directory. If you are using OpenResty, the default location would be `/usr/local/openresty/lualib/resty`.

### Compiling and Installing xxHash C-library

1. First clone this repo: https://github.com/Cyan4973/xxHash
2. Run `gcc xxhash.c -O3 -o libxxhash.dylib -shared -fPIC` (on Linux) or `gcc xxhash.c -O3 -o libxxhash.dylib -shared` (OS X)
4. Place `libxxhash.so` somewhere in the default search path for dynamic libraries of your operating system (or modify `xxhash.lua` and point `ffi_load "xxhash"` with full path to `libxxhash.so`, e.g. `local lib = ffi_load "/usr/local/lib/lua/5.1/libxxhash.so"`).

### Using LuaRocks or MoonRocks

If you are using LuaRocks >= 2.2:

```Shell
$ luarocks install lua-resty-xxhash
```

If you are using LuaRocks < 2.2:

```Shell
$ luarocks install --server=http://rocks.moonscript.org moonrocks
$ moonrocks install lua-resty-xxhash
```

LuaRocks repository for `lua-resty-xxhash` is located here: https://luarocks.org/modules/bungle/lua-resty-xxhash.

## License

`lua-resty-xxhash` uses two clause BSD license.

```
Copyright (c) 2015, Aapo Talvensaari
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimer in the documentation and/or
  other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
