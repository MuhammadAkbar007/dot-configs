# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# My aliases
alias eap='cd; ./install_me/ideaEAP/bin/idea'
alias ls='lsd'
alias ex='exit'
alias la='ls -a'
alias del='rm -rf'
alias tm='tmux new -s akbar'
alias cl='clear'
alias cd='z'
alias gp='git push origin main'
alias gc='git clone'
alias up='sudo dnf update -y; flatpak update -y'
alias open='xdg-open'
alias shut='shutdown now'
alias reb='sudo reboot now'
alias sdcv='sdcv -c'
function dic {
  espeak-ng "$1"; sdcv -c "$1"
}

eval "$(starship init bash)"
eval "$(zoxide init bash)"
