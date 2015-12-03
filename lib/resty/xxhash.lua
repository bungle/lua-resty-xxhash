local ffi          = require "ffi"
local ffi_gc       = ffi.gc
local ffi_cdef     = ffi.cdef
local ffi_load     = ffi.load
local tonumber     = tonumber
local setmetatable = setmetatable

ffi_cdef[[
typedef enum { XXH_OK=0, XXH_ERROR } XXH_errorcode;
typedef struct { long long ll[ 6]; } XXH32_state_t;
typedef struct { long long ll[11]; } XXH64_state_t;
unsigned int       XXH32 (const void* input, size_t length, unsigned seed);
unsigned long long XXH64 (const void* input, size_t length, unsigned long long seed);
XXH32_state_t*     XXH32_createState(void);
XXH_errorcode      XXH32_freeState(XXH32_state_t* statePtr);
XXH64_state_t*     XXH64_createState(void);
XXH_errorcode      XXH64_freeState(XXH64_state_t* statePtr);
XXH_errorcode      XXH32_reset  (XXH32_state_t* statePtr, unsigned seed);
XXH_errorcode      XXH32_update (XXH32_state_t* statePtr, const void* input, size_t length);
unsigned int       XXH32_digest (const XXH32_state_t* statePtr);
XXH_errorcode      XXH64_reset  (XXH64_state_t* statePtr, unsigned long long seed);
XXH_errorcode      XXH64_update (XXH64_state_t* statePtr, const void* input, size_t length);
unsigned long long XXH64_digest (const XXH64_state_t* statePtr);
]]

local lib = ffi_load "xxhash"

local xxh32 = {}
xxh32.__index = xxh32

function xxh32:reset(seed)
    return lib.XXH32_reset(self.context, seed or 0) == 0 and self or nil
end

function xxh32:update(input)
    return lib.XXH32_update(self.context, input, #input) == 0 and self or nil
end

function xxh32:digest()
    return lib.XXH32_digest(self.context)
end

local xxh64 = {}
xxh64.__index = xxh64

function xxh64:reset(seed)
    return lib.XXH64_reset(self.context, seed or 0) == 0 and self or nil
end

function xxh64:update(input)
    return lib.XXH64_update(self.context, input, #input) == 0 and self or nil
end

function xxh64:digest()
    return tonumber(lib.XXH64_digest(self.context))
end

local xxhash = {}

function xxhash.new(seed, bits)
    local self = bits == 64 and setmetatable({ context = ffi_gc(lib.XXH64_createState(), lib.XXH64_freeState) }, xxh64)
                             or setmetatable({ context = ffi_gc(lib.XXH32_createState(), lib.XXH32_freeState) }, xxh32)
    return self:reset(seed) and self or nil
end

function xxhash.hash32(input, seed)
    return lib.XXH32(input, #input, seed or 0)
end

function xxhash.hash64(input, seed)
    return tonumber(lib.XXH64(input, #input, seed or 0))
end

local mt = {}

function mt:__call(input, seed, bits)
    return bits == 64 and xxhash.hash64(input, seed) or xxhash.hash32(input, seed)
end

return setmetatable(xxhash, mt)