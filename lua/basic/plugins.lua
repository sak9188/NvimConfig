local packer = require("packer")
packer.startup(
    {
        -- 所有插件的安装都书写在 function 中
        function()
            -- 包管理器
            use {
                "wbthomason/packer.nvim"
            }
            -- 安装其它插件

            -- nvim-tree (新增)
            -- https://zhuanlan.zhihu.com/p/439574087
            -- https://zhuanlan.zhihu.com/p/438382701

            use { 'preservim/nerdtree' }

            -- 中文文档
            use {
                "yianwillis/vimcdoc",
            }
            
            -- 炫酷的状态栏插件
            use {
                "windwp/windline.nvim",
                config = function()
                    -- 插件加载完成后自动运行 lua/conf/windline.lua 文件中的代码
                    require("conf.windline")
                end
            }

            -- 支持 LSP 状态的 buffer 栏
            use {
                "akinsho/bufferline.nvim",
                requires = {
                    "famiu/bufdelete.nvim" -- 删除 buffer 时不影响现有布局
                },
                config = function()
                    require("conf.bufferline")
                end
            }

            -- 主题设置
            use {
                'dracula/vim', as = 'dracula'
            }

            -- 显示缩进线
            use {
                "lukas-reineke/indent-blankline.nvim",
                config = function()
                    require("conf.indent-blankline")
                end
            }

            -- 自动匹配括号
            use {
                "windwp/nvim-autopairs",
                config = function ()
                    require('nvim-autopairs').setup()
                end
            }

            -- 搜索时显示条目
            use {
                "kevinhwang91/nvim-hlslens",
                config = function()
                    -- 其实不用管下面这些键位绑定是什么意思，总之按下这些键位后会出现当前搜索结果的条目数量
                    vim.keybinds.gmap(
                        "n",
                        "n",
                        "<Cmd>execute('normal!'.v:count1.'n')<CR><Cmd>lua require('hlslens').start()<CR>",
                        vim.keybinds.opts
                    )
                    vim.keybinds.gmap(
                        "n",
                        "N",
                        "<Cmd>execute('normal!'.v:count1.'N')<CR><Cmd>lua require('hlslens').start()<CR>",
                        vim.keybinds.opts
                    )
                    vim.keybinds.gmap("n", "*", "*<Cmd>lua require('hlslens').start()<CR>", vim.keybinds.opts)
                    vim.keybinds.gmap("n", "#", "#<Cmd>lua require('hlslens').start()<CR>", vim.keybinds.opts)
                    vim.keybinds.gmap("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", vim.keybinds.opts)
                    vim.keybinds.gmap("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", vim.keybinds.opts)
                end
            }

            -- 快速跳转
            use {
                "phaazon/hop.nvim",
                config = function()
                    require("hop").setup()
                    -- 搜索并跳转到单词
                    vim.keybinds.gmap("n", "<leader>hw", "<cmd>HopWord<CR>", vim.keybinds.opts)
                    -- 搜索并跳转到行
                    vim.keybinds.gmap("n", "<leader>hl", "<cmd>HopLine<CR>", vim.keybinds.opts)
                    -- 搜索并跳转到字符
                    vim.keybinds.gmap("n", "<leader>hc", "<cmd>HopChar1<CR>", vim.keybinds.opts)
                end
            }

            -- 自动恢复光标位置
            use {
                "ethanholz/nvim-lastplace",
                config = function()
                    require("nvim-lastplace").setup(
                        {
                            -- 那些 buffer 类型不记录光标位置
                            lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
                            -- 那些文件类型不记录光标位置
                            lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
                            lastplace_open_folds = true
                        }
                    )
                end
            }

            -- 自动会话管理
            use {
                "rmagatti/auto-session",
                config = function()
                    -- 推荐设置
                    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
                    require("auto-session").setup
                    {
                        -- 自动加载最后保存的一次会话
                        auto_session_enable_last_session = true,
                        -- 保存会话时自动关闭 nvim-tree
                        -- 这是因为 nvim-tree 如果处于开启
                        -- 状态，会破坏会话的保存
                        pre_save_cmds = {"tabdo NERDTreeClose"}
                    }
                    
                    -- 在每次退出 neovim 时自动保存会话
                    -- 其实该插件不加这个自动命令也能
                    -- 自动保存会话，但总是感觉效果不理想
                    -- 所以这里我就自己加了个自动命令
                    vim.cmd([[
                        autocmd VimLeavePre * silent! :SaveSession
                    ]])
                end
            }

            -- 键位绑定器
            use {
                "folke/which-key.nvim",
                config = function()
                    require("which-key").setup(
                        {
                            plugins = {
                                spelling = {
                                    -- 是否接管默认 z= 的行为
                                    enabled = true,
                                    suggestions = 20
                                }
                            }
                        }
                    )
                end
            }

            -- 模糊查找
            use {
                "nvim-telescope/telescope.nvim",
                requires = {
                    "nvim-lua/plenary.nvim", -- Lua 开发模块
                    "BurntSushi/ripgrep", -- 文字查找
                    "sharkdp/fd" -- 文件查找
                },
                config = function()
                    require("telescope").setup()
                    -- 查找文件
                    vim.keybinds.gmap("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown<CR>", vim.keybinds.opts)
                    -- 查找文字
                    vim.keybinds.gmap("n", "<leader>fg", "<cmd>Telescope live_grep theme=dropdown<CR>", vim.keybinds.opts)
                    -- 查找特殊符号
                    vim.keybinds.gmap("n", "<leader>fb", "<cmd>Telescope buffers theme=dropdown<CR>", vim.keybinds.opts)
                    -- 查找帮助文档
                    vim.keybinds.gmap("n", "<leader>fh", "<cmd>Telescope help_tags theme=dropdown<CR>", vim.keybinds.opts)
                    -- 查找最近打开的文件
                    vim.keybinds.gmap("n", "<leader>fo", "<cmd>Telescope oldfiles theme=dropdown<CR>", vim.keybinds.opts)
                    -- 查找 marks 标记
                    vim.keybinds.gmap("n", "<leader>fm", "<cmd>Telescope marks theme=dropdown<CR>", vim.keybinds.opts)
                end
            }
        end,
        -- 使用浮动窗口
        config = {
            display = {
                open_fn = require("packer.util").float
            }
        }
    }
)

-- 实时生效配置
vim.cmd(
    [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
    colorscheme dracula
    hi Normal guibg=NONE ctermbg=NONE
]]
)
