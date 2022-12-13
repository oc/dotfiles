eval "$(/opt/homebrew/bin/brew shellenv)"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Added by Toolbox App
export PATH="$PATH:/Users/oc/Library/Application Support/JetBrains/Toolbox/scripts"

