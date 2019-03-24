local json = require("cjson")


local data = { { 1, 23, 54 }, 2, 1000, 230, 3453 }
data[5] = {23,34,34534}
--data[5][2] = 234

-- ... do the other things
ngx.say(json.encode(data))