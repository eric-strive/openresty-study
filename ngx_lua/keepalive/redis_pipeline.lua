local redis = require "resty.redis"
local red = redis:new()

red:set_timeout(1000) -- 1 sec

-- or connect to a unix domain socket file listened
-- by a redis server:
--     local ok, err = red:connect("unix:/path/to/redis.sock")

local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    return
end
-- auth
local count
count, err = red:get_reused_times()
if 0 == count then
    local res, err = red:auth("123456")
    if not res then
        ngx.say("failed to authenticate: ", err)
        return
    end
elseif err then
    ngx.say("failed to get_reused_times: ", err)
end

red:init_pipeline()
red:set("cat", "Marry")
red:set("horse", "Bob")
red:set("horse2", "Bob")
red:set("horse3", "Bob")
red:set("horse4", "Bob")
red:set("horse5", "Bob")
red:get("cat")
red:get("horse")
local results, err = red:commit_pipeline()
if not results then
    ngx.say("failed to commit the pipelined requests: ", err)
    return
end

for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            ngx.say("failed to run command ", i, ": ", res[2])
        else
            ngx.say( res[1])
            ngx.say('32423423')
        end
    else
        ngx.say( res)
        ngx.say('32423423')
        -- process the scalar value
    end
end

-- put it into the connection pool of size 100,
-- with 10 seconds max idle time
local ok, err = red:set_keepalive(10000, 100)
if not ok then
    ngx.say("failed to set keepalive: ", err)
    return
end