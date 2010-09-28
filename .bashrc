parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git::\1)/'; }
parse_svn_branch() { parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn::"$2 ")"}'; }
parse_svn_url() { svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '; }
parse_svn_repository_root() { svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '; }
pix() { scp $1 oc:/var/www/oc/pix; }

export PS1='\[\033[1m\]\[\033[36m\]\w\[\033[33m\]$(parse_git_branch)$(parse_svn_branch)\[\033[0m\]\[\033[31m\]:\[\033[32m\]➔\[\033[0m\] '

export LSCOLORS=DxGxcxdxCxcgcdabagacad #yellow dirs
#export LSCOLORS=ExGxFxDxCxHxHxCbCeEbEb #bold lightblue dirs

shopt -s cmdhist
export HISTCONTROL=erasedups #ignoredups
export HISTFILESIZE=5000
export HISTIGNORE="&:ls:cd:[bf]g:exit:..:...:l:ll:la:pu:po:unrar:exit"

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
alias la="ls -al"
alias ll="ls -l"
alias l="ls"

alias pu="pushd ."
alias po="popd"

alias j='jruby'
alias js='jruby -S'
alias gen='ruby script/generate'
alias m2='mvn clean install'
alias cuke='cucumber features'

# MySQL via homebrew
alias startmysql='/opt/homebrew/Cellar/mysql/5.1.47/share/mysql/mysql.server start'
alias stopmysql='/opt/homebrew/Cellar/mysql/5.1.47/share/mysql/mysql.server stop'

alias startredis='redis-server /opt/homebrew/etc/redis.conf'

# Resty REST convenience
if [[ -f /Users/oc/.bash/resty.bash ]] ; then source /Users/oc/.bash/resty.bash ; fi

# Git completion
if [[ -f /Users/oc/.bash/git-completion.bash ]] ; then source /Users/oc/.bash/git-completion.bash ; fi

function idiotMv() {
  orig=$1
  dest=$2

  if [[ -f $dest ]]; then
    git reset HEAD $orig
    git reset HEAD $dest

    mv $dest ${dest}.tmp
    git checkout $orig
    git mv $orig $dest
    mv ${dest}.tmp $dest
    echo "OK"
  fi
}

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

alias wtf='dmesg'
alias onoz='cat /var/log/errors.log'
alias rtfm='man'

alias visible='echo'
alias invisible='cat'
alias moar='more'

alias icanhas='mkdir'
alias donotwant='rm'
alias dowant='cp'
alias gtfo='mv'

alias hai='cd'
alias plz='pwd'

alias inur='locate'

alias nomz='ps -aux'
alias nomnom='killall'

alias cya='reboot'
alias kthxbai='halt'