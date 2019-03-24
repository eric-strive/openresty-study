local _M = {}
_M.pi = 3.14

local mt = {__index = _M }

function _M.new(self,pi)
    self.pi = pi
    return setmetatable({},mt)
end

function _M.fun_perimeter(self, long)
    ngx.say(long * self.pi)
end


return _M