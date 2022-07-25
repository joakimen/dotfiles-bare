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

## theme
zinit ice from"gh-r" as"program" atload'!eval $(starship init zsh)'
zinit light starship/starship

# history stuff
typeset -g HISTSIZE=100000 SAVEHIST=100000

# disable rm * confirmations
setopt rmstarsilent

# enable comments in inline shell commands
setopt interactivecomments

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
export MANPAGER='nvim +Man!'
export RIPGREP_CONFIG_PATH=~/.config/rg/config
export LC_ALL="en_US.utf-8"
export LPASS_AGENT_TIMEOUT=0
export BAT_THEME=base16
export XDG_CONFIG_HOME="$HOME/.config"
export DOCKER_HOST='unix:///Users/joakle/.local/share/containers/podman/machine/podman-machine-default/podman.sock'
export BUILDAH_FORMAT=docker
path=(~/go/bin ~/bin /usr/local/sbin ~/.emacs.d/bin ~/.local/bin/ $path)

# scripts
source ~/.fzf.zsh
source ~/.tokens
source $XDG_CONFIG_HOME/shell/aliasrc
source ~/.okrc

# lazy load slow kubectl completion
function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi
    command kubectl "$@"
}

# fzf-file wrappers
fe()    fzf-file edit $1 # edit file
ztig()  fzf-file tig $1 # view git history for file
zrm()   fzf-file rm $1 # delete file
zcat()  fzf-file cat $1 # echo file contents
zpath() fzf-file copy-path $1 # copy absolute path of file
zcopy() fzf-file copy-content $1 # copy file contents

# fuzzy cd
zd() { dir=$(select-dir) && cd "$dir" }
kl() fzf-kill-process
fb() switch-branch
co() switch-remote-branch
erg() rg-edit "$1"

# Use fd instead of the default find for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

fzf-switch-branch() {
  zle -I

  git rev-parse --git-dir &> /dev/null || return

  local_branches=$(git for-each-ref --format='%(refname:short)' refs/heads)
  log_pattern="git log -b {} --pretty=format:'%h %d %s'"

  chosen_branch=$(fzf --preview="$log_pattern" -0 <<< "$local_branches")
  [[ $chosen_branch ]] && git switch "$chosen_branch"
}
zle -N fzf-switch-branch
bindkey '^B' fzf-switch-branch

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

update-dotfiles() {
  dotfile commit -am 'Update dotfiles'
  dotfile push
}

project-cd() {
  dir=$(project-list | fzf)
  [[ $dir ]] && cd "$OK_DIR/$dir"
  zle reset-prompt
}
zle -N project-cd
bindkey '^O' project-cd

fzf-cd() {
  dir=$(fd -t d | fzf --preview="ls -1 {}/")
  [[ $dir ]] && cd "$dir"
  zle reset-prompt
}
zle -N fzf-cd
bindkey '^G' fzf-cd

pipi() {
  pip install "$1" && pip freeze | rg "$1" >> requirements.txt
}

export o="-o yaml | nvim -c 'setf yaml'"

# asdf version manager
. $HOME/.asdf/asdf.sh

#zprof # Uncomment to stop active profiling
