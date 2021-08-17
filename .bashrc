# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
# setup git-completion
GIT_COMPLETION_CONFIG="$HOME/.git-completion"
if [ -f $GIT_COMPLETION_CONFIG ]
then
    source $GIT_COMPLETION_CONFIG
fi

# aliasble color support for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
 
# some ls aliases
#alias ls='ls -G' # color, the GNU way. The BSD way (non-GNU coreutilis) is 'ls -G'
alias ls='ls --color=auto'
alias ll='ls -lFG'
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
    alias iup='insta start'
    alias idown='insta stop'
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

# configure gradle user home
CUSTOM_GIT_VOLUME=/Volumes/git
if [ -d $CUSTOM_GIT_VOLUME ]; then
    export GRADLE_USER_HOME="$CUSTOM_GIT_VOLUME/.gradle"
    export GRADLECACHE_BACKUP_HOME="$CUSTOM_GIT_VOLUME/.gradlecache-backups"
fi

BREW_PREFIX=$(brew --prefix 2>/dev/null)
if [ -d "$BREW_PREFIX" ]
then
    # configure bash-git-prompt
    if [ -f "$BREW_PREFIX/opt/bash-git-prompt/share/gitprompt.sh" ]; then
        __GIT_PROMPT_DIR="$BREW_PREFIX/opt/bash-git-prompt/share"
        GIT_PRMOPT_FETCH_REMOTE_STATUS=0
        GIT_PRMOPT_ONLY_IN_REPO=1
        GIT_PROMPT_THEME="Minimal_UserHost"
        source "$BREW_PREFIX/opt/bash-git-prompt/share/gitprompt.sh"
    fi
fi

# configure rvm
if [[ -s "$HOME/.rvm/scripts/rvm" ]]
then
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

# configure iterm2 shell integration
if [ -e "${HOME}/.iterm2_shell_integration.bash" ]
then
    source "${HOME}/.iterm2_shell_integration.bash"
fi

# configure rbenv
if [ -d "$BREW_PREFIX/opt/rbenv" ]
then
    eval "$(rbenv init -)"
fi

#DESIRED_JAVA_VERSION="1.8"
DESIRED_JAVA_VERSION=11
OSX_JAVA_HOME_BIN=/usr/libexec/java_home
if [ -f $OSX_JAVA_HOME_BIN ]
then
    JAVA_6_HOME=$($OSX_JAVA_HOME_BIN -v 1.6)
    if [ -d $JAVA_6_HOME ]
    then
        export JAVA_6_HOME
    fi
    JAVA_8_HOME=$($OSX_JAVA_HOME_BIN -v 1.8)
    if [ -d $JAVA_8_HOME ]
    then
        export JAVA_8_HOME
    fi
    JAVA_HOME=$($OSX_JAVA_HOME_BIN -v $DESIRED_JAVA_VERSION)
    if [ -d $JAVA_HOME ]
    then
        export JAVA_HOME
    fi
fi

function prepend_path_if_exists {
    if [ -d $1 ]
    then
        PATH="$1:$PATH"
    fi
}

function append_path_if_exists {
    if [ -d $1 ]
    then
        PATH="$PATH:$1"
    fi
}

function source_if_exists {
    if [ -f $1 ]
    then
        source $1
    fi
}

prepend_path_if_exists "/usr/local/sbin"

# configure legacy node
append_path_if_exists "/usr/local/opt/node@10/bin"
prepend_path_if_exists "~/.gem/ruby/2.6.0/bin"

# source nexus credentials
if [ -f ~/.nexus ]
then
    source ~/.nexus
fi

# add custom scripts to PATH
prepend_path_if_exists "$HOME/bin"
prepend_path_if_exists "$HOME/pbin"

source_if_exists "$HOME/pbin/.profile"

# configure environment variables
export ARTIFACTORY_URL=https://artifactory.palantir.build/artifactory
export HOMEBREW_EDITOR=/usr/bin/vim
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export PIPENV_DEFAULT_PYTHON_VERSION=3.7
prepend_path_if_exists "/usr/local/opt/coreutils/libexec/gnubin/"

# I will migrate to zsh one day, i promise
export BASH_SILENCE_DEPRECATION_WARNING=1
