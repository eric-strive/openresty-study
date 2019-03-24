local redis = require "resty.redis"
local cjson = require "cjson"
local function close_redis(red)
    local ok, err = red:close()
    if not ok then
        ngx.log(ngx.ERR, "close redis error : ", err)
    end
    return nil
end


function getData(productId)
    --连接redis
    local red = redis:new()
    local ok, err = red:connect("127.0.0.1", 6379)
    if not ok then
        ngx.log(ngx.ERR, "connect to redis error : ", err)
        return close_redis(red)
    end
    -- auth
    local res, err = red:auth("123456")
    if not res then
        ngx.say("failed to authenticate: ", err)
        return
    end
    --调用API获取数据
    local res, err = red:hmget("productList", productId)
    if not ok then
        ngx.log(ngx.ERR, "get sku info error : ", err)
        return close_redis(red)
    end
    res = unpack(res) --将table转为字符串
    --得到的数据为空处理
    if res == ngx.null then
        return nil;
    end

    --释放redis连接
    close_redis(red)
    if res then
        res = cjson.decode(res)
    end

    return res
end


local _M = {
    getData = getData
}

return _M


