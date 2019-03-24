ngx.sleep(0.04)
local args = ngx.req.get_uri_args()
ngx.print(tonumber(args.a) + tonumber(args.b))

--function sleep(n)
--    os.execute("sleep " .. n)
--end
--sleep(0.01)
--ngx.say("ok")