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

  use 'mhinz/vim-signify'
  use 'tommcdo/vim-lion'
  use 'scrooloose/nerdcommenter'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'vim-scripts/VisIncr'
  use 'posva/vim-vue'
  use 'christoomey/vim-tmux-navigator'
  use 'mustache/vim-mustache-handlebars'
  use 'Yggdroot/indentLine'
  use 'hashivim/vim-vagrant'
  use 'cespare/vim-toml'
  use 'Glench/Vim-Jinja2-Syntax'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }

  -- colorschemes
  use 'romainl/apprentice'
  use 'w0ng/vim-hybrid'
  use 'freeo/vim-kalisi'
  use 'jnurmine/Zenburn'
  use 'morhetz/gruvbox'
  use 'sickill/vim-monokai'
  use 'tomasr/molokai'
  use 'junegunn/seoul256.vim'
  use 'joakimen/lena.vim'

end)

