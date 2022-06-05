-- 将query中的content参数作为页面显示内容
local args = ngx.req.get_uri_args()
ngx.say(args.content)