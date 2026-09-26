-- Pure LuaJIT SHA-256 implementation using the built-in 'bit' library.
-- Provides sha256.digest(str), sha256.hex(str), sha256.file(path).

local bit = bit or require("bit")
local band = bit.band
local bor = bit.bor
local bxor = bit.bxor
local bnot = bit.bnot
local rshift = bit.rshift
local ror = bit.ror or function(x, n)
    return bor(rshift(x, n), bit.lshift(x, 32 - n))
end

local M = {}

-- Initial hash values
local H_INIT = {
    0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
    0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
}

-- Round constants
local K = {
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
}

local function to_u32(val)
    return band(val, 0xFFFFFFFF)
end

local function add(a, b)
    return to_u32(a + b)
end

local function add4(a, b, c, d)
    return to_u32(a + b + c + d)
end

local function add5(a, b, c, d, e)
    return to_u32(a + b + c + d + e)
end

local function S0(x)
    return bxor(ror(x, 2), ror(x, 13), ror(x, 22))
end

local function S1(x)
    return bxor(ror(x, 6), ror(x, 11), ror(x, 25))
end

local function s0(x)
    return bxor(ror(x, 7), ror(x, 18), rshift(x, 3))
end

local function s1(x)
    return bxor(ror(x, 17), ror(x, 19), rshift(x, 10))
end

local function ch(x, y, z)
    return bxor(band(x, y), band(bnot(x), z))
end

local function maj(x, y, z)
    return bxor(band(x, y), band(x, z), band(y, z))
end

function M.new()
    local h0, h1, h2, h3, h4, h5, h6, h7 = unpack(H_INIT)
    local buffer = ""
    local total_len = 0
    local w = {}

    local self = {}

    local function process_chunk(chunk)
        for i = 0, 15 do
            local idx = i * 4 + 1
            local b1, b2, b3, b4 = string.byte(chunk, idx, idx + 3)
            w[i] = to_u32(b1 * 16777216 + b2 * 65536 + b3 * 256 + b4)
        end
        for i = 16, 63 do
            w[i] = add4(s1(w[i - 2]), w[i - 7], s0(w[i - 15]), w[i - 16])
        end

        local a, b, c, d, e, f, g, h = h0, h1, h2, h3, h4, h5, h6, h7
        for i = 0, 63 do
            local t1 = add5(h, S1(e), ch(e, f, g), K[i + 1], w[i])
            local t2 = add(S0(a), maj(a, b, c))
            h = g
            g = f
            f = e
            e = add(d, t1)
            d = c
            c = b
            b = a
            a = add(t1, t2)
        end

        h0 = add(h0, a)
        h1 = add(h1, b)
        h2 = add(h2, c)
        h3 = add(h3, d)
        h4 = add(h4, e)
        h5 = add(h5, f)
        h6 = add(h6, g)
        h7 = add(h7, h)
    end

    function self:update(data)
        buffer = buffer .. data
        total_len = total_len + #data
        while #buffer >= 64 do
            process_chunk(buffer:sub(1, 64))
            buffer = buffer:sub(65)
        end
        return self
    end

    function self:final()
        local bit_len = total_len * 8
        buffer = buffer .. string.char(0x80)
        local pad_len = (56 - (#buffer % 64)) % 64
        buffer = buffer .. string.rep(string.char(0), pad_len)

        -- Append 64-bit length (big-endian)
        local high = math.floor(bit_len / 4294967296)
        local low = bit_len % 4294967296
        local len_bytes = string.char(
            band(rshift(high, 24), 0xFF), band(rshift(high, 16), 0xFF),
            band(rshift(high, 8), 0xFF), band(high, 0xFF),
            band(rshift(low, 24), 0xFF), band(rshift(low, 16), 0xFF),
            band(rshift(low, 8), 0xFF), band(low, 0xFF)
        )
        buffer = buffer .. len_bytes

        while #buffer >= 64 do
            process_chunk(buffer:sub(1, 64))
            buffer = buffer:sub(65)
        end

        local function hex32(val)
            local u = (val < 0) and (val + 0x100000000) or val
            return string.format("%08x", u)
        end

        return hex32(h0) .. hex32(h1) .. hex32(h2) .. hex32(h3) ..
               hex32(h4) .. hex32(h5) .. hex32(h6) .. hex32(h7)
    end

    return self
end

function M.hex(data)
    local hasher = M.new()
    hasher:update(data)
    return hasher:final()
end

function M.file(filepath)
    local f, err = io.open(filepath, "rb")
    if not f then
        return nil, err
    end
    local hasher = M.new()
    while true do
        local chunk = f:read(65536)
        if not chunk or #chunk == 0 then break end
        hasher:update(chunk)
    end
    f:close()
    return hasher:final()
end

return M
