export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Aliases
alias ls='ls --color'
alias ll='ls -alF'
alias la='ls -A'
alias grep='grep --color=auto'
alias rm='rm -i'

# Vim all the way
export EDITOR=vim
export VISUAL=vim
set -o vi

# Antigen
source $(brew --prefix)/share/antigen.zsh

antigen use oh-my-zsh

antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle git

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

# antigen theme robbyrussell
# antigen theme gnzh amuse
antigen theme miloshadzic

antigen apply
