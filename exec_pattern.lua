local cjson = require 'cjson'

local post_args = ngx.req.get_post_args(4)
if not post_args then
    ngx.say(cjson.encode{error = 'only accepts post'})
    return
end

--for k, v in pairs(post_args) do
--    local post_arg = post_args[i]
--    ngx.say("<p>", k, " = ", v, "</p>\n")
--end

local init_val = post_args.init_val and tonumber(post_args.init_val) or nil
local pattern  = post_args.pattern
local test_text = post_args.test_text 

if not pattern or not test_text then
    ngx.say(cjson.encode{error = 'invalid arguments'})
end

local function tfind(s, pattern, init, plain)
    return { string.find(s, pattern, init, plain) }
end

local function tmatch(s, pattern, init)
    return { string.match(s, pattern, init) }
end

local success, captures, matches

success, captures = pcall( tfind, test_text, pattern, init_val )
if not success then
   ngx.say(cjson.encode{error = captures})
   return
end

success, matches= pcall( tmatch, test_text, pattern, init_val )
if not success then
   ngx.say(cjson.encode{error = matches})
   return
end


ngx.say( cjson.encode( {captures, matches} ) )

