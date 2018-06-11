alias ls='ls -lGH'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias ga='git add'
alias gc='git commit'
alias grm='git rm'
alias gap='git add -p'
alias gpristine='git reset --hard && git clean -dfx'
alias gclean='git clean -fd'
alias gm="git merge"
alias gmv='git mv'
alias gs='git status'
alias gss='git status -s'
alias gl='git pull'
alias gp='git push'
alias gcount='git shortlog -sn'
alias gcb='git checkout -b'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
# From http://blogs.atlassian.com/2014/10/advanced-git-aliases/
# Show commits since last pull
alias gnew="git log HEAD@{1}..HEAD@{0}"
alias ggui="git gui"
alias gh='cd "$(git rev-parse --show-toplevel)"'

export FZF_DEFAULT_COMMAND='fd --type f'
export PATH='~/Library/Python/2.7/bin':$PATH

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi
