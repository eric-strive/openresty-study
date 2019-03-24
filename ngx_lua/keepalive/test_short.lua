local redis = require "resty.redis"
local red = redis:new()

--red:set_timeout(1000) -- 1 sec

-- or connect to a unix domain socket file listened
-- by a redis server:
--     local ok, err = red:connect("unix:/path/to/redis.sock")

local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    return
end

local res, err = red:auth("123456")
if not res then
    ngx.say("failed to authenticate: ", err)
    return
end

ok, err = red:set("dog_test_short", "an animal dog_test_short"..ngx.time())
if not ok then
    ngx.say("failed to set dog: ", err)
    return
end

ngx.say("set result: ", ok)

local res, err = red:get("dog_test_short")
if not res then
    ngx.say("failed to get dog: ", err)
    return
end

if res == ngx.null then
    ngx.say("dog not found.")
    return
end

ngx.say("dog_test_short: ", res)
red:close()