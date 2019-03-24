
ngx.req.read_body()
local arg_body = ngx.req.get_post_args();
for k, v in pairs(arg_body) do
    ngx.say(k..':',v)
end




ngx.say("sub pre: ", ngx.ctx.blah)
ngx.say("sub pre: ", ngx.ctx.blah)
ngx.ctx.blah = 32
ngx.say("sub post: ", ngx.ctx.blah)