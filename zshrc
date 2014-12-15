#Detect 256-color terminal
if [[ $TERM == "xterm" ]]; then
	if printf '\e]4;255;?\a' | read -d $'\a' -s -t 1; then
		export TERM=xterm-256color
	fi
fi

eval "$(dircolors $HOME/.dircolors)"


# Set up antigen
source ~/.antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle command-not-found
#antigen bundle vi-mode
#antigen bundle z


# Completions
antigen bundle git
antigen bundle pip
antigen bundle vagrant
antigen bundle vundle


# Autostart
antigen bundle ssh-agent
ssh-add .ssh/id_ddwrt .ssh/id_utlrc .ssh/id_stlopenwrt
antigen bundle tmux
export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_AUTOQUIT=false

# fish style plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle tarruda/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions src

antigen theme robbyrussell

antigen apply

# zsh-autosuggestions configuration
zle-line-init() {
	zle autosuggest-start
}

zle -N zle-line-init


# zsh-history-substring-search configuration
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# zsh-syntax-highlighting configuration
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main pattern cursor)

