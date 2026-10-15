# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/chris/.docker/bin"
# End of Docker Desktop section.

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
