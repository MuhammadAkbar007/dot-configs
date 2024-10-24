# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

ZSH_HIGHLIGHT_STYLES[command]='fg=blue'

bindkey "^[[1~" beginning-of-line  # Home
bindkey "^[[4~" end-of-line        # End
bindkey "^[[H" beginning-of-line  # Home key
bindkey "^[[F" end-of-line        # End key
bindkey "^[[1;5D" backward-word    # Ctrl + Left
bindkey "^[[1;5C" forward-word     # Ctrl + Right
bindkey "^[[3~" delete-char  # Map Delete key

# My aliases
alias httpie="AppImageLauncher ~/install_me/HTTPie-2024.1.2.AppImage"
alias eap="cd; ./install_me/idea-IU/bin/idea"
alias ls="lsd"
alias ex="exit"
alias la="ls -a"
alias del="rm -rf"
alias zj="zellij"
alias tm="tmux new-session -s akbar"
alias tma="tmux a"
alias vi="nvim"
alias v="nvim ./"
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'
alias fzf='fzf --preview="bat --color=always {}"'
alias cl="clear"
alias gp="git push origin main"
alias gc="git clone"
alias gadc="git add ~/.tmux.conf ~/.ideavimrc ~/.p10k.zsh ~/.zshrc ~/.config/kitty/ ~/.config/nvim/"
alias up="sudo dnf update -y; flatpak update -y"
alias open="xdg-open"
alias shut="shutdown now"
alias reb="reboot"
alias sdcv="sdcv -c"
function dic {
  espeak-ng "$1"
  sdcv -c "$1"
}

# Zoxide config
eval "$(zoxide init zsh)"

# Shell integration
eval "$(fzf --zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
