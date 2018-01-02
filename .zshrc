# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git gem textmate ruby rails bundler gulp django python pyenv postgres
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ----------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=500
setopt autocd extendedglob auto_pushd no_beep
unsetopt auto_name_dirs # fix rvm

export JAVA_HOME=$(/usr/libexec/java_home)

# Environment locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

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

alias nonascii="LC_COLLATE=C grep '[^ -~]' -nH"

# Misc helper functions
pix() { scp $1 oc:/var/www/oc/pix; }
ipv4() { curl -s http://testmyipv6.com/ | grep -A1 myIPaddr | tail -n1 }
ipv6() { curl -s http://v6.testmyipv6.com/ | grep -A1 myIPaddr | tail -n1 }

pgrep() { ps axco pid,command | grep "${*}" | grep -v grep }
pkill() { pgrep "${*}" | awk '{ print $1; }' | xargs kill }
pkill9() { pgrep "${*}" | awk '{ print $1; }' | xargs kill -9 }

update-dotfiles() {
  cd /Users/oc/dotfiles && rsync --exclude .git --exclude my.cnf --exclude boot.sh --exclude vimclojure-* -avz /Users/oc/dotfiles/ /Users/oc/
}

source ~/.secretrc
