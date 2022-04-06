return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {'dracula/vim', as = 'dracula'}

    -- nvim-tree (新增)
    -- https://zhuanlan.zhihu.com/p/439574087
    -- https://zhuanlan.zhihu.com/p/438382701

    use { 'preservim/nerdtree' }


    use { 'Valloric/YouCompleteMe' }


    -- use {
    --     'kyazdani42/nvim-tree.lua',
    --     requires = {
    --         'kyazdani42/nvim-web-devicons', -- optional, for file icon
    --     },
    --     config = function() require'nvim-tree'.setup {
    --         update_cwd = true,
    --         update_focused_file = {
    --         enable = true,
    --         update_cwd = true,
    --         },
    --         filters = {
    --             dotfiles = false,
    --             custom = {'^\\.pyc'},
    --           },
    --     } end
    -- }
  end)