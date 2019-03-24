function get_from_cache(key)
    local cache_ngx = ngx.shared.my_cache
    local value = cache_ngx:get(key)
    return value
end

function set_to_cache(key, value, exptime)
    if not exptime then
        exptime = 0
    end

    local cache_ngx = ngx.shared.my_cache
    local succ, err, forcible = cache_ngx:set(key, value, exptime)
    return succ
end

set_to_cache('wang',100,100);
ngx.say(get_from_cache('wang'))


--local _M = {}

-- alternatively: local lrucache = require "resty.lrucache.pureffi"
--local lrucache = require "resty.lrucache"

-- we need to initialize the cache on the Lua module level so that
-- it can be shared by all the requests served by each nginx worker process:
--local c = lrucache.new(200)  -- allow up to 200 items in the cache
--if not c then
--    return error("failed to create the cache: " .. (err or "unknown"))
--end
--
--function _M.go()
--    c:set("dog", 32)
--    c:set("cat", 56)
--    ngx.say("dog: ", c:get("dog"))
--    ngx.say("cat: ", c:get("cat"))
--
--    c:set("dog", { age = 10 }, 0.1)  -- expire in 0.1 sec
--    c:delete("dog")
--end
--
--return _M
