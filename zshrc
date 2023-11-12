# .zshrc

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.git-completion

#source ~/.git-prompt.sh
#setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
