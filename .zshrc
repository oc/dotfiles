# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/oh-my-zsh/themes/
test -e ~/.oh-my-zsh/themes/oc.zsh-theme || ln -s ~/.zsh/oc.zsh-theme ~/.oh-my-zsh/themes/oc.zsh-theme
export ZSH_THEME="oc"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git gem textmate ruby brew rails bundler)

source $ZSH/oh-my-zsh.sh

#autoload -U zutil
#autoload -U compinit complist promptinit zsh-mime-setup
#promptinit
#compinit
#complist
#zsh-mime-setup

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=500
setopt autocd extendedglob auto_pushd no_beep

# options
unsetopt auto_name_dirs # fix rvm

export EDITOR="mvim"
export GEM_EDITOR="mvim"
export BUNDLER_EDITOR="mvim"

# yellow dirs
#export LSCOLORS=DxGxcxdxCxcgcdabagacad
#LSCOLORS=Gxfxcxdxbxegedabagacad

# Environment locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Node
export PATH=/usr/local/share/npm/bin:$PATH

# Java
export JAVA_HOME=$(/usr/libexec/java_home)

# sbt-extras (paulp)
export SBT_EXTRAS=/opt/sbt-extras
export PATH=$SBT_EXTRAS:$PATH

# Clojure
#alias ng-lein='echo "Be sure to set :dev-dependencies [[vimclojure/server \"2.3.3\"]] "; java -cp "`lein classpath`" vimclojure.nailgun.NGServer 127.0.0.1'

# Autotest
export AUTOFEATURE=true

# OCI8
export NLS_LANG=NORWEGIAN_NORWAY.UTF8
#export DYLD_LIBRARY_PATH=/opt/oracle/instantclient_10_2

# Maven
export MAVEN_OPTS="-Xmx400m -Xms80m"

# Go
export GOROOT=`/usr/local/bin/brew --prefix go`
export GOBIN=/usr/local/bin
export GOARCH=amd64
export GOOS=darwin

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk

# Oracle DBMs
export ORACLE_HOME=/opt/instantclient_11_2
alias sqlplus='env DYLD_LIBRARY_PATH=$ORACLE_HOME /opt/instantclient_11_2/sqlplus'

export PATH=$HOME/bin:/usr/local/bin:$SCALA_HOME/bin:$CABAL_HOME/bin:$PATH:/usr/local/sbin

# /opt
for d in local $(ls /opt/ | grep -v local); do
  FULLPATH=/opt/$d
  if [ -x $FULLPATH ]; then
    if [ -x $FULLPATH/bin ]; then
      export PATH="$PATH:$FULLPATH/bin"
    fi
    if [ -x $FULLPATH/sbin ]; then
      export PATH="$PATH:$FULLPATH/sbin"
    fi
    if [ -x $FULLPATH/share/aclocal ]; then
      export ACLOCAL_FLAGS="-I $FULLPATH/share/aclocal $ACLOCAL_FLAGS"
    fi
    if [ -x $FULLPATH/man ]; then
      export MANPATH="$MANPATH:$FULLPATH/man"
    fi
    if [ -x $FULLPATH/share/man ]; then
      export MANPATH="$MANPATH:$FULLPATH/share/man"
    fi
    if [ -x $FULLPATH/lib/pkgconfig ]; then
      export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$FULLPATH/lib/pkgconfig/"
    fi
  fi
done

# Git
alias gup='git pull --rebase --stat -v'
alias gbme='git branch --merged'
alias gbno='git branch --no-merged'
alias gist='nocorrect gist'
alias globurl='noglob urlglobber '
alias gpu='git push'
alias gsl='git shortlog -sn'
alias gup='git pull --rebase --stat -v'
alias grso='git remote show origin'


# Projects
alias upr='cd /Users/oc/dev/uppercase.no'
alias gno='cd /Users/oc/dev/geno'
alias inf='cd /Users/oc/dev/infrastructure'
alias bh='cd /Users/oc/dev/binghodneland'
alias mb='cd /Users/oc/dev/manibus'

# Overrides
alias rake='nocorrect rake'
alias vi='mvim'
alias vim='mvim'

# Convenience...
alias ls="ls -G -F"
alias la="ls -alh"
alias ll="ls -l"
alias l="ls"

alias pu="pushd ."
alias po="popd"

alias m2='mvn -q clean install'
alias m2c='mvn -q clean install -DskipTests -P-integrationTests'
alias focus='mvn -q verify -Dcucumber.tags=@focus'

# Git
# see
alias g='git'
alias gst='git status'
alias gbno='git branch --no-merged'
alias gbme='git branch --merged'

alias gup='git pull --rebase --stat -v'
alias gpu='git push'
alias gd='git diff'
#alias gdv='git diff -w "$@" | vim -R -'
alias gba='git branch -a'
alias gsl='git shortlog -sn'
alias gcp='git cherry-pick'

#alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
alias gbup='git pull origin $(current_branch)'
alias gbal='git pull --all -v'
alias gbpu='git push origin $(current_branch)'
alias gbup='git pull origin $(current_branch)'

alias gbpnp='git pull origin $(current_branch) && git push origin $(current_branch)'

alias wtc='git commit -m "$(curl -qs whatthecommit.com | sed -nE '\''s/<p>(.*)/\1/p'\'')"'

# MySQL via homebrew
alias startmysql='mysql.server start'
alias stopmysql='mysql.server stop'

alias startmongo='mongod run --config /usr/local/etc/mongod.conf'

# PostgreSQL via homebrew
alias startpgsql='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'

alias stoppgsql='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

alias startredis='redis-server /usr/local/etc/redis.conf'

alias nonascii="LC_COLLATE=C grep '[^ -~]' -nH"

source ~/.secretrc

# Misc helper functions
pix() { scp $1 oc:/var/www/oc/pix; }

idiot-mv() {
  orig=$1
  dest=$2

  if [[ -f $dest ]]; then
    git reset HEAD $orig && git reset HEAD $dest && mv $dest ${dest}.tmp && git checkout $orig && git mv $orig $dest && mv ${dest}.tmp $dest && echo "OK"
  fi
}

update-dotfiles() {
  cd /Users/oc/dotfiles && rsync --exclude .git --exclude my.cnf --exclude boot.sh --exclude vimclojure-* -avz /Users/oc/dotfiles/ /Users/oc/
}

pgrep() { ps axco pid,command | grep "${*}" | grep -v grep }
pkill() { pgrep "${*}" | awk '{ print $1; }' | xargs kill }
pkill9() { pgrep "${*}" | awk '{ print $1; }' | xargs kill -9 }

#FFMPEG=/opt/homebrew/bin/ffmpeg
FFMPEG=/opt/avi2ipad/bin/ffmpeg

function avi2ipad() {
  for file in $*; do
    title=$(basename ${file} .avi)
    outfile=${title}.mp4
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    if [[ -f ${file} ]]; then
      echo "[${timestamp}] Converting ${file} to ${outfile}"

      time ${FFMPEG} -y -i ${file} -f mp4 -metadata title=${title} \
          -timestamp ${timestamp} -vcodec libx264 -level 30 -b 1024k \
          -bt 1024k -bufsize 10M -maxrate 10M -g 250 -coder 0 \
          -flags +loop -cmp +chroma \
          -partitions +parti4x4+partp8x8+partb8x8 -flags2 +mixed_refs \
          -me_method umh -subq 6 -trellis 1 -refs 3 -me_range 16 \
          -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -qmin 10 \
          -qmax 51 -qdiff 4 -threads 0 -acodec aac -ac 2 -ab 128k \
          ${outfile}
    fi
  done
}

# MP4 1.5M + aac
#time ${FFMPEG} -y -i ${file} -f mp4 -metadata title=${title} \
#    -timestamp ${timestamp} -vcodec libxvid -s 480x270 -b 1024k \
#    -bufsize 2M -maxrate 1.5M -g 250 -flags +aic+cbp+mv0+mv4 \
#    -trellis 1 -mbd 2 -cmp 2 -subcmp 2 -threads 0 -acodec aac \
#    -ac 2 -ab 128k ${outfile}

# Logstalgia goodness
function logstalgiaDomain() {
  domain=$1
  ssh_args="${@:2}"
  [[ -z "$ssh_args" ]] && {
    ssh_args=www-data@www1
  }
  echo "Tracking domain: ${domain}"
  echo ssh $ssh_args tail -f /var/log/nginx/${domain}.access.log \| logstalgia --sync -x
  ssh $ssh_args tail -f /var/log/nginx/${domain}.access.log | logstalgia --sync -x
}

function logstalgiaCaptureDomain() {
  domain=$1
  echo "Capturing domain: ${domain}"
  ssh www-data@www1 tail -f /var/log/nginx/${domain}.access.log | logstalgia --output-framerate 25 --output-ppm-stream www1-${domain}-$(date +%s).ppm --sync
}

function logstalgiaToMpeg() {
  for file in $*; do
    echo -n "Transcoding $file to $(basename $file .ppm).mp4"
    ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i $file -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 $(basename $file .ppm).mp4
    echo " [OK]"
  done
}

function ipv4() {
  curl -s http://testmyipv6.com/ | grep -A1 myIPaddr | tail -n1
}

function ipv6() {
  curl -s http://v6.testmyipv6.com/ | grep -A1 myIPaddr | tail -n1
}

source ~/.profile
# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
