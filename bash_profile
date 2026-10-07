# .bash_profile

if [[ "$OSTYPE" -ne "mysys" ]]; then
    ulimit -n 10000
fi

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.profile ]; then
  source ~/.profile
fi
