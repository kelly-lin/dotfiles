alias ls='ls --color=auto'
[[ `uname` == 'Darwin' ]] && alias ls='ls -G'

alias ll='ls -alh'
alias la='ls -ah'

# diff tools
alias diff='colordiff'
alias wdiff="wdiff -n -w $'\033[30;41m' -x $'\033[0m' -y $'\033[30;42m' -z $'\033[0m'"

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ip='ip --color=auto'

which nvim &> /dev/null
if [[ $? -eq 0 ]]; then
  alias vim='nvim'
  alias vi='nvim'
fi

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# config shortcuts
alias nvc='cd $HOME/.config/nvim'
alias szsh='source ~/.zshrc'

# tmux
which tmuxinator &> /dev/null
[[ $? -eq 0 ]] && alias mux='tmuxinator'

which tmuxinator-sessionizer &> /dev/null
[[ $? -eq 0 ]] && alias mx='tmuxinator-sessionizer'

# repo navigation
alias crp='cd $(find ~/Repos -mindepth 1 -maxdepth 1 -type d | fzf)'
alias cgrp='cd $(find ~/ghq -mindepth 3 -maxdepth 3 -type d | fzf)'
alias cprp='cd $(find ~/Repos/personal -mindepth 1 -maxdepth 1 -type d | fzf)'

# git
alias cb='git checkout $(git branch | fzf)'
alias ct='git tag | fzf | xargs git checkout'
alias gpo='gp -u origin'

function add_worktree {
  git worktree add $1
  [[ $? -eq 0 ]] && cd $1
}
alias awt='add_worktree'
alias rwt='git worktree remove'
alias cwt="cd \$(git worktree list | awk '{ print \$1 }' | sed '/.*\.bare/d' | fzf)"
alias gbco='~/zsh/scripts/worktree-cline-bare.zsh'
