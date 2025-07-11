local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}


-- create test on php
local test = s("test", fmt([[
    public function test{}()
    {{
        {}
    }}
]], {
        i(1,"Name"),
        i(2,"// test code"),
    }))

table.insert(snippets, test)

local dot = s(".", fmt([[->]],{}))
table.insert(snippets, dot)

return snippets, autosnippets
