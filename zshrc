# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="amuse"
plugins=(git kubectl docker docker-compose)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
fi

source ~/git/bob/bob-zsh-completion
compdef _bob bob

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


## SB1
function sst {
  SSN=$1
  SSN=${SSN:-30049312063}
  curl -s https://www.test.sparebank1.no/sr-bank/nettbank-privat/autologon/rest/autologon\?ssn\=${SSN} | jq -r '.parentSST'
}

# Gå til kundefront-mappe
function ku {
  APP=$(find ~/git/awl-monorepo/apps -mindepth 2 -maxdepth 2 -type d -name 'kundefront*' | sed 's:.*/::' | fzf)
  cd $(find ~/git/awl-monorepo/apps -mindepth 2 -maxdepth 2 -type d -name "*${APP}")
}

# Gå til api-mappe
function a {
  APP=$(find ~/git/awl-monorepo/apps -mindepth 2 -maxdepth 2 -type d -name 'api*' | sed 's:.*/::' | fzf)
  cd $(find ~/git/awl-monorepo/apps -mindepth 2 -maxdepth 2 -type d -name "*${APP}")
}

function gcos {
  git checkout $(git branch | grep -v '^*' | fzf)
}

function gdb  {
  BRANCH=$(git branch | grep -v '^*' | awk '{print $1}' | fzf)
  echo Trying to delete branch $BRANCH
  git checkout master
  git pull --prune
  git checkout $BRANCH
  git rebase master
  git checkout master
  git branch -d $BRANCH 
}

alias clip="xclip -selection c"

# function hest {
#   echo $1
# }
# _hest() {
#   echo $1
#   compadd $(find ~/git/awl-monorepo/apps -maxdepth 2 -type d -regextype posix-extended -regex ".*(kundefront|api)-pm-.*$0.*")
# }
# 
# compdef _hest hest
