export PATH="/usr/local/sbin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)

ulimit -n 10000

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.profile ]; then
  source ~/.profile
fi

