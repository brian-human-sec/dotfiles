# one of the first items called with respect to zsh

#export LC_ALL=en_US.UTF-8
# make zsh/terminfo work for terms with application and cursor modes

case "$TERM" in
  xterm-termite)
    #echo termite-workaround
    export TERM=xterm-256color
    ;;
  xterm)
    #echo xterm-workaround
    export TERM=xterm-256color
    ;;
esac

case $(tty) in
  /dev/tty[0-9]*)
    setfont ter-powerline-v16b
    export TERM=linux
    #echo in console
    sed -i 's/39d $CURRENT_FG/blue $CURRENT_FG/' ~/.oh-my-zsh/themes/agnoster.zsh-theme
  ;;
esac

[ -n "$STY" ] && export TERM="screen-256color"
[ -n "$TMUX" ] && export TERM="xterm-256color"
#echo ${TERM}

function gemerge() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: ${FUNCNAME} <package>" >&2
  else
    qlist -I | grep -v grep | grep $1
    if [ $? -ne 0 ]; then
      echo $1 will emerge.
      sudo emerge $1
    else
      echo  $1 already built.
    fi
  fi
}

function pjava() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: ${FUNCNAME} <appname>" >&2
  else
    mkdir -p src/main/java/$1
    mkdir -p src/main/resources
    touch src/main/resources/application.yml
    touch src/main/java/$1/Application.java
    mkdir -p src/test

    gradle wrapper
    ./gradlew wrapper --gradle-version=5.5.1
    rm -rf .gradle
  fi
}

function git_sparse_clone() (
  rurl="$1" localdir="$2" && shift 2

  mkdir -p "$localdir"
  cd "$localdir"

  git init
  git remote add -f origin "$rurl"

  git config core.sparseCheckout true

  # Loops over remaining args
  for i; do
    echo "$i" >> .git/info/sparse-checkout
  done

  git pull origin master
)

function gitpush() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: ${FUNCNAME} <messages>" >&2
  else
    git pull
    git add .
    git commit -m "$*"
    git push
  fi
}
