" =============================================================================
" init.vim
" Author: Joakim Engeset <joakim.engeset@gmail.com>
" =============================================================================
inoremap jk <Esc>
let mapleader = ' '
set shell=/usr/local/bin/zsh

" plugins ----------------------------------------------------------------- {{{
call plug#begin('~/.vim/plugged')

Plug 'justinmk/vim-sneak'
Plug 'ajh17/VimCompletesMe'
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'tommcdo/vim-lion'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/VisIncr'
Plug 'fatih/vim-go'
Plug 'udalov/kotlin-vim'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'

" Color schemes
Plug 'romainl/apprentice'
Plug 'w0ng/vim-hybrid'
Plug 'freeo/vim-kalisi'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'

call plug#end()

" }}}
" options ----------------------------------------------------------------- {{{
set number
set lazyredraw
set hidden
set wildmode=longest:list,full
set shortmess=aIT
set nojoinspaces
set clipboard+=unnamedplus
set nrformats=
set splitright
set splitbelow
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set shiftround
set ignorecase
set smartcase
set gdefault
set nobackup
set noswapfile
set textwidth=80
set wrap
set virtualedit=block
set listchars=tab:▸\ ,
set list
set completeopt=menuone,preview
set formatoptions+=qrn1j
set previewheight=25
set undofile
set undodir=/tmp//,.
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
set foldlevelstart=0
set cmdheight=2
set modelines=2
set inccommand=split

" }}}
" colors ------------------------------------------------------------------ {{{

colorscheme lena

"hi normal ctermbg=none
"hi nontext ctermbg=none
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" }}}
" abbreviations ----------------------------------------------------------- {{{

iabbrev @@ joakim.engeset@gmail.com
iabbrev aauth Author: Joakim Engeset <joakim.engeset@gmail.com>
iabbrev todo TODO

" insert date (example: 'Mon 04 Jun 2018')
iabbrev idate <C-R>=<sid>getdate()<CR>

" display help in vertical split
cabbrev h vert h

" }}}
" keybindings ------------------------------------------------------------- {{{

" json: format buffer with jq
nnoremap <leader>j :setf json\|%!jq<cr>

" markdown bindings, stolen from junegunn choi
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

" move as expected across wrapped lines
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" toggle fold
nnoremap , za

" toggle all folds using &foldlevel
nnoremap <silent><BS> :exec 'setlocal foldlevel='. (&foldlevel > 0 ? 0: 10)<CR>

" google word under cursor
nnoremap <leader>? :call <SID>google(expand("<cWORD>"))<cr>

" Remove tabs and trailing whitespace
nnoremap <silent> <Leader>w :call CleanupWhitespace()<CR>

" diff-keybinds
nnoremap dp :diffput<CR>
nnoremap dg :diffget<CR>

" Make S-y work like S-d
nnoremap <S-y> y$

" insert-mode paste
inoremap <C-v> <C-r>+

" disable Ex mode shortcut
nnoremap <S-q> <Nop>

" redraw screen when fucked
nnoremap <silent> U :syntax sync fromstart<cr>:redraw!<CR>

" Clear last search result
nnoremap <silent> <leader>l :nohlsearch<CR>

" When navigating between search results, center screen
nnoremap n nzz
nnoremap N Nzz

" Close buffer
nnoremap <silent> <leader>d :bd<CR>

" ci patching
cnoreabbrev ci( %ci(
cnoreabbrev ci) %ci)
cnoreabbrev ci[ %ci[
cnoreabbrev ci] %ci]
cnoreabbrev ci{ %ci{
cnoreabbrev ci} %ci}

" terminal: navigation
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" terminal: escape
tnoremap jk <C-\><C-n>
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>

" terminal: open in buffer/hsplit/vsplit
nnoremap <silent> <leader>t :te<CR>
nnoremap <silent> <leader>s :sp term://zsh<CR>
nnoremap <silent> <leader>v :vsp term://zsh<CR>

" }}}
" plugin settings --------------------------------------------------------- {{{

" tagbar
let g:tagbar_sort=0
let g:tagbar_autofocus=0

" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
" vim-sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
let g:sneak#absolute_dir = 1

" }}}
" plugin keybindings ------------------------------------------------------ {{{

" vim-signify
let g:signify_vcs_list = ['git']

" fzf.vim
nnoremap <silent> <C-f> :FZF<CR>
nnoremap <silent> <C-g> :Rg<CR>
nnoremap <silent> <C-e> :History<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>C :Colors<CR>

" fugitive.vim
nnoremap gs :Gstatus<CR>

" NERDComment
nnoremap <silent> cm :call NERDComment(0, "toggle")<CR>
vnoremap <silent> cm :call NERDComment(0, "toggle")<CR>


" vim-plug
cnoreabbrev pi PlugInstall
cnoreabbrev pc PlugClean
cnoreabbrev pu PlugUpdate
cnoreabbrev pug PlugUpgrade

" Tagbar
nnoremap <silent> <F11> :TagbarToggle<CR>
inoremap <silent> <F11> <C-o>:TagbarToggle<CR>

" incsearch-vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" ssms grid-content to ascii
nnoremap <silent> <Leader>f :call CreateAsciiTable()<CR>

" }}}
" functions --------------------------------------------------------------- {{{

function! s:getdate()
  return strftime("%a %d %b %Y")
endfunction

function! CleanupWhitespace()

  " remove trailing whitespace
  %s/\v\s+$//e

  " format tabs according to settings
  retab

