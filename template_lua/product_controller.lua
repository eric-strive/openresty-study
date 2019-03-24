--加载Lua模块库
local template1 = require("resty1.template")
local productData = require("jd.product_data")

--1、获取请求参数中的商品ID
local arg = ngx.req.get_uri_args()
local productId = arg.skuId;
--2、调用相应的服务获取数据
local data = productData.getData(productId)
if data == nil then
    ngx.say('该商品不存在')
else
    --3、渲染模板
    local func = template1.compile("product.html")
    local content = func(data)
    --4、通过ngx API输出内容
    ngx.say(content)
end