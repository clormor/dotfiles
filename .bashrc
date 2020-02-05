# aliasble color support for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
 
# some ls aliases
alias ls='ls -G' # color, the GNU way. The BSD way (non-GNU coreutils) is 'ls -G'
alias ll='ls -lF'
alias la='ls -A'

# use gnu-tar
alias tar='gtar'
 
# git aliases
alias hlog='git log --date-order --all --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'
alias gits='git status'
alias gp='git push && git push --tags'
 
# tmux aliases
alias tmux="TERM=screen-256color-bce tmux" # specifically for 256color compat in tmux + iterm
 
# insta aliases
if [ -f /usr/local/opt/insta/bin/insta ]; then
    alias il='insta list'
    alias iup='insta start'
    alias idown='insta down'
    alias ipg='insta workspace'
    alias ipem='insta pem'
    alias ig='insta gemini'
    alias issh='insta ssh'
    alias iscp='insta scp'
fi

# misc aliases
alias info='info --vi-keys'
if [ -f ~/bin/find-gradle ]
then
    alias gw='find-gradle'
fi

# configure bash-git-prompt
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="$(brew --prefix)/opt/bash-git-prompt/share"
    GIT_PRMOPT_FETCH_REMOTE_STATUS=0
    GIT_PRMOPT_ONLY_IN_REPO=1
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# configure rvm
if [[ -s "$HOME/.rvm/scripts/rvm" ]]
then
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

# configure iterm2
if [ -e "${HOME}/.iterm2_shell_integration.bash" ]
then
    source "${HOME}/.iterm2_shell_integration.bash"
fi

# configure rbenv
if [ -d "$(brew --prefix)/opt/rbenv" ]
then
    eval "$(rbenv init -)"
fi

# configure legacy java versions for palantir builds
cached_jdk=$(find ${GRADLE_HOME:-"~/.gradle"}/caches/jdks/macosx -type d -regex ".*/jdk[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}_[0-9]\{1,6\}" | sort -V | tail -n 1)
if [ -d $cached_jdk ]
then
    export JAVA_8_HOME=$cached_jdk
    export JAVA_1_8_HOME=$cached_jdk
fi

if [ -d /Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home ]
then
    export JAVA_6_HOME=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
    export JAVA_1_6_HOME=$JAVA_6_HOME
fi

# source nexus credentials
if [ -f ~/.nexus ]
then
    source ~/.nexus
fi

# add palantir scripts to PATH
if [ -d $HOME/pbin ]
then
    export PATH="$PATH:$HOME/pbin"
fi

# configure environment variables
export ARTIFACTORY_URL=https://artifactory.palantir.build/artifactory
export HOMEBREW_EDITOR=/usr/bin/vim
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export PATH=~/bin:${PATH}
export PIPENV_DEFAULT_PYTHON_VERSION=3.7
export PATH="/usr/local/opt/coreutils/libexec/gnubin/:$PATH"
