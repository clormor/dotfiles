# .zshrc

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.git-completion

#setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

# https://direnv.net/docs/hook.html
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
    export PATH=/opt/homebrew/opt/ruby/bin:$PATH
    export PATH=`gem environment gemdir`/bin:$PATH
fi

if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi

