# .zshrc
# Author: Joakim Engeset <joakim.engeset@gmail.com>

# environment variables
export DISABLE_AUTO_UPDATE=true
export DOCKER_BUILDKIT=1
export EDITOR=$([[ -n "$NVIM_LISTEN_ADDRESS" ]] && echo nvr || echo nvim)
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export GO111MODULE=on
export KITTY_CONFIG_DIRECTORY=~/.config/kitty
export MANPAGER="nvim -c 'set ft=man' -"
export PATH=~/go/bin:~/bin:/usr/local/sbin:$PATH
export RIPGREP_CONFIG_PATH=~/.rgrc
export ZSH=~/.oh-my-zsh
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_DISABLE_COMPFIX=true
export LC_ALL="en_US.utf-8"

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
has_bin() {
  command -v "$1" &>/dev/null
}

include $ZSH/oh-my-zsh.sh
include ~/.tokens
include ~/.fzf.zsh
include ~/.ok.zsh

# quick edit
alias e=$EDITOR
alias vc="e ~/.config/nvim/init.vim"
alias kc="e ~/.config/kitty/kitty.conf"
alias tc="e ~/.tmux.conf"
alias bc="e ~/.bashrc"
alias zc="e ~/.zshrc"
alias gc="e ~/.gitconfig"
alias srcz="source ~/.zshrc"
alias oc="e ~/.ok.zsh"
alias k=kubectl
alias kgp="kubectl get pods"
alias kx=kubectx

# system
alias pid='ps ax | ag -i '
alias info='info --vi-keys'

# unalias some oh-my-zsh stuff
unalias l
unalias ls

if has_bin exa; then
  alias l='exa -al'
  alias ls='exa -a'
  alias l1='exa -a1'
  alias tree='exa -aT'
else
  alias l='ls -hlGALF'
  alias ls='ls -GAF'
  alias l1='ls -1AG'
fi

# tmux
alias tmux="tmux -2 -u"
alias tks="tmux kill-server"

# git
alias g=hub
alias d="git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias prlist="g pr list -f \"%t%n%U%n%n\""
alias prcopy="prlist | pbcopy"
alias gfs="git flow feature start"
alias gff="git flow feature finish"
alias gpr="git pull-request"

# maven
alias mgs="mvn generate-sources"
alias mci="mvn clean install"

# determine if in a git-repo
in_git_repo() {
  git rev-parse @ &> /dev/null
}



# fzf-wrappers
fzfk() {
  file=$(fzf-tmux \
    --query=$2 \
    --select-1 \
    --exit-0 \
    --preview='[[ $(file --mime {}) =~ binary ]] && echo "<binary>" ||
                 (bat --style=numbers --color=always {} ||
                  cat {}) 2> /dev/null | head -500'
  ) || return

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

# fuzzy cd (fzf + fd -t d)
zd() {
  file=$(fd -t d | fzf-tmux --preview="ls -1 {}/") || return
  cd "$file"
}

# fzf + kill -9
fk() {
  pid=$(ps -ef | fzf-tmux | awk '{print $2}')
  [[ -n $pid ]] && kill -9 $pid
}

# list branches i care about
branches(){
  git for-each-ref --format='%(refname:short)' refs/{heads,remotes}/ \
    | rg -v demo | rg -v HEAD | rg -v origin/master | rg -v origin/develop
}

# fzf + git checkout branch
fb() {
    in_git_repo || return
    log_pattern="git log -b {} --pretty=format:'%h %d %s'"
    branch=$(branches | sort | fzf-tmux --preview=$log_pattern)
    git checkout $branch
}

# open rg-results in editor
erg() {
  $EDITOR $(rg -l $1)
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

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

emacs() {
  open -a Emacs $1
}

lpass_copy_password() {
  # add fzf-filtering of accounts here later
  lpass show $1 --password --clip
}

# git: delete pruned branches
gdpb() {
  git branch -vv | rg origin | rg ": gone]" | awk '{print $1}' | xargs git branch -d
}

# fzf+git: checkout and track remote branch
review() {
    in_git_repo || return
    log_pattern="git log -b {} --pretty=format:'%h %d %s'"
    branch=$(branches | rg origin | sort | fzf-tmux --preview=$log_pattern)
    git checkout -t $branch
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR=$HOME/.sdkman
include  ~/.sdkman/bin/sdkman-init.sh
