local args = ngx.req.get_uri_args()
local etag = ngx.md5(args.content)
local last_modified = "Wed, 01 Jun 2022 10:39:14 GMT"
ngx.header.Last_Modified = last_modified
local headers, err = ngx.req.get_headers(0)
-- ETag 没有变化，直接返回304状态码, 且etag的优先级比last_modified高
ngx.header.ETag = etag
if etag == headers["if-none-match"] then
    ngx.exit(ngx.HTTP_NOT_MODIFIED)
end

if last_modified == headers["if-modified-since"] then
    ngx.exit(ngx.HTTP_NOT_MODIFIED)
end

-- type=error0为返回的header Date时间 < 当前时间 - max-age，客户端不缓存
if args.type == "error0" then
    ngx.header.Date = "Fri, 03 Jun 2021 00:00:00 GMT"
    ngx.header.Cache_Control = "max-age=60"
    return
-- type=error1为返回了Age字段，且Age > max-age, 客户端不缓存
elseif args.type == "error1" then
    ngx.header.Age = "1000"
    ngx.header.Cache_Control = "max-age=60"
    return
-- type=normal为正常案例，则将请求参数中的cc的值作为响应头的Cache-Control
elseif args.type == "normal" then
    ngx.header.Cache_Control = args["cc"]
    return
end