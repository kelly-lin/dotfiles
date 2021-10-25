if [[ `uname` == "Darwin" ]]; then
  alias ls='ls -G'
elif ; then
  alias ls='ls --color=auto'
fi

alias ll='ls -alh'
alias la='ls -ah'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

alias vim='nvim'
alias vi='nvim'
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

alias etmux='$EDITOR ~/.tmux.conf'

alias evim='$EDITOR ~/.config/nvim/init.vim'

alias ezsh='$EDITOR ~/.zshrc'
alias szsh='source ~/.zshrc'

alias cb='git checkout $(git branch | fzf)'

ch_repo() {
  dir=$(ls ~/Repos/ | grep -v 'personal' | fzf | sed 's/.*/Repos\/&/')

  if [[ -n $dir ]]; then
    cd $HOME/$dir
  fi
}
alias repos=ch_repo

ch_prepo() {
  dir=$(ls ~/Repos/personal | fzf | sed 's/.*/Repos\/personal\/&/')

  if [[ -n $dir ]]; then
    cd $HOME/$dir
  fi
}
alias prepos=ch_prepo

