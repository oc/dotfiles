export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(
  git gem ruby bundler python pyenv postgres docker gcloud yarn kubectx kubectl minikube
)
source $ZSH/oh-my-zsh.sh

BREW_CASKROOM="$(brew --prefix)/Caskroom"

HISTFILE=~/.zsh_history
HISTSIZE=50000000
SAVEHIST=50000000

setopt autocd extendedglob auto_pushd no_beep

unsetopt auto_name_dirs 

alias list_jdk='/usr/libexec/java_home -V'
#
JAVA_HOME=$(/usr/libexec/java_home)
# OpenJDK 11
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home

# Environment locale
LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

alias globurl='noglob urlglobber '

# Git
alias gup='git pull --rebase --stat -v'
alias gbme='git branch --merged'
alias gbno='git branch --no-merged'
alias gist='nocorrect gist'
alias gbcb='git symbolic-ref --short HEAD'
alias gbprune='git fetch --prune'

function gbclean() {
  test $(gbcb) = 'master' && (gbme|grep -v master|xargs git branch -D)
}

alias gpu='git push'
alias gsl='git shortlog -sn'
alias gup='git pull --rebase --stat -v'
alias grso='git remote show origin'
alias grprune='git remote prune origin'

# Projects
alias inf='cd ${HOME}/dev/infrastructure'

# Overrides
alias rake='nocorrect rake'
alias vi='vim'

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

alias nonascii="LC_COLLATE=C grep '[^ -~]' -nH"

# Misc helper functions
pix() { scp $1 oc:/var/www/oc/pix; }
ipv4() { curl -s http://testmyipv6.com/ | grep -A1 myIPaddr | tail -n1 }
ipv6() { curl -s http://v6.testmyipv6.com/ | grep -A1 myIPaddr | tail -n1 }

pgrep() { ps axco pid,command | grep "${*}" | grep -v grep }
pkill() { pgrep "${*}" | awk '{ print $1; }' | xargs kill }
pkill9() { pgrep "${*}" | awk '{ print $1; }' | xargs kill -9 }

update-dotfiles() {
  cd ${HOME}/dotfiles && rsync --exclude .git --exclude my.cnf --exclude boot.sh --exclude vimclojure-* -avz ${HOME}/dotfiles/ ${HOME}
}

mov2gif() {
  ffmpeg -ss 5 -t 25 -i $1 -vf "fps=10,scale=640:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $2
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# gcloud
source "${BREW_CASKROOM}/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "${BREW_CASKROOM}/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# Kubernetes
alias kc=kubectl
alias kctx='kubectl config current-context'

# Homebrew
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# gitDateToEpoch "Tue Jul 2 09:20:45 2019 +0200"
function gitDateToEpoch() {
  git_date=$1
  date -j -f "%a %b %d %T %Y %z" "$git_date" "+%s"
}

# lowercase uuid
alias uuidgenl="uuidgen | tr 'A-Z' 'a-z'"

export OPENSSL3_PATH="/opt/homebrew/opt/openssl@3"

# see .ruby-build-env
export LDFLAGS="${LDFLAGS} -L${OPENSSL3_PATH}/lib"
export CPPFLAGS="${CPPFLAGS} -I${OPENSSL3_PATH}/include"

# GKE
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# gpg
export GPG_TTY=$(tty)

export HISTFILE HISTSIZE SAVEHIST LANG LC_ALL JAVA_HOME GPG_TTY
export PATH="$OPENSSL3_PATH/bin:$PATH"

# asdf - node, ruby, python, etc
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# rbenv
#eval "$(rbenv init -)"

test -f ~/.secretrc && source ~/.secretrc
test -f ~/.clientrc && source ~/.clientrc
test -f ~/.ruby-build-env && source ~/.ruby-build-env
