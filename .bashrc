# aliasble color support for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
 
# some ls aliases
alias ls='ls -G' # color, the GNU way. The BSD way (non-GNU coreutils) is 'ls -G'
alias ll='ls -alF'
alias la='ls -A'

# use gnu-tar
alias tar='gtar'
 
# git aliases
alias hlog='git log --date-order --all --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'
alias gits='git status'
alias gp='git push && git push --tags'
 
# tmux aliases
alias tmux="TERM=screen-256color-bce tmux" # specifically for 256color compat in tmux + iterm
 
# misc aliases
alias info='info --vi-keys'

export PATH=~/bin:${PATH}

alias gw='find-gradle'

export HOMEBREW_EDITOR=/usr/bin/vim

export GROOVY_HOME=/usr/local/opt/groovy/libexec

export NEXUS_KEY_ID=0ED95D3C
export NEXUS_KEY_PASSWORD=8PZ2WE32uP6gHiVdkh7m2
export NEXUS_KEY_FILE=/Users/clormor/.gnupg/secring.gpg
export NEXUS_USER=clormor
export NEXUS_PASSWORD="umW.AM8:!um-rNW"

if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

PIPENV_DEFAULT_PYTHON_VERSION=3.7
