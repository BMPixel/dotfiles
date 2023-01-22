# directly launch tmux if in kitty
if [[ $TERM = "xterm-kitty" ]]; then
  echo "launching tmux"
  tmux new -As0
fi


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# update automatically without asking
zstyle ':omz:update' mode auto 

# Show completion dots while waiting for completion
COMPLETION_WAITING_DOTS="true" 

# All the plugins you want to load
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    dotenv
    )


source $ZSH/oh-my-zsh.sh

# init starship
eval "$(starship init zsh)"

# source ~/.bash_aliases if it exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

