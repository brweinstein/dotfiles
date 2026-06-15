local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
    "           _.- ~~^^^'~- _ __ .,.- ~ ~ ~  ~  -. _",
    " ________,'       ::.                       _,-  ~ -.",
    "((      ~_\\   -s-  ::                     ,'          ;,",
    " \\\\       <.._ .;;;`                     ;           }  `',",
    "  ``=======\'    _ _- _ (   }             `,          ,\'\\,  `,",
    "               ((/ _ _,i   ! _ ~ - -- - _ _'_-_,_,,,\'    \\,  ;",
    "                  ((((____/            (,(,(, ____>        \\,"
}

dashboard.section.header.opts.position = "center"
dashboard.section.header.opts.hl = "AlphaHeader"

dashboard.section.buttons.val = {
  dashboard.button("e", " New file", ":ene <CR>"),
  dashboard.button("n", " NvimTree", ":NvimTreeToggle<CR>"),
  dashboard.button("q", " Quit", ":qa<CR>"),
}
dashboard.section.buttons.opts.position = "center"
dashboard.section.buttons.opts.hl = "AlphaButtons"

dashboard.section.footer.val = {
  " Happy coding, Ben!"
}
dashboard.section.footer.opts.position = "center"
dashboard.section.footer.opts.hl = "AlphaFooter"

dashboard.config.layout = {
  { type = "padding", val = 1 },
  dashboard.section.header,
  { type = "padding", val = 1 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
  dashboard.section.footer,
}

vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#8ec07c", bold = true })
vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#83a598" })
vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#928374", italic = true })

alpha.setup(dashboard.config)
