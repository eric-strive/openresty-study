package.path = '/Users/wangwei/Study/openresty/ngx_lua/var_share/?.lua;;'
local args = ngx.req.get_uri_args();
local var = require ("var")
local result = var.calc(args.sum)
ngx.say(result)
--if var.calc() == 1 then
--    ngx.say("ok")
--else
--    ngx.status = ngx.HTTP_INTERNAL_SERVER_ERROR
--    ngx.say("error")
--end

--amount = 1
--local sum = args.sum
--amount = sum + amount
-- 模拟协程调度
--ngx.sleep(3)
--ngx.say(amount)