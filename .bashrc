echo "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ‎"

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
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

# for rust path of lsd
export PATH=/home/akbar/.cargo/bin:$PATH

# starship config
eval "$(starship init bash)"

alias ls='lsd'
alias ex='exit'
alias la='ls -a'
alias del='rm -rf'
alias tm='tmux new -s akbar'
alias cl='clear'
alias gp='git push origin main'
alias gc='git clone'
alias up='sudo dnf update -y; flatpak update -y'
alias open='xdg-open'
alias shut='shutdown now'
alias litexl='cd; ./install_me/LiteXL-v2.1.1-x86_64.AppImage'
