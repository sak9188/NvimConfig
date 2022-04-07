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
