local redis = require "resty.redis"
local json = require("cjson")
local redisPro = redis:new()

redisPro:timeout(1000) --1 sec

local ok, err = redisPro:connect('127.0.0.1', 6379)
if not ok then
    ngx.say('connect fail', err)
    return
end
ngx.say('connect success;')

-- 请注意这里 auth 的调用过程
-- 对于 Redis 授权，实际上只需要建立连接后，首次认证一下，后面只需直接使用即可。
-- 换句话说，从连接池中获取的连接都是经过授权认证的，只有新创建的连接才需要进行授权认证。
-- 所以大家就看到了 count, err = red:get_reused_times() 这段代码，并有了下面 if 0 == count then 的判断逻辑。
ok, err = redisPro:auth("123456")
if not ok then
    ngx.say("failed to auth: ", err)
    return
end
local productId = 2
local productInfo = {};
local testTime = ngx.time();
productInfo['productId'] = productId;
productInfo['productName'] = productId ..'我的测试商品' ..  testTime;
productInfo['productColor'] = productId ..'我的测试颜色' .. testTime;
productInfo['shopName'] = productId ..'我的测试店铺' ..  testTime;
productInfo['shopLevel'] = productId..'级';
productInfo['shopGoodCommentRate'] = productId..'好评';
ok, err = redisPro:hmset('productList',productId, json.encode(productInfo))

if not ok then
    ngx.say('出错信息1', err)
    return
end
local res, err = redisPro:hmget("productList", productId)
ngx.say(type(unpack(res)))
if not ok then
    ngx.say('出错信息2', err)
    return
end
ngx.say(unpack(res))