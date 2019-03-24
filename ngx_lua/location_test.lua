--function dump(info)
--    ngx.say(info .. '<br>')
--end
--
--ngx.sleep(1)
--local args = ngx.req.get_uri_args()
--dump(tonumber(args.a) + tonumber(args.b))

local start_time = ngx.now()
local res1, res2 = ngx.location.capture_multi({
    { "/sum", { args = { a = 3, b = 8 } } },
    { "/subduction", { args = { a = 3, b = 8 } } }
})
ngx.say("status:", res1.status, " response:", res1.body)
ngx.say("status:", res2.status, " response:", res2.body)
ngx.say("time used:", ngx.now() - start_time)




local start_time = ngx.now()
local res1, res2 = ngx.location.capture_multi({
    { "/lua/", { args = { a = 3, b = 8 } } },
    { "/subduction", { args = { a = 3, b = 8 } } }
})
ngx.say("status:", res1.status, " response:", res1.body)
ngx.say("status:", res2.status, " response:", res2.body)
ngx.say("time used:", ngx.now() - start_time)