-- coroutine_test.lua 文件
co = coroutine.create(
    function(i)
        print(i);
    end
)

coroutine.resume(co, 1)   -- 1
ngx.say(coroutine.status(co))  -- dead

ngx.say("----------")

co = coroutine.wrap(
    function(i)
        print(i);
    end
)

co(1)

ngx.say("----------")

co2 = coroutine.create(
    function()
        for i=1,10 do
            print(i)
            if i == 3 then
                print(coroutine.status(co2))  --running
                print(coroutine.running()) --thread:XXXXXX
            end
            coroutine.yield()
        end
    end
)

coroutine.resume(co2) --1
coroutine.resume(co2) --2
coroutine.resume(co2) --3

ngx.say(coroutine.status(co2))   -- suspended
print(coroutine.running())

ngx.say("----------")