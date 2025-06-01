source $HOME/.config/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
# Add ~/bin to PATH
export PATH="$HOME/bin:$PATH"


source "$(brew --prefix)/opt/zinit/zinit.zsh"
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# By using these annexes, you're extending the functionality of Zinit to handle more types of plugins and to provide additional features.
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# zinit ice wait lucid for
# zinit snippet ~/.aliases # gk: this might be faster for the prompt. but the prompt freezes until loaded. No gain.

### End of Zinit's installer chunk
#source /home/gk/.gears || true

eval "$(starship init zsh)"

# Keybindings
bindkey -e
bindkey "^[[3~" delete-char
bindkey '^p' history-search-backward
bindkey '^f' history-search-forward
bindkey '^[w' kill-region
# ctrl-r to search history via fzf!!

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt inc_append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_verify
setopt interactive_comments # allow comments in history file
setopt no_case_glob # case insensitive globbing
setopt auto_menu # show completion menu on a tab



source ~/.aliases
source "$HOME/.config/nvim/shell_helpers"
#
# ps ax pg ruby (pipe grep)
function first { head -n "${1:-1}" < /dev/stdin; }
function last { tail -n "${1:-1}" < /dev/stdin; }

alias -g 1n='1>/dev/null'
alias -g 2n='2>/dev/null'
# alias -g l='| last'
# alias -g f='| first' # makes find -type f failing.
alias -g g='| grep -i'
alias -g m='| more'
#alias -g e='| entr -c bash -c "' # ls pentr make"
alias -g c='| pbcopy'

#eval "$(fzf --zsh)"
eval "$(zoxide init --cmd z zsh)"


# . "$HOME/.atuin/bin/env"
# eval "$(atuin init zsh --disable-up-arrow)"
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# # Generated for envman. Do not edit.
# [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

