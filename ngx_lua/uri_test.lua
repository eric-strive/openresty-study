local test_cache = ngx.shared.test_cache0
local key = {}
test_cache:set('key', 100, 10)
ngx.say(type(test_cache))
ngx.say(ngx.shared)

