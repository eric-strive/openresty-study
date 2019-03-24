local _M = {}

_M.value = 100
function _M.fun()
    ngx.say(_M.value)
end


return _M