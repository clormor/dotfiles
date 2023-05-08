# .bashrc

bash_shell="/bin/bash"
curr_shell="$(echo $0)"

# Source global definitions
if [ -f /etc/bashrc  -a $curr_shell = $bash_shell ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
# setup git-completion
GIT_COMPLETION_CONFIG="$HOME/.git-completion"
if [ -f $GIT_COMPLETION_CONFIG  -a $curr_shell = $bash_shell ]; then
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
if [ "$(which gtar)" != "" ]; then
    alias tar='gtar'
fi

# git aliases
alias hlog='git log --date-order --all --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'
alias gits='git status'
alias gp='git push -u && git push --tags'
alias sign="git rebase --exec 'git commit --amend --no-edit -n -S' ${1:-origin/develop}"
alias rebase="git fetch && git rebase ${1:-origin/develop}"
alias merge="git fetch && git merge ${1:-origin/develop}"

# tmux aliases
alias tmux="TERM=screen-256color-bce tmux" # specifically for 256color compat in tmux + iterm

# misc aliases
alias info='info --vi-keys'
if [ -f ~/bin/find-gradle ]; then
    alias gw='find-gradle'
fi

# add certificates in various places
if [ -f ~/.trusted-certs ]; then
    if [ -f ~/.trusted-certs/PalantirThirdGenRootCA-selfsign.pem ]; then
        # for intellij
        export NODE_EXTRA_CA_CERTS=~/.trusted-certs/PalantirThirdGenRootCA-selfsign.pem
    fi
fi

which gpgconf >/dev/null
gpgconf_available=$?
if [ "$gpgconf_available" -eq "0" ]; then
    alias gpgagent='gpgconf --launch gpg-agent'
fi

# configure gradle user home
CUSTOM_GIT_VOLUME=/Volumes/git
if [ -d $CUSTOM_GIT_VOLUME ]; then
    export GRADLE_USER_HOME="$CUSTOM_GIT_VOLUME/.gradle"
    export GRADLECACHE_BACKUP_HOME="$CUSTOM_GIT_VOLUME/.gradlecache-backups"
fi

# configure rvm
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

# configure iterm2 shell integration
if [ -e "${HOME}/.iterm2_shell_integration.bash" -a $curr_shell = $bash_shell ]; then
    source "${HOME}/.iterm2_shell_integration.bash"
fi

# configure rbenv
if [ -d "$HOMEBREW_PREFIX/opt/rbenv" ]; then
    eval "$(rbenv init -)"
fi

OSX_JAVA_HOME_BIN=/usr/libexec/java_home
if [ -f $OSX_JAVA_HOME_BIN ]; then
    JAVA_8_HOME=$($OSX_JAVA_HOME_BIN -v 1.8)
    JAVA_11_HOME=$($OSX_JAVA_HOME_BIN -v 11)
fi

function get_corretto_jdk_home {
    echo "/Library/Java/JavaVirtualMachines/amazon-corretto-$1.jdk/Contents/Home"
}

if [ -d "$(get_corretto_jdk_home 8)" ]; then
    export JAVA_8_HOME="$(get_corretto_jdk_home 8)"
fi

if [ -d "$(get_corretto_jdk_home 11)" ]; then
    export JAVA_11_HOME="$(get_corretto_jdk_home 11)"
fi

if [ -d "$(get_corretto_jdk_home 17)" ]; then
    export JAVA_17_HOME="$(get_corretto_jdk_home 17)"
fi

if [ -d "$(get_corretto_jdk_home 19)" ]; then
    export JAVA_19_HOME="$(get_corretto_jdk_home 19)"
fi

export JAVA_HOME=$JAVA_11_HOME

# set display variable in coder environments
if [ "$(whoami)" = "coder" ]; then
    export DISPLAY=:90
fi

function prepend_path_if_exists {
    if [ -d $1 ]; then
        PATH="$1:$PATH"
    fi
}

function source_if_exists {
    if [ -f $1 ]; then
        source $1
    fi
}

# configure homebrew
if [ -d "$HOMEBREW_PREFIX" ]; then
    prepend_path_if_exists "$HOMEBREW_PREFIX/bin"
fi

prepend_path_if_exists "/usr/local/sbin"

# source nexus credentials
if [ -f ~/.nexus ]; then
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

if [ -f $HOMEBREW_PREFIX/bin/spark-submit ]; then
    export SPARK_LOCAL_IP="127.0.0.1"
    export SPARK_HOME="$(find /usr/local/Cellar/apache-spark -maxdepth 1 -mindepth 1 | sort -V | head -n 1)/libexec"
fi
prepend_path_if_exists "$SPARK_HOME/bin"

