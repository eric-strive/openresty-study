cjson = require("cjson")
local res1, res2, res3 = ngx.location.capture_multi({
    { "/lua/capture/sleep1", { args = { a = 3, b = 8 } } },
    { "/lua/capture/sleep2", { args = { a = 4, b = 7 } } },
    { "/lua/capture/sleep3", { args = { a = 9, b = 5 } } }
})

local datas = {}
datas['arg1'] = res1.body;
datas['arg2'] = res2.body;
datas['arg3'] = res3.body;
ngx.say(cjson.encode(datas))