# .bash_profile

ulimit -n 10000

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.profile ]; then
  source ~/.profile
fi

if [[ -d /Users/clormor/opt/miniconda/bin ]];then
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
fi
