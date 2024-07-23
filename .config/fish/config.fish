if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

# My aliases
alias eap='cd; ./install_me/ideaEAP/bin/idea'
alias dg='cd; ./install_me/datagrip/bin/datagrip'
alias ls='lsd'
alias ex='exit'
alias la='ls -a'
alias del='rm -rf'
alias tm='tmux new -s akbar'
alias tma='tmux a'
alias vi='nvim'
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'
alias cl='clear'
alias gp='git push origin main'
alias gc='git clone'
alias up='sudo dnf update -y; flatpak update -y'
alias open='xdg-open'
alias shut='shutdown now'
alias reb='reboot'
alias sdcv='sdcv -c'
function dic
	espeak-ng "$argv"
	sdcv -c "$argv"
end

starship init fish | source
