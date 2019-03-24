function sleep(n)
    os.execute("sleep " .. n)
end
sleep(0.01)
ngx.say("ok")