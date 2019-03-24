local res = ngx.location.capture('/lua/uri_test',
    {
        method = ngx.HTTP_POST,
        args = ngx.encode_args({ a = 1, b = '2&' }),
        body = ngx.encode_args({ c = 3, d = '4&' })
    })
ngx.say(res.body)

ngx.log(ngx.ERR, "failed to create timer: ", '232323')