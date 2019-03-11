# =============================================================================
# config.fish
# Author: Joakim Engeset <joakim.engeset@gmail.com>
# =============================================================================

# source stuff ------------------------------------------------------------ {{{

# api-tokens etc
[ -s ~/.tokens ]; and source ~/.tokens
[ -s ~/.z.fish ]; and source ~/.z.fish

# }}}
# environment variables --------------------------------------------------- {{{

set -xg REPO $HOME/dev/dev.azure.com
set -xg WYRM_REPO $REPO/Wyrm
set -xg W_REPO $REPO/Wiggin
set -xg W_UID aa323
set -xg W_DB aa323_Wiggin
set -xg W_SVR 'i2-rotdsql-001'

set -xg GOPATH $HOME/dev/local/go
set -xg PATH $PATH $HOME/bin $GOPATH/bin
set -xg EDITOR "nvim"
set -xg DIFF $EDITOR
set -xg VISUAL $EDITOR
set -xg SVN_EDITOR $EDITOR
set -xg RIPGREP_CONFIG_PATH $HOME/.rgrc
set -xg DOCKER_BUILDKIT 1
set -xg GO111MODULE on

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
# }}}
# aliases ----------------------------------------------------------------- {{{

# quick edit
alias e $EDITOR
alias t "$EDITOR ~/Documents/Notes/TODO.md"
alias fc "$EDITOR ~/.config/fish/config.fish"
alias vc "$EDITOR ~/.config/nvim/init.vim"
alias kc "$EDITOR ~/.config/kitty/kitty.conf"
alias tc "$EDITOR ~/.tmux.conf"
alias bc "$EDITOR ~/.bashrc"
alias zc "$EDITOR ~/.zshrc"
alias gc "$EDITOR ~/.gitconfig"
alias srcf "source ~/.config/fish/config.fish"
alias git hub

# system
alias vim nvim
alias top htop
alias cl clear
alias pid "ps ax | rg "
alias l 'ls -hlAFG'
alias ls 'ls -AFG'
alias .. 'cd ../'
alias ... 'cd ../../'
alias .... 'cd ../../../'
alias ..... 'cd ../../../../'
alias ...... 'cd ../../../../../'

# tmux
alias tmux "tmux -2 -u"
alias tks "tmux kill-server"

# homebrew
alias bi "brew install"
alias bs "brew search"
alias br "brew remove"
alias bup "brew update"
alias bug "brew upgrade"
alias bci "brew cask install"

# Git
alias g git
alias d "/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"


# }}}
# functions --------------------------------------------------------------- {{{

# fish {{{

function sudo --description '!!-support for sudo'
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

# }}}
# general {{{

function is_in_git_repo --description 'determine if in git repo'
    git rev-parse HEAD > /dev/null 2>&1
end

function weather --description 'cli weather-forecast'
    set -q $argv[1]; and echo 'Please specify a location'; and return
    curl -s http://wttr.in/$argv[1] | sed '/New/d;/Follow/d' # fuck promos
end

function prl_ip --description 'return IP of win10 parallels-instance'
    set pat '\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}'
    prlctl list "Windows 10" -o ip | grep -o $pat
end

function n --description 'test for network connectivity'
    while true
        nc -z google.com 80 -G 1; and break
        echo -n '.'
    end
end

function fzf-select-one --description 'select a single object from stdin'
    set file (fzf-tmux --query="$1" --select-1 --exit-0 --preview='cat {}')
    [ -n "$file" ]; and echo $file
end


function fe --description 'fzf -> edit'
    set file (fzf-select-one); or return
    eval $EDITOR \"$file\"
end

function ztig --description 'fzf -> tig'
    set file (fzf-select-one); or return
    eval tig \"$file\"
end

function zcat --description 'fzf -> cat -> clipboard'
    set file (fzf-select-one); or return
    cat "$file" | pbcopy
end

function zgd --description 'fzf -> git diff'
    set file (fzf-select-one); or return
    git diff "$file"
end

function gb --description 'fzf -> git checkout branch'
    is_in_git_repo; or return
    set log_pattern "git log -b {} --pretty=format:'%h %d %s'"
    set branch (git for-each-ref --format='%(refname:short)' refs/{heads,remotes}/ | sort | fzf-tmux --preview=$log_pattern)
    git checkout $branch
end

function fserv --description 'fzf -> set current Wiggin server'
    set file (cat ~/.config/wiggin/SERVERS | fzf-tmux --query="$1" --select-1 --exit-0)
    set -xg WIGGIN_SERVER $file
end

function kl --description 'fzf -> kill -9 <pid>'
    set pid (ps -ef | fzf-tmux | awk '{print $2}')
    [ -n $pid ]; and kill -9 $pid
end

function staticdata --description 'determine size of static-data files'
    ls $WIGGIN_REPO/WigginDB/Data/*.sql | xargs wc -l | sort -k 1 -r | fzf-tmux
end

function ext --description 'tarball all files in current directory'
    set name (basename (pwd))
    cd ..
    tar -cvzf "$name.tgz" --exclude .git --exclude target \
        --exclude "*.log" "$name"
    cd -
    mv ../"$name".tgz .
end

# }}}

# }}}
# environment ------------------------------------------------------------- {{{

# disable fish greeting
set -g -x fish_greeting ''

# git prompt options
set __fish_git_prompt_showcolorhints 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'

# git prompt status chars
set __fish_git_prompt_char_cleanstate      '✔'
set __fish_git_prompt_char_dirtystate      '✚'
set __fish_git_prompt_char_invalidstate    '✖'
set __fish_git_prompt_char_stagedstate     '→'
set __fish_git_prompt_char_stateseparator  '|'
set __fish_git_prompt_char_untrackedfiles  '…'
set __fish_git_prompt_char_upstream_ahead  '↑'
set __fish_git_prompt_char_upstream_behind '↓'
set __fish_git_prompt_char_upstream_equal ''
set __fish_git_prompt_char_upstream_prefix ''

# prompt definition
function fish_prompt
    set last_status $status

    set_color $fish_color_cwd
    printf '%s ' (prompt_pwd)
    set_color normal

    #printf '%s ' (__fish_git_prompt)
    #set_color normal
end

# }}}
