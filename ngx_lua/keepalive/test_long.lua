local redis = require "resty.redis"
local red = redis:new()

red:set_timeout(1000) -- 1 sec

local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    return --不管是什么错误要习惯性的返回，为了防止将错误的信息放入连接池；
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


ok, err = red:set("dog_test_long", "an animal 222"..ngx.time())
if not ok then
    ngx.say("failed to set dog: ", err)
    return
end

ngx.say("set result: ", ok)

local res, err = red:get("dog_test_long")
if not res then
    ngx.say("failed to get dog: ", err)
    return
end

if res == ngx.null then
    ngx.say("dog not found.")
    return
end

ngx.say("dog_test_long: ", res)
--当连接操过最大连接大小时，会按照LRU算法回收空闲连接为新的连接使用
--连接池中的空闲连接出现异常时会被自动移除
local ok, err = red:set_keepalive(10000, 1000)
if not ok then
    ngx.say("failed to set keepalive: ", err)
    return
end