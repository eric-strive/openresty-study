ngx.ctx.blah = 73
ngx.say("main pre: ", ngx.ctx.blah)
local res = ngx.location.capture("/lua/capture/capture1", { methon = ngx.HTTP_POST, body = 'test_post' })
ngx.print(res.truncated) -- 布尔值标记来判断 res.body 是否包含截断的数据
ngx.print(res.body)
ngx.say("main post: ", ngx.ctx.blah)