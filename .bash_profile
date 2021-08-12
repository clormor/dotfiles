export PATH="/usr/local/sbin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -F -v11)
#export JAVA_HOME=$(/usr/libexec/java_home -F -v1.8)

ulimit -n 10000

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.profile ]; then
  source ~/.profile
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/clormor/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/clormor/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/clormor/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/clormor/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
