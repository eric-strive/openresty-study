local sum = 0
for i=1,999999999 do
    sum = sum + i
end

ngx.say(sum)
ngx.say(os.clock())--返回一个程序使用CPU时间的一个近似值。

--sum = 0
--for i=1,999999999 do
--    sum = sum + i
--end
--
--ngx.say(sum)
--ngx.say(os.clock())