# .zshrc
# Author: Joakim Engeset <joakim.engeset@gmail.com> 

# source stuff ------------------------------------------------------------ {{{

# prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# api-tokens etc
[[ -s ~/.tokens ]] && source ~/.tokens

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# }}}
# options ----------------------------------------------------------------- {{{

DISABLE_AUTO_TITLE="true"
DISABLE_CORRECTION="true"
setopt rmstarsilent

# }}}
# environment variables --------------------------------------------------- {{{

export EDITOR="nvim"
export VISUAL="nvim"
export PATH=$PATH:~/bin
export JAVA_HOME=$(/usr/libexec/java_home)
export DOTFILES=~/code/repos/dotfiles
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# }}}
# aliases ----------------------------------------------------------------- {{{

# quick edit
alias vim=$EDITOR
alias zc=$EDITOR' ~/.zshrc'
alias vc=$EDITOR' ~/.vimrc'
alias tc=$EDITOR' ~/.tmux.conf'
alias bc=$EDITOR' ~/.bashrc'
alias fc=$EDITOR' ~/.config/fish/config.fish'
alias srcz="source ~/.zshrc"

# system
alias pid='ps ax | ag -i '
alias l="ls -hlAGLF"
alias ls="ls -AGF"
alias info='info --vi-keys'
alias rm="nocorrect rm"

# tmux
alias tmux="tmux -2 -u"
alias tks="tmux kill-server"

# homebrew
alias up="brew update"
alias ug="brew upgrade"
alias in="brew install"
alias cin="brew cask install"
alias se="brew search"

# Git
alias g='git'

# }}}
# functions --------------------------------------------------------------- {{{

# determine if in a git-repo
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# cli weather forecast
weather() {
  curl -s http://wttr.in/$1 | sed '/New/d;/Follow/d' # fuck promos
}

# browse chrome-history in tmux (stolen from junegunn)
c() {
  local cols sep
  export cols=$(( COLUMNS / 3 ))
  export sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select title, url from urls order by last_visit_time desc" |
    ruby -ne '
  cols = ENV["cols"].to_i
  title, url = $_.split(ENV["sep"])
  len = 0
  puts "\x1b[36m" + title.each_char.take_while { |e|
    if len < cols
      len += e =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/ ? 2 : 1
    end
  }.join + " " * (2 + cols - len) + "\x1b[m" + url' |
    fzf --ansi --multi --no-hscroll --tiebreak=index |
    sed 's#.*\(https*://\)#\1#' | xargs open
}

unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}

# fuzzy-edit
fe() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# fuzzy-cd
fd() {
  DIR=$(find . -type d -not -path '*/\.*') && cd $DIR
}

# fuzzy-cat into clipboard
zcat() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && cat "$file" | pbcopy
}

# fzf + git branch checout
gb() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
    fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
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
  done
}

staticdata() (
  ls $WIGGIN_REPO/*.sql | xargs wc -l | sort -k 1 -r | fzf-tmux
)

# }}}
# environment ------------------------------------------------------------- {{{

# automatically attach/create a tmux-session named <username>
if [[ "$TERM" != "screen-256color" ]]; then
  tmux attach-session -t "$USER" || tmux new-session -s "$USER"
  exit
fi

# }}}
