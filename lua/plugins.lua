return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {'dracula/vim', as = 'dracula'}

    -- nvim-tree (新增)
    -- https://zhuanlan.zhihu.com/p/439574087
    -- https://zhuanlan.zhihu.com/p/438382701

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end
    }
  end)