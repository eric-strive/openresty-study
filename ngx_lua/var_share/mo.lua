local showJs = function(callback, data)
    local cjson = require('cjson')
    ngx.say(callback .. '(' .. cjson.encode(data) .. ')')
end
local self_jsonp = self.args.jsonp
local keyList = string.split(self.args.key_list, ',')
for i=1, keyList do
    -- do something
    ngx.say(self.args.kind)
end
showJs(self_jsonp, valList)