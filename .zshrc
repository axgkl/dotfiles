#source $HOME/.config/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
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

# Enable fallback to file completion when command-specific completion isn't available
setopt COMPLETE_IN_WORD
setopt AUTO_MENU
# Add _files to the completer list so it's always tried as a fallback
zstyle ':completion:*' completer _complete _approximate _files
# Make file completion work better
zstyle ':completion:*' file-patterns '*:all-files'


# # Generated for envman. Do not edit.
# [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


#source $HOME/.config/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
# Add ~/bin to PATH
export PATH="$HOME/bin:$PATH"

# Add Atuin to PATH
export PATH="$HOME/.atuin/bin:$PATH"

# Configure zsh-vi-mode to work with Atuin
function zvm_after_init() {
  # Initialize Atuin
  eval "$(atuin init zsh)"
  
  # Manually rebind Ctrl+R for Atuin in both modes
  bindkey -M vicmd '^R' atuin-search-vicmd
  bindkey -M viins '^R' atuin-search-viins
  # Also bind in emacs mode just in case
  bindkey -M emacs '^R' atuin-search
}


source /Users/gk/.config/broot/launcher/bash/br

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
# export MAMBA_EXE='/opt/homebrew/bin/micromamba';
# export MAMBA_ROOT_PREFIX='/Users/gk/micromamba';
# __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__mamba_setup"
# else
#     alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
# fi
# unset __mamba_setup
# <<< mamba initialize <<<

# PATH="/Users/gk/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/Users/gk/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/Users/gk/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/Users/gk/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/Users/gk/perl5"; export PERL_MM_OPT;
