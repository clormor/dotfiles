#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#  . $(brew --prefix)/etc/bash_completion
#  PROG=insta source /usr/local/Library/Taps/palantir/homebrew-insta/autocomplete/bash_autocomplete
#fi

# aliasble color support for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
 
# some ls aliases
alias ls='ls -G' # color, the GNU way. The BSD way (non-GNU coreutils) is 'ls -G'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls' # because I commonly type sl (and don't want a steam locomotive)
 
# git aliases
alias hlog='git log --date-order --all --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'
alias gits='git status'
alias gitb='git branch'
alias gitp='git push && git push --tags'
alias gp='git push && git push --tags'
 
# tmux aliases
alias tmux="TERM=screen-256color-bce tmux" # specifically for 256color compat in tmux + iterm
 
# misc aliases
alias info='info --vi-keys'

#pgdev-hydration
export GOTHAM_CONTAINERS_HOME=/Users/clormor/git/palantir/gotham-containers-cli
export PGDEV_HOME=/Users/clormor/git/palantir/pgdev
export DOCKER_HOST=tcp://localhost:2375

export PATH=~/bin:${PATH}

alias gw='find-gradle'
# see https://prime.yojoe.local/question/2424/how-to-fix-build-path-contains-duplicate-entry-in-eclipsegradle-self-answered/
alias gd="find-gradle dependencies | grep '\-\-\-' | sed 's/.* \(.*\):\([^:]*\):\(.*\)/\2:\1/g' | sort | uniq | sed 's/\([^:]*\):\([^:]*\)\(.*\)/\1/g' | uniq -d"
alias gf='git-flow'

export HOMEBREW_EDITOR=/usr/bin/vim

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/Users/clormor/git/palantir/insta-bin/bin:$PATH"
