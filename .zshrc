# .zshrc
# Author: Joakim Engeset <joakim.engeset@gmail.com>

# environment variables
export ZSH=~/.oh-my-zsh
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export EDITOR="nvim"
export PATH=~/go/bin:~/bin:$PATH
export DOCKER_BUILDKIT=1
export GO111MODULE=on
export RIPGREP_CONFIG_PATH=~/.rgrc
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zsh theme
ZSH_THEME="robbyrussell"

# DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_UPDATE_PROMPT="true"
setopt rmstarsilent

# oh-my-zsh plugins
plugins=(
  github
  fast-syntax-highlighting
  history-substring-search
  zsh-autosuggestions
)

# source files
include() {
  [[ -f "$1" ]] && source "$1"
}

include $ZSH/oh-my-zsh.sh
include .tokens
include .wiggin
include .fzf.zsh

# quick edit
alias e=$EDITOR
alias vc="e ~/.config/nvim/init.vim"
alias kc="e ~/.config/kitty/kitty.conf"
alias tc="e ~/.tmux.conf"
alias bc="e ~/.bashrc"
alias zc="e ~/.zshrc"
alias gc="e ~/.gitconfig"
alias srcz="source ~/.zshrc"

# system
alias pid='ps ax | ag -i '
alias l="ls -hlAGLF"
alias ls="ls -AGF"
alias info='info --vi-keys'

# tmux
alias tmux="tmux -2 -u"
alias tks="tmux kill-server"

# git
alias g=hub
alias d="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"


# determine if in a git-repo
in_git_repo() {
  git rev-parse @ &> /dev/null
}

# fzf-wrappers
fzfk() {
  file=$(fzf-tmux --query=$2 --select-1 --exit-0 --preview='cat {}') || return

  case "$1" in
    edit) ${EDITOR:-vim} $file ;;
    tig) tig $file ;;
    copy-filepath) echo $(pwd)/$file | pbcopy ;;
    copy-content) cat $file | pbcopy ;;
    *) echo "$0: invalid operation $1" ;;
  esac
}

fe()    { fzfk edit $1 } # fuzzy edit
ftig()  { fzfk tig $1 } # fuzzy tig
fpath() { fzfk copy-filepath $1 } # fuzzy copy absolute path of file
fcat()  { fzfk copy-content $1 } # fuzzy copy contents

# fzf + kill -9
fk() {
  pid=$(ps -ef | fzf-tmux | awk '{print $2}')
  [[ -n $pid ]] && kill -9 $pid
}

# fzf + git checkout branch
fb() {
    in_git_repo || return
    log_pattern="git log -b {} --pretty=format:'%h %d %s'"
    branch=$(git for-each-ref --format='%(refname:short)' refs/{heads,remotes}/ | sort | fzf-tmux --preview=$log_pattern)
    git checkout $branch
}

# return IP of win10 parallels-instance
prl_ip() {
  pat='\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}'
  prlctl list "Windows 10" -o ip | grep -o $pat

}

# wait for network connectivity
n() {
  while true; do
    nc -z google.com 80 -G 1 && break
    echo -n '.'
    sleep 0.5
  done
}

# stream logs from docker engine
docker_log() {
  pred='process matches ".*(ocker|vpnkit).*"
 || (process in {"taskgated-helper", "launchservicesd", "kernel"}
 && eventMessage contains[c] "docker")'
  log stream --style syslog --level=debug --color=always --predicate "$pred"
}
