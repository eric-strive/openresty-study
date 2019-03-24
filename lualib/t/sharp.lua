local _M = { _VERSION = '0.01', w = 0, l = 0 }
local setmetatable = setmetatable
mt = { __index = _M }

function _M:new(w,l,o)
    o = o or {}
    self.w = w
    self.l = l
    setmetatable(o,mt)
    return o
end

function _M:per()
    return self.w * self.l
end

return _M
