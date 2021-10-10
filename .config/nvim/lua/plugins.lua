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
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
  use 'tommcdo/vim-lion'
  use 'scrooloose/nerdcommenter'
  use 'Yggdroot/indentLine'
  use 'christoomey/vim-tmux-navigator'

  --- lang specific. trash when lsp confed?
  use 'vim-scripts/VisIncr'
  use 'mustache/vim-mustache-handlebars'
  use 'hashivim/vim-vagrant'
  use 'cespare/vim-toml'
  use 'Glench/Vim-Jinja2-Syntax'

  -- git stuf
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use 'lewis6991/gitsigns.nvim'

  -- lang & linting
  use {
    'neovim/nvim-lspconfig',
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

end)

