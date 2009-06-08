alias ls="ls -G -F"
alias la="ls -al"
alias ll="ls -l"
alias l="ls"

alias pu="pushd ."
alias po="popd"

alias ws="cd /Users/oc/dev"

for a in local $(ls /opt/ | grep -v local | grep -v gentoo); do
	FULLPATH=/opt/$a
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
			export MANPATH="$FULLPATH/man:$MANPATH"
		fi
		if [ -x $FULLPATH/share/man ]; then
			export MANPATH="$FULLPATH/share/man:$MANPATH"
		fi
		if [ -x $FULLPATH/lib/pkgconfig ]; then
			export PKG_CONFIG_PATH="$FULLPATH/lib/pkgconfig/:$PKG_CONFIG_PATH"
		fi
	fi
done

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\033[1m\]\[\033[36m\]\w\\[\033[33m\]$(parse_git_branch)\[\033[0m\]\[\033[31m\]:\[\033[32m\]>\[\033[0m\] "

export LSCOLORS=DxGxcxdxCxcgcdabagacad #yellow dirs
#export LSCOLORS=ExGxFxDxCxHxHxCbCeEbEb #bold lightblue dirs

export HISTCONTROL=ignoredups #erasedups
export HISTFILESIZE=3000
export HISTIGNORE="ls:cd:[bf]g:exit:..:...:l:ll:la:pu:po"

# Java 6
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home

# JRuby Trunk
export JRUBY_HOME=/opt/jruby-trunk
export PATH=$PATH:~/.gem/jruby/1.8/bin:$JRUBY_HOME/bin

