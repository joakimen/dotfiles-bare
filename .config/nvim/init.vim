" =============================================================================
" init.vim
" Author: Joakim Engeset <joakim.engeset@gmail.com>
" =============================================================================
inoremap jk <Esc>
let mapleader = ' '
set shell=/bin/bash\ --login

" plugins ----------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

Plug 'ajh17/VimCompletesMe'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'haya14busa/incsearch.vim'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'junegunn/vim-easy-align',   { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/VisIncr'
Plug 'w0rp/ale'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'dag/vim-fish'
Plug 'vim-scripts/c.vim'

" Color schemes
Plug 'freeo/vim-kalisi'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'

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
set tabstop=4
set shiftwidth=4
set expandtab
set shiftround
set ignorecase
set smartcase
set gdefault
set nobackup
set noswapfile
set textwidth=80
set wrap
set colorcolumn=80
set virtualedit=block
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set list
set completeopt=menuone,preview
set formatoptions+=qrn1j
set previewheight=25
set undofile
set undodir=/tmp//,.
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
set foldmethod=marker
set foldlevelstart=0
set cmdheight=2
set modelines=0
set autoread

" }}}
" colors ------------------------------------------------------------------ {{{

set background=dark
let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" }}}
" environment ------------------------------------------------------------- {{{

" change cursor-shape in tmux and iterm
if exists("$TMUX")
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" }}}
" abbreviations ----------------------------------------------------------- {{{

iabbrev @@ joakim.engeset@gmail.com
iabbrev aauth Author: Joakim Engeset <joakim.engeset@gmail.com>
iabbrev todo TODO
cabbrev h vert h

" }}}
" keybindings ------------------------------------------------------------- {{{

" toggle fold
nnoremap , za

" toggle all folds using &foldlevel
nnoremap <silent>K :exec 'setlocal foldlevel='. (&foldlevel > 0 ? 0: 2)<CR>

" google word under cursor
nnoremap <leader>? :call <SID>google(expand("<cWORD>"))<cr>

" diff-keybinds
nnoremap dp :diffput<CR>
nnoremap dg :diffget<CR>

" Make S-y work like S-d
nnoremap <S-y> y$

" find help for current word
nnoremap <Leader>h yiw:h <C-r>+<CR>

" insert-mode paste
inoremap <C-v> <C-r>+

" disable Ex mode shortcut
nnoremap <S-q> <Nop>

" redraw screen when fucked
nnoremap <silent> U :syntax sync fromstart<cr>:redraw!<CR>

" Add new, empty line above/below
nnoremap <silent><S-CR> :put!=repeat(nr2char(10), 0)<CR>j
nnoremap <silent><CR> :put =repeat(nr2char(10), 0)<CR>k

" Edit and source $MYVIMRC
nnoremap <Leader>v :vs $MYVIMRC<CR>
nnoremap <Leader>s :so $MYVIMRC<CR>

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

" navigate out of terminal-mode
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
tnoremap jk <C-\><C-n>

" }}}
" plugin settings --------------------------------------------------------- {{{

" tagbar
let g:tagbar_sort=0
let g:tagbar_autofocus=0

" ale
let g:ale_fixers = {
            \   'python': ['flake8'],
            \}


" EasyAlign
let g:easy_align_delimiters = {
            \ '-': {
            \     'pattern':       '-',
            \     'left_margin':   1,
            \     'right_margin':  1,
            \     'stick_to_left': 0
            \   }
            \ }

" vim-notes
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.md'
let g:notes_tab_indents = 0

" }}}
" plugin keybindings ------------------------------------------------------ {{{

" vim-signify
let g:signify_vcs_list = ['git']

" ale
nnoremap <silent><Leader>, :ALEPrevious<CR>
nnoremap <silent><Leader>. :ALENext<CR>

" fzf.vim
nnoremap <silent> <C-f> :FZF<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-c> :Colors<CR>

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
nnoremap <silent> <F12> :TagbarToggle<CR>
inoremap <silent> <F12> <C-o>:TagbarToggle<CR>

" incsearch-vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" vim-notes
nnoremap <Leader>n :Note 
nnoremap <Leader>t :Note TODO<CR>

" EasyAlign
xmap <CR> <Plug>(EasyAlign)

" }}}
" functions --------------------------------------------------------------- {{{

function! s:run()

    " Executes the current script. Shebang will be used if it exists, otherwise
    " binary will be guessed based on filetype

    " Absolute path to current file
    let file = expand('%:p')
    let head = getline(1)
    let pos  = stridx(head, '#!')
    let bin  = ''

    " Determine if we have a shebang
    if pos != -1
        " Aaaaaand we have a shebang. Build execution string based on shebang
        let bin = strpart(head, pos + 2)
    else

        " Set executable based on filetype
        if &filetype == 'ruby'
            let bin = '/usr/bin/env ruby'
        elseif &filetype == 'python'
            let bin = '/usr/bin/env python'
        elseif &filetype == 'sh'
            let bin = '/usr/bin/env bash'
        endif

    endif

    " If no executable could be determined, return
    if empty(bin)
        echom 'run(): Execution of filetype "'.&filetype.'" is not supported'
        return
    endif

    let command = bin.' '.file
    call VimuxRunCommand(command)
endf

function! s:google(pat)
    let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
    let q = substitute(q, '[[:punct:] ]',
                \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
    call system(printf('open "https://www.google.com/search?q=%s"', q))
endfunction

function! TODOMarkIncompleteItems()
    normal mp
    3,$ call <SID>todo_mark_incomplete_item()
    normal `p
    delmarks mp
endfunction

function! s:todo_mark_incomplete_item()

    let line = getline('.')
    let char = strpart(line, 0, 1)
    let notechars = ['#', '_', 'x']

    " if line is empty, don't bother formatting
    if line =~ '^\s*$' | return | endif

    " remove leading whitespace
    let line = substitute(line, '^\s\+', '', 'g')

    " mark line as an uncompleted item
    if index(notechars, char) == -1
        call setline('.', '_ '.line)
    endif

endfunction


nnoremap <silent><Leader>m :call CleanupWindowsCrap()<CR>
" }}}
" autocommands ------------------------------------------------------------ {{{

" general {{{

" assume last known position of file
augroup resume_file_position
    au!
    au BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe "normal! g`\""
                \ | endif
augroup end

" highlight unwanted whitespace
augroup format_whitespace
    au!
    au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
    au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
augroup end

" auto-source .vimrc
augroup vimrc
    au!
    au BufWritePost $MYVIMRC source $MYVIMRC
augroup end

" start terminal-mode in insert-mode
augroup term_startinsert
    au!
    au BufWinEnter,WinEnter term://* startinsert
augroup end

" }}}
" filetype {{{

augroup ft_notes
    au!

    " mark untagged lines as incomplete
    au BufWritePost TODO.md call TODOMarkIncompleteItems()

    " open all folds in TODO
    au BufRead TODO.md setlocal foldlevel=99

    " insert new header with current date
    au FileType notes nnoremap _ :.!date "+\%d \%b \%Y"<CR>I# <Esc>o

    " mark item as done with timestamp
    au FileType notes nnoremap - mp0rx:r !date "+[\%H:\%M]"<CR>kJ`p

augroup end

augroup ft_c
    au!
    au FileType c setlocal sw=2 sts=2
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
    au FileType python nnoremap <F5> :w !python3<CR>
    au FileType python nnoremap <leader>r :w<CR>:py3file %<CR>
    au FileType python set equalprg=autopep8\ -
augroup end

augroup ft_autohotkey
    au!
    au FileType autohotkey setlocal sw=4 sts=4
augroup end

augroup ft_kotlin
    au!
    au FileType kotlin set makeprg=kotlinc\ -script\ %
augroup end

augroup ft_yaml
    au!
    au FileType yaml setlocal sw=2 sts=2
augroup end

augroup ft_sh
    au!
    au FileType sh nnoremap <F5> :sp term:///usr/bin/env bash %<CR>
    au FileType sh nnoremap <Leader>r :sp term:///usr/bin/env bash %<CR>
    au FileType sh setlocal sw=2 sts=2
augroup end

augroup ft_zsh
    au!
    au FileType zsh nnoremap <F5> :w !bash<CR>
    au FileType zsh nnoremap <Leader>r :w !bash<CR>
    au FileType zsh setlocal sw=2 sts=2
augroup end

" }}}

" }}}
