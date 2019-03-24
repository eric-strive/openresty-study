ngx.sleep(0.03)
local args = ngx.req.get_uri_args()
ngx.print(tonumber(args.a) - tonumber(args.b))