endfunction

function! s:google(pat)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
        \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?q=%s"', q))
endfunction

" format ssms grid-content as ascii-table
function! CreateAsciiTable()

  " delete empty lines
  silent g/^$/de

  " remove carriage returns
  silent %s/\r/\r/e

  " replace tabs with pipes
  silent %s/\t/|/e

  " wrap line in pipes
  silent %s/.*/|\0|/e

  " align cells to pipes using 'lion'-plugin
  silent normal glip|

  " add a dash-separator below column headers
  silent normal yypVr-

  " yank entire buffer
  silent %y
endfunction


" mark all lines in the buffer (except lines 1-2) as incomplete items
" if they don't match any note-taking symbols.
function! TODOMarkIncompleteItems()

  " mark initial position
  normal mp

  " apply function to all lines except lines 1-2k
  3,$ call <SID>todo_mark_incomplete_item()

  " return to initial position
  normal `p

  " remote position marker when done
  delmarks mp
endfunction


" mark line as an incomplete item, '_ ', if it doesn't match any of the
" note-taking symbols already. our note-taking symbols are as follows:
"
"   # header
"   x completed item
"   _ incomplete item
function! s:todo_mark_incomplete_item()

  let line = getline('.')

  " if line is empty, skip it
  if line =~ '^\s*$' | return | endif

  " extract the first character of the line
  let char = strpart(line, 0, 1)

  " define recognized note-taking symbols
  let notechars = ['#', '_', 'x']

  " remove leading whitespace
  let line = substitute(line, '^\s\+', '', 'g')

  " inspect the first character of the line. if the character is not a
  " recognized symbol, mark the line as an incomplete item.
  if index(notechars, char) == -1
    call setline('.', '_ '.line)
  endif

endfunction

" }}}
" autocommands ------------------------------------------------------------ {{{

" general {{{


augroup general
  au!
  " assume last known position of file
  au BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

  " make autoread behave like expected
  au FocusGained * :checktime

augroup end

" highlight unwanted whitespace
augroup format_whitespace
  au!
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
augroup end

" wrap text in quickfix
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END

" auto-source .vimrc
augroup vimrc
  au!
  au BufWritePost $MYVIMRC source $MYVIMRC
augroup end

" start terminal-mode in insert-mode
augroup term_startinsert
  au!
	autocmd TermOpen,BufWinEnter,BufEnter term://* startinsert
augroup end

" }}}
" filetype {{{

augroup ft_go
  au!
  au FileType go nnoremap <silent> <C-t> :GoAlternate<CR>
  au FileType go nnoremap <silent> <Leader>h :GoDoc<CR>
  au FileType go nnoremap <silent> <Leader>t :GoTest<CR>
  au FileType go nnoremap <silent> <Leader>r :GoRun<CR>
  au FileType go nnoremap <silent> <Leader>0 :TagbarToggle<CR>
  au FileType go inoreabbrev iferr if err != nil {<CR>log.Fatal(err)<CR>}
  au FileType go let g:tagbar_width=60
augroup end

" support for some note-taking stuff..
augroup ft_notes
  au!

  " mark untagged lines as incomplete on write
  au BufWritePost TODO.md call TODOMarkIncompleteItems()

  " open all folds when opening file
  au BufRead TODO.md setlocal foldlevel=10

  " insert new header with current date
  au FileType markdown nnoremap _ o<CR># <C-r>=<sid>getdate()<CR><Esc>0

  " mark line as done with timestamp
  au FileType markdown nnoremap - mp0rx:r !date "+[\%H:\%M]"<CR>kJ`p

augroup end

augroup ft_ruby
  au!
  au FileType ruby nnoremap <leader>r :w<CR>:!ruby %<CR>
  au FileType ruby setlocal omnifunc=rubycomplete#Complete
  au FileType ruby compiler ruby
  au FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  au FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  au FileType ruby,eruby let g:rubycomplete_rails = 1
augroup end

augroup ft_python
  au!
  au FileType python nnoremap <F5> :sp term:///usr/bin/env python3 %<CR>
  au FileType python nnoremap <leader>r :w<CR>:py3file %<CR>
  au FileType python set equalprg=autopep8\ -
augroup end

augroup ft_autohotkey
  au!
  au FileType autohotkey setlocal sw=4 sts=4 ts=4
augroup end

augroup ft_sql
  au!
  au FileType sql setlocal sw=4 sts=4 ts=4
augroup end

augroup ft_kotlin
  au!
  au FileType kotlin set makeprg=kotlinc\ -script\ %
augroup end

augroup ft_sh
  au!
  au FileType sh nnoremap <F5> :sp term:///usr/bin/env bash %<CR>
  au FileType sh nnoremap <Leader>r :sp term:///usr/bin/env bash %<CR>
augroup end

augroup ft_zsh
  au!
  au FileType zsh nnoremap <F5> :sp term:///usr/bin/env zsh %<CR>
  au FileType zsh nnoremap <Leader>r :sp term:///usr/bin/env zsh %<CR>
augroup end

augroup ft_json
  au!
  au FileType json set nowrap
  au FileType json nnoremap <Leader>f :%!python3 -m json.tool<CR>
augroup end

augroup ft_applescript
  au!
  au FileType applescript nnoremap <F5> :sp term:///usr/bin/env osascript %<CR>
  au FileType applescript nnoremap <Leader>r :sp term:///usr/bin/env osascript %<CR>
augroup end
