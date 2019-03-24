--local table = require 'test_module'
--table.fun()


local circle = require 'circle'
local c_new = circle:new(3.5)
c_new:fun_perimeter(10)


local t = { a = 1, b = 2, c = 3 }
ngx.say(t.a)
function t.func()
    ngx.say('222')
end

t.func()

local _M = { _VERSION = '0.01' }
mt = { __index = _M }
function _M:new(self,o)
    o = o or {}
    setmetatable(o,mt)
end