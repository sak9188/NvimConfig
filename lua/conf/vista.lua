-- https://github.com/liuchengxu/vista.vim

vim.cmd(
    [[
" 缩进显示方式
let g:vista_icon_indent = ["▸ ", ""]
" 通过那种方式渲染大纲预览（ctags 或者 nvim_lsp）
let g:vista_default_executive = 'nvim_lsp'
" 启用图标支持"
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
]]
)

-- 打开大纲预览
vim.keybinds.gmap("n", "<leader>2", "<cmd>Vista!!<CR>", vim.keybinds.opts)