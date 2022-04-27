if [[ `uname` == "Darwin" ]]; then
  alias ls='ls -G'
elif ; then
  alias ls='ls --color=auto'
fi

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

alias etmux='$EDITOR ~/.tmux.conf'

alias ei3='$EDITOR ~/.config/i3/config'

which tmuxinator &> /dev/null
[[ $? -eq 0 ]] && alias mux='tmuxinator'

which tmuxinator-sessionizer &> /dev/null
[[ $? -eq 0 ]] && alias mx='tmuxinator-sessionizer'

alias szsh='source ~/.zshrc'

alias grp="cd ~/ghq"
alias rp="cd ~/Repos"
alias prp="cd ~/Repos/personal"

alias cb='git checkout $(git branch | fzf)'

alias nvconfig='cd $HOME/.config/nvim'

function ch_repo {
  dir=$(ls ~/Repos/ | grep -v 'personal' | fzf | sed 's/.*/Repos\/&/')

  if [[ -n $dir ]]; then
    cd $HOME/$dir
  fi
}

alias crp=ch_repo
alias erp="ch_repo && $EDITOR"

function ch_prepo {
  dir=$(ls ~/Repos/personal | fzf | sed 's/.*/Repos\/personal\/&/')

  if [[ -n $dir ]]; then
    cd $HOME/$dir
  fi
}

alias cprp=ch_prepo

alias ct='git tag | fzf | xargs git checkout'
