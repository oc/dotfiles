# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="oc"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git gem textmate ruby brew)

source $ZSH/oh-my-zsh.sh

# fix rvm
unsetopt auto_name_dirs

# yellow dirs
export LSCOLORS=DxGxcxdxCxcgcdabagacad
#LSCOLORS=Gxfxcxdxbxegedabagacad

# Scala
export SCALA_HOME=/opt/scala

# JRuby Trunk
export JRUBY_HOME=/opt/jruby-trunk

# JRebel
export JREBEL_HOME=/opt/jrebel

# Android
export ANDROID_SDK=/opt/android-sdk-mac_86

# Haskell cabal
export CABAL_HOME=/Users/oc/.cabal

export RUBYGEMS_BIN=/Library/Ruby/Gems/1.8/bin
export GEM_EDITOR=mate
export BUNDLER_EDITOR=mate

# Autotest
export AUTOFEATURE=true

# OCI8
export NLS_LANG=NORWEGIAN_NORWAY.UTF8
export DYLD_LIBRARY_PATH=/opt/oracle/instantclient_10_2

# Maven
export M2_HOME=/opt/maven
export MAVEN_OPTS="-XX:MaxPermSize=128m"

export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH:/usr/local/mysql/bin:$JRUBY_HOME/bin:$SCALA_HOME/bin:$ANDROID_SDK/tools:/Users/oc/.gem/ruby/1.8/bin:$CABAL_HOME/bin:$RUBYGEMS_BIN:/Users/oc/bin

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

# Convenience
alias ls="ls -G -F"
alias la="ls -alh"
alias ll="ls -l"
alias l="ls"

alias pu="pushd ."
alias po="popd"

alias j='jruby'
alias js='jruby -S'
alias gen='ruby script/generate'
alias m2='mvn clean install'
alias m2c='mvn clean install -DskipTests -P-integrationTests'
alias cuke='cucumber features'

# MySQL via homebrew
alias startmysql='/opt/homebrew/Cellar/mysql/5.1.47/share/mysql/mysql.server start'
alias stopmysql='/opt/homebrew/Cellar/mysql/5.1.47/share/mysql/mysql.server stop'

alias startredis='redis-server /opt/homebrew/etc/redis.conf'

# Misc helper functions
pix() { scp $1 oc:/var/www/oc/pix; }

idiot-mv() {
  orig=$1
  dest=$2

  if [[ -f $dest ]]; then
    git reset HEAD $orig && git reset HEAD $dest && mv $dest ${dest}.tmp && git checkout $orig && git mv $orig $dest && mv ${dest}.tmp $dest && echo "OK"
  fi
}

# RVM
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi
