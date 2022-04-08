require("telescope").setup()
-- 查找文件
vim.keybinds.gmap("n", "<leader>ff", "<cmd>Telescope find_files layout_strategy=horizontal layout_config={height=0.9,width=0.9,preview_width=0.6} theme=dropdown<CR>", vim.keybinds.opts)
-- 查找文字
vim.keybinds.gmap("n", "<leader>fg", "<cmd>Telescope live_grep layout_strategy=horizontal layout_config={height=0.9,width=0.9,preview_width=0.6} theme=dropdown<CR>", vim.keybinds.opts)
-- 查找特殊符号
vim.keybinds.gmap("n", "<leader>fb", "<cmd>Telescope buffers layout_strategy=horizontal layout_config={height=0.9,width=0.9,preview_width=0.6} theme=dropdown<CR>", vim.keybinds.opts)
-- 查找帮助文档
vim.keybinds.gmap("n", "<leader>fh", "<cmd>Telescope help_tags theme=dropdown<CR>", vim.keybinds.opts)
-- 查找最近打开的文件
vim.keybinds.gmap("n", "<leader>fo", "<cmd>Telescope oldfiles theme=dropdown<CR>", vim.keybinds.opts)
-- 查找 marks 标记
vim.keybinds.gmap("n", "<leader>fm", "<cmd>Telescope marks theme=dropdown<CR>", vim.keybinds.opts)