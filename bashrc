# .bashrc

bash_shell="/bin/bash"
curr_shell="$0"

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

# use python3 if its on the path
#if [ "$(which python3)" != "" ]; then
#    alias python='python3'
#fi

# use gnu-tar
if command -v gtar >/dev/null 2>&1; then
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

if command -v gpgconf >/dev/null 2>&1; then
    alias gpgagent='gpgconf --launch gpg-agent'
fi

# configure gradle user home
CUSTOM_GIT_VOLUME=/Volumes/git
if [ -d $CUSTOM_GIT_VOLUME ]; then
    export GRADLE_USER_HOME="$CUSTOM_GIT_VOLUME/.gradle"
    export GRADLECACHE_BACKUP_HOME="$CUSTOM_GIT_VOLUME/.gradlecache-backups"
fi

# configure iterm2 shell integration
if [ -e "${HOME}/.iterm2_shell_integration.bash" -a $curr_shell = $bash_shell ]; then
    source "${HOME}/.iterm2_shell_integration.bash"
fi

for _jdk_version in 8 11 17 19; do
    _jdk_home="/Library/Java/JavaVirtualMachines/amazon-corretto-$_jdk_version.jdk/Contents/Home"
    if [ -d "$_jdk_home" ]; then
        export "JAVA_${_jdk_version}_HOME=$_jdk_home"
    fi
done
unset _jdk_version _jdk_home

if [ -n "$JAVA_11_HOME" ]; then
    export JAVA_HOME="$JAVA_11_HOME"
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
prepend_path_if_exists "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin/"

# highlight symlinks with colours suited to the active macOS appearance.
# dark mode: bold cyan (01;36) for valid, bold red (01;31) for broken.
# light mode: normal blue (00;34) for valid, bold red (01;31) for broken.
# Requires GNU ls/dircolors (Homebrew coreutils on macOS).
if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b)"
    if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q Dark; then
        _ln_color="01;36"
    else
        _ln_color="00;34"
    fi
    LS_COLORS="${LS_COLORS}:ln=${_ln_color}:or=01;31:mi=01;31"
    unset _ln_color
    export LS_COLORS
fi

prepend_path_if_exists "$HOME/.codeium/windsurf/bin"
prepend_path_if_exists "$HOME/.local/bin"

source_if_exists "$HOME/.git-prompt.sh"

# Tell GPG what terminal to use for passphrase prompts
export GPG_TTY="${TTY:-$(tty)}"

# source tokens/secrets (not committed to source control)
source_if_exists "$HOME/.tokens"

