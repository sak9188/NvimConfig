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

            -- 精美弹窗
            use {
                "rcarriga/nvim-notify",
                config = function()
                    require("conf.nvim-notify")
                end
            }

            -- LSP 基础服务
            use {
                "neovim/nvim-lspconfig",
                config = function()
                    require("conf.nvim-lspconfig")
                end
            }
                                                    
            -- 自动安装 LSP
            use {
                "williamboman/nvim-lsp-installer",
                config = function()
                    require("conf.nvim-lsp-installer")
                end
            }                                          

            -- -- LSP UI 美化
            use {
                "tami5/lspsaga.nvim",
                config = function()
                    require("conf.lspsaga")
                end
            }

            -- LSP 进度提示
            use {
                "j-hui/fidget.nvim",
                config = function()
                    require("fidget").setup({
                        window = {
                            -- 窗口全透明，不建议修改这个选项
                            -- 否则主题透明时将会出现一大片黑块
                            blend = 0,
                        }
                    })
                end
            }

            -- 插入模式获得函数签名
            use {
                "ray-x/lsp_signature.nvim",
                config = function()
                    require("lsp_signature").setup(
                        {
                            bind = true,
                            -- 边框样式
                            handler_opts = {
                                -- double、rounded、single、shadow、none
                                border = "rounded"
                            },
                            -- 自动触发
                            floating_window = false,
                            -- 绑定按键
                            toggle_key = "<C-j>",
                            -- 虚拟提示关闭
                            hint_enable = false,
                            -- 正在输入的参数将如何突出显示
                            hi_parameter = "LspSignatureActiveParameter"
                        }
                    )
                end
            }

            -- 自动代码补全系列插件
            use {
                "hrsh7th/nvim-cmp",  -- 代码补全核心插件，下面都是增强补全的体验插件
                requires = {
                    {"onsails/lspkind-nvim"}, -- 为补全添加类似 vscode 的图标
                    {"hrsh7th/vim-vsnip"}, -- vsnip 引擎，用于获得代码片段支持
                    {"hrsh7th/cmp-vsnip"}, -- 适用于 vsnip 的代码片段源
                    {"hrsh7th/cmp-nvim-lsp"}, -- 替换内置 omnifunc，获得更多补全
                    {"hrsh7th/cmp-path"}, -- 路径补全
                    {"hrsh7th/cmp-buffer"}, -- 缓冲区补全
                    {"hrsh7th/cmp-cmdline"}, -- 命令补全
                    {"f3fora/cmp-spell"}, -- 拼写建议
                    {"rafamadriz/friendly-snippets"}, -- 提供多种语言的代码片段
                    {"lukas-reineke/cmp-under-comparator"}, -- 让补全结果的排序更加智能
                    {"tzachar/cmp-tabnine", run = "install.ps1"} -- tabnine 源,提供基于 AI 的智能补全
                },
                config = function()
                    require("conf.nvim-cmp")
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
    " hi Normal guibg=NONE ctermbg=NONE
]]
)
