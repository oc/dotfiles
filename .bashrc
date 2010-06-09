parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git::\1)/'  
}
parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn::"$2 ")"}'
}
parse_svn_url() {
  svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '
}
parse_svn_repository_root() {
  svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '
}
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

# Java Rebel
export JAVAREBEL_HOME=/opt/javarebel

export PATH=$JAVA_HOME/bin:/opt/subversion/bin:$PATH:/usr/local/mysql/bin:$JRUBY_HOME/bin:$SCALA_HOME/bin

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

alias ls="ls -G -F"
alias la="ls -al"
alias ll="ls -l"
alias l="ls"

alias pu="pushd ."
alias po="popd"

# Code-convenience
alias j='jruby'
alias js='jruby -S'
alias gen='ruby script/generate'
alias m2='mvn clean install'
alias cuke='rake features'

# Projects
alias spo='cd /Users/oc/dev/BRING/sporing/sporing-web'
alias rep='cd /Users/oc/dev/BRING/mybring/trunk/dev/rapport'
 
gn() {
  cmd=Command
  test $# -gt 0 && cmd=$@  
  eval $cmd
  growlnotify -n Shell -m "exited with $?" "$cmd"
}

# Resty for curl
. ~oc/.resty

# MySQL 5.1.41 via homebrew
alias startmysql='/opt/homebrew/Cellar/mysql/5.1.41/share/mysql/mysql.server start'
alias stopmysql='/opt/homebrew/Cellar/mysql/5.1.41/share/mysql/mysql.server stop'

# RVM
if [[ -f /Users/oc/.rvm/scripts/rvm ]] ; then source /Users/oc/.rvm/scripts/rvm ; fi
