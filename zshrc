# .zshrc

(( $+functions[_startup_mark] )) && _startup_mark etc_zshrc

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
(( $+functions[_startup_mark] )) && _startup_mark bashrc

# Nested shells inherit FPATH, so prepending again would duplicate entries.
# compinit rebuilds ~/.zcompdump whenever the completion file count changes,
# which costs 200ms to several seconds on each switch between shell depths.
typeset -U fpath
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.git-completion

#setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

# https://direnv.net/docs/hook.html
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi
(( $+functions[_startup_mark] )) && _startup_mark mise

setopt interactive_comments
export NODE_AUTH_TOKEN="$GH_PAT"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/chris/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions

(( $+functions[_startup_mark] )) && _startup_mark compinit
if (( $+functions[_startup_log] )); then
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _startup_log
fi
