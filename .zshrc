# .zshrc
# Author: Joakim Engeset <joakim.engeset@gmail.com>

# Uncomment to start profiling
#zmodload zsh/zprof

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# required for annexes
zinit wait lucid light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions \
  OMZ::lib/completion.zsh \
  OMZ::lib/history.zsh

# theme
zinit ice from"gh-r" as"program" atload'!eval $(starship init zsh)'
zinit light starship/starship

# history stuff
typeset -g HISTSIZE=50000 SAVEHIST=10000

# disable rm * confirmations
setopt rmstarsilent

# skru på emacs-binds (ctrl-p osv)
bindkey -e

# home/end/del support
bindkey -M emacs "${terminfo[khome]}" beginning-of-line # home-key
bindkey -M emacs "${terminfo[kend]}"  end-of-line # end-key
bindkey -M emacs "${terminfo[kdch1]}" delete-char # del-key

# åpne gjeldende kommando i $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

## env vars
export EDITOR=nvim
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_DEFAULT_OPTS='--height 40% --border'
#export MANPAGER="nvim -c 'set ft=man' -" # broken i nvim 0.5.1
export RIPGREP_CONFIG_PATH=~/.config/rg/config
export LC_ALL="en_US.utf-8"
export LPASS_AGENT_TIMEOUT=0
export BAT_THEME=base16
path=(~/go/bin ~/bin /usr/local/sbin ~/.emacs.d/bin ~/.local/bin/ $path)

# scripts
source ~/.fzf.zsh
[[ -f ~/.okrc ]] && source ~/.okrc
[[ -f ~/.tokens ]] && source ~/.tokens

# lazy load slow kubectl completion
function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi
    command kubectl "$@"
}

# quick edit
alias e=$EDITOR
alias em="open -a Emacs"
alias vc="e ~/.config/nvim/init.vim"
alias kc="e ~/.config/kitty/kitty.conf"
alias ac="e ~/.config/alacritty/alacritty.yml"
alias tc="e ~/.tmux.conf"
alias bc="e ~/.bashrc"
alias zc="e ~/.zshrc"
alias gc="e ~/.gitconfig"
alias oc="e ~/.okrc"
alias srcz="source ~/.zshrc"
alias er="$EDITOR README.md"

## k8s
alias k=kubectl
alias kx=kubectx
alias kn=kubens
alias kgp="k get pods"
alias kgi="k get ingress"
alias kge="k get events"
alias kgj="k get jobs"
alias kgs="k get secrets"
alias kgcj="k get cronjobs"
alias kgd="k get deployments"
alias kdd="k describe deployment"
alias kdp="k describe pod"
alias kdi="k describe ingress"
alias kdcj="k describe cronjob"
alias kdq="k describe quota resource"
alias kgnp="k get netpol"
alias wkgp="watch kubectl get pods"
alias wkgj="watch kubectl get jobs"
alias kgpi="kgp -o custom-columns='NAME:.metadata.name,IMAGE:spec.containers[*].image'"
alias kgns="kgd -o custom-columns=NAME:.metadata.name,nodeSelector:.spec.template.spec.nodeSelector"
alias kgn="get nodes -L k8s.oslo.kommune.no/dns-alias"

## helm
alias enc="helm-secrets-enc"
alias dec="helm-secrets-dec"

## system
alias pid='ps ax | ag -i '
alias info='info --vi-keys'
alias cdm="cd $(mktemp -d)"
alias ..="cd .."
alias ...="cd ..."
alias ....="cd ...."
alias .....="cd ....."
alias ......="cd ......"

if [[ $commands[lsd] ]]; then
  alias l='lsd -l'
  alias ls="lsd"
  alias tree='lsd --tree'
else
  alias l='ls -hlGALF'
  alias ls='ls -GAF'
fi

# tmux
alias t="tmux new -A -s 0"
alias tmux="tmux -2 -u"
alias tks="tmux kill-server"

# git
alias g=git
alias dotfile="git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias nb="new-branch"
alias c="git add . && git commit"
alias cdd="cd $HOME/dev"

# maven
alias mgs="mvn generate-sources"
alias mci="mvn clean install"
alias mcid="mci dockerfile:build"

# docker
#alias d=docker
alias di="docker images"
alias din="docker-inspect"
alias dpsa="docker ps -a"
alias dr="docker-run"
alias dcu="docker-compose up"
alias dco="docker-compose down"
alias dps="docker-image-push"
alias dil="docker-image-list"
alias dcs="docker-container-start"
alias dct="docker-container-stop"

# gpg
alias keys="gpg-show-key"

# fzf-file wrappers
fe()    fzf-file edit $1 # edit file
ztig()  fzf-file tig $1 # view git history for file
zrm()   fzf-file rm $1 # delete file
zcat()  fzf-file cat $1 # echo file contents
zpath() fzf-file copy-path $1 # copy absolute path of file
zcopy() fzf-file copy-content $1 # copy file contents

# fuzzy cd
zd() { dir=$(fzf-dir) && cd "$dir" }
kl() fzf-kill-process
fb() fzf-branch
co() fzf-branch-switch
erg() rg-edit "$1"

# Use fd instead of the default find for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

dclone() {
  gh repo clone "$1" $HOME/dev/github.com/"$1"
  cd $HOME/dev/github.com/"$1"
}

# requires kitty remote control to be enabled
kitty-switch-theme() {
  fd . ~/.config/kitty/kitty-themes/themes \
    | fzf --preview 'head -n 40 {} && kitty @ set-colors -a -c {}'
}
zsh-time-startup() entr time-startup <<< ~/.zshrc

clone() {
  repoPath=$HOME/dev/github.com/$1/$2
  [[ -d "$repoPath" ]] && {
          echo "$0: $repoPath: Directory exists, exiting"
          cd "$repoPath"
          return
  }
  gh repo clone https://www.github.com/$1/$2 $repoPath
  cd $repoPath
}

cordon() {
  kubectl cordon -l node-role.kubernetes.io/worker
}

uncordon() {
  kubectl uncordon -l node-role.kubernetes.io/worker
}

update-dotfiles() {
  dotfile commit -am 'Update dotfiles'
  dotfile push
}

[ -s "/Users/joakle/.jabba/jabba.sh" ] && source "/Users/joakle/.jabba/jabba.sh"
#zprof # Uncomment to stop active profiling
alias docker=podman
alias d=podman

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

