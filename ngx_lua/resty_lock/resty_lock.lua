local resty_lock = require "resty.lock"
local cache = ngx.shared.my_cache

local val, err = cache:get(key)
if val then
    ngx.say("result: ", val)
    return
end

if err then
    return fail("failed to get key from shm: ", err)
end

-- cache miss!
local lock, err = resty_lock:new("my_locks")
if not lock then
    return fail("failed to create lock: ", err)
end

--lua-resty-lock 库本身已经替你完成了 wait for lock 的过程
local elapsed, err = lock:lock(key)
if not elapsed then
    return fail("failed to acquire the lock: ", err)
end

-- 等待完成后直接获取信息
val, err = cache:get(key)
if val then
    local ok, err = lock:unlock()
    if not ok then
        return fail("failed to unlock: ", err)
    end

    ngx.say("result: ", val)
    return
end

-- 获取新的数据
local val = fetch_redis(key)
if not val then
    local ok, err = lock:unlock()
    if not ok then
        return fail("failed to unlock: ", err)
    end

    ngx.say("no value found")
    return
end

-- 存入缓存
local ok, err = cache:set(key, val, 1)
if not ok then
    local ok, err = lock:unlock()
    if not ok then
        return fail("failed to unlock: ", err)
    end

    return fail("failed to update shm cache: ", err)
end

local ok, err = lock:unlock()
if not ok then
    return fail("failed to unlock: ", err)
end

ngx.say("result: ", val)