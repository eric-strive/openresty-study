package.path = '/Users/wangwei/Study/openresty/ngx_lua/var_share/?.lua;'
local uri_args = ngx.req.get_uri_args()
local mo = require('mo')
mo.args = uri_args