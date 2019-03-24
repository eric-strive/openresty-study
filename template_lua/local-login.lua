local req = require "req"
local cjson = require "cjson"

local args = req.getArgs()

-- GET
local res = ngx.location.capture('/user/login', {method = ngx.HTTP_GET, args = args})
-- POST
-- local res = ngx.location.capture('/user/login', {method = ngx.HTTP_POST, body = ngx.encode_args(args)})

-- print(res.status) -- 状态码

if res.status == 200 then
    local ret = cjson.decode(res.body)
    ret['from'] = 'local'
    ngx.say(cjson.encode(ret))
else
    print(res.body)
    ngx.say('{"ret": false, "from": "local"}')
end