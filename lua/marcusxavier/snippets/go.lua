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


local f = s("f", fmt([[
func {}({}) {} {{
    {}
}}
]], {
    i(1, "name"),
    i(2, ""),
    i(3, ""),
    i(4, "// code here")
    }))

table.insert(snippets, f)

local test = s("test", fmt([[
func Test{}(t *testing.T) {{
    {}
}}
]], {
        i(1, "Name"),
        i(2, "// test code")
    }))

table.insert(snippets, test)

local trun = s("trun", fmt([[
    t.Run("{}", func(t *testing.T) {{
        {}
    }})
]], {
        i(1, "description"),
        i(2, "// Actual code")
    }))

table.insert(snippets, trun)

local gw = s("gw", fmt([[
got := {}
want := {}
]], {
        i(1, "func"),
        i(2, "result")
    }))

table.insert(snippets, gw)

-- assert tests with `if` expression
local ifa = s("ifa", fmt([[
    if got != want {{
        t.Errorf("expected %{} but got %{}", want, got)
    }}
]], {
        i(1,""),
        i(2, ""),
    }))
table.insert(snippets, ifa)

local m = s("m", fmt([[
func ({}) {}({}) {} {{
    {}
}}
]], {
        i(1, "struct"),
        i(2, "name"),
        i(3, ""),
        i(4, ""),
        i(5, "//code here")
    }))

table.insert(snippets, m)

-- assert tests with `if` expression
local ife = s("ife", fmt([[
    if err != nil {{
        {}
    }}
]], {
        i(1,"//do something"),
    }))
table.insert(snippets, ife)

local tp = s("tp", fmt([[
type {} {} {{
    {}
}}
]], {
        i(1, "name"),
        c(2, {t("struct"), t("interface")}),
        i(3, "// types")
    }))

table.insert(snippets, tp)
return snippets, autosnippets
