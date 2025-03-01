# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/jriggles/.zsh/completions:"* ]]; then export FPATH="/Users/jriggles/.zsh/completions:$FPATH"; fi
setopt auto_cd
eval "$(/opt/homebrew/bin/brew shellenv)"

# NVM setup per brew info nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# enable realtime clock updates
POWERLEVEL9K_EXPERIMENTAL_TIME_REALTIME="true"
# enable p10k theme
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# enable uv shell completions
eval "$(uv generate-shell-completion zsh)"

# enable thefuck
eval $(thefuck --alias)

# add aseprite to PATH
# export PATH="/Applications/Aseprite.app/Contents/MacOS:$PATH"
export PATH="/Users/jriggles/Library/Application Support/Steam/steamapps/common/Aseprite/Aseprite.app/Contents/MacOS:$PATH"  # steam Aseprite path

# performs a few Hombrew commands in sequence
burp() {
  echo "Running brew update, upgrade, autoremove, and cleanup:"
  echo "Checking for updates..."
  brew update
  echo "Upgrading installed packages..."
  brew upgrade
  echo "Removing unused dependencies..."
  brew autoremove
  echo "Cleaning up outdated packages, removing cache files older than 90 days..."
  brew cleanup --prune=90
  echo "🥃 Cheers!"
}

# make a new dir and cd into it
function take() {
  mkdir -pv "$1";
  cd "$1"
}

# create new aseprite extension project with local and GitHub repos
# Usage: new-aseprite-extension name [displayName] [description]
function new-aseprite-extension() {
  if [ -z "$1" ]; then
    echo "Error: No extension name given."
    return 1
  fi

  gh repo create "$1" --public --template "https://github.com/JRiggles/Aseprite-Extension-Template" --clone
  cd "$1"
  mv extension/template.lua extension/"$1".lua
  # update extension's package.json
  jq ".name = \"$1\"" extension/package.json > temp.json && mv temp.json extension/package.json
  jq ".displayName = \"$2\"" extension/package.json > temp.json && mv temp.json extension/package.json
  jq ".description = \"$3\"" extension/package.json > temp.json && mv temp.json extension/package.json
  jq ".contributes.scripts[0].path = \"./$1.lua\"" extension/package.json > temp.json && mv temp.json extension/package.json
  code .
  cd -
}

# ---- aliases ----
# navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias @='open .'  # open cwd in Finder
alias -- -='cd -'  # go to previous wd
alias dt='cd ~/Desktop'
# general shorthand
alias aa='alias'
alias c='clear'
alias cls='clear'
alias clip='cb copy'
alias fetch='fastfetch'
alias h='history'
alias zrc='code ~/.zshrc'
alias zsh-config='code ~/.zshrc'
alias ez='source ~/.zshrc'  # reload zsh configs
alias md='mkdir'
# alias nano='sudo nano'
alias nq='networkQuality'
alias rb='ruby'
alias pbc='pbcopy'
alias pbp='pbpaste'
# crystal
alias cr='crystal'
alias crb='crystal build'
alias crr='crystal build $1 --release'
# git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -m'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gdca='git diff --cached'
alias gf='git fetch'
alias glog='git log --oneline --decorate --graph'
alias gm='git merge'
alias gp='git push'
alias gs='git status'
# python
alias fr='flask run'
alias fd='flask --debug run'
alias pip='python3 -m pip'
alias pup='pip install --upgrade pip'
alias py='python3'
alias venv-new='python3 -m venv .venv && source .venv/bin/activate'  # activate venv at cwd
alias poetry-test='poetry publish -r test-pypi'  # publish python package to test.pypi.org
# Created by `pipx` on 2024-06-07 00:06:41
export PATH="$PATH:/Users/jriggles/.local/bin"
export PATH="$HOME/.local/bin:$PATH"
. "/Users/jriggles/.deno/env"
