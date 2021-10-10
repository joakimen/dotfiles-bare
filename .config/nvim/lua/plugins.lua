vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    autocmd BufWritePost plugins.lua source <afile> | PackerClean
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
  augroup end
]])

return require('packer').startup(function()

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  --- general purpose
  use 'machakann/vim-sandwich'
  use { 'andymass/vim-matchup', event = 'User ActuallyEditing' }
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'lukas-reineke/indent-blankline.nvim', ft = {'yaml', 'json', 'toml'} }
  use 'hrsh7th/nvim-cmp'

  use 'tommcdo/vim-lion'
  use 'scrooloose/nerdcommenter'

  --- lang specific. trash when lsp confed?
  use 'vim-scripts/VisIncr'
  use 'mustache/vim-mustache-handlebars'
  use 'hashivim/vim-vagrant'
  use 'cespare/vim-toml'
  use 'Glench/Vim-Jinja2-Syntax'

  -- git stuff
  use { 'TimUntersberger/neogit', config = [[require('neogit').setup()]], requires = 'nvim-lua/plenary.nvim' }
  use { 'lewis6991/gitsigns.nvim', config = [[require('gitsigns').setup()]] }

  -- lang & linting
  use { 'nvim-treesitter/nvim-treesitter', config = [[require ('config.treesitter')]], run = ':TSUpdate' }

  use { 'neovim/nvim-lspconfig', config = [[require('config.lsp')]] }
  use {
    'nvim-treesitter/playground',
    'folke/trouble.nvim',
    'kosayoda/nvim-lightbulb',
  }

  -- colorschemes
  use {
    'romainl/apprentice',
    'w0ng/vim-hybrid',
    'freeo/vim-kalisi',
    'jnurmine/Zenburn',
    'morhetz/gruvbox',
    'sickill/vim-monokai',
    'tomasr/molokai',
    'junegunn/seoul256.vim',
    'joakimen/lena.vim',
  }

  use 'christoomey/vim-tmux-navigator'
end)

