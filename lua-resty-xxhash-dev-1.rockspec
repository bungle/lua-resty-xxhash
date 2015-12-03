package = "lua-resty-xxhash"
version = "dev-1"
source = {
    url = "git://github.com/bungle/lua-resty-xxhash.git"
}
description = {
    summary = "LuaJIT FFI-bindings to xxHash, an Extremely fast non-cryptographic hash algorithm.",
    detailed = "lua-resty-xxhash contains a LuaJIT FFI-bindings to xxHash, an Extremely fast non-cryptographic hash algorithm.",
    homepage = "https://github.com/bungle/lua-resty-xxhash",
    maintainer = "Aapo Talvensaari <aapo.talvensaari@gmail.com>",
    license = "BSD"
}
dependencies = {
    "lua >= 5.1"
}
build = {
    type = "builtin",
    modules = {
        ["resty.xxhash"] = "lib/resty/xxhash.lua"
    }
}
