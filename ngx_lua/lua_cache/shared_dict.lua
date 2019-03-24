local mycache = ngx.shared.my_cache
mycache:set('key','value_key',100)
ngx.say(mycache:get('key'))

local lrucache = require "resty.lrucache"
local l = lrucache.new(100)
l:set('lru_key',100)
ngx.say(l:get('lru_key'))