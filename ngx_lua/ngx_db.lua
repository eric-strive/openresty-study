local mysql = require "resty.mysql"
local db, err = mysql:new()
if not db then
    ngx.say("failed to instantiate mysql: ", err)
    return
end

db:set_timeout(1000) -- 1 sec

local ok, err, errno, sqlstate = db:connect {
    host = "127.0.0.1",
    port = 3306,
    database = "capital",
    user = "root",
    password = "123456",
    max_packet_size = 1024 * 1024
}

if not ok then
    ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
    return
end
local arg = ngx.req.get_uri_args()
ngx.say("connected to mysql success<br>")

--local res, err, errno, sqlstate =
--db:query("drop table if exists cats")
--if not res then
--    ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
--    return
--end

--res, err, errno, sqlstate =
--db:query("create table cats "
--        .. "(id serial primary key, "
--        .. "name varchar(5))")
--if not res then
--    ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
--    return
--end
--
--ngx.say("table cats created.")
--
--res, err, errno, sqlstate =
--db:query("insert into cats (name) "
--        .. "values (\'Bob\'),(\'\'),(null)")
--if not res then
--    ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
--    return
--end
--
--ngx.say(res.affected_rows, " rows inserted into table cats ",
--    "(last insert id: ", res.insert_id, ")")

-- 这里有 SQL 注入（后面的 drop 操作）
local req_id = arg.req_id
--ngx.say(req_id);
--原本在 sql 语句中添加的单引号去掉了，因为 ngx.quote_sql_str 的返回值正确的带上引号了。
--req_id = ndk.set_var.set_quote_sql_str(req_id)
--ngx.say(req_id);
res, err, errno, sqlstate =
db:query([[select * from cats where id = ]] .. req_id)
if not res then
    ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
    return
end

local cjson = require "cjson"
ngx.say("result: ", cjson.encode(res))

-- 再次查询，table 被删
--res, err, errno, sqlstate =
--db:query([[select * from cats where id = 1]])
--if not res then
--    ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
--    return
--end
--
--db:set_keepalive(10000, 100)