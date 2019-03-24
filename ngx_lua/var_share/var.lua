local _M = {}

function _M.calc(sum)
    amount = 3
    amount = sum + amount
    -- 模拟协程调度
    ngx.sleep(5)
    return amount
end

return _M