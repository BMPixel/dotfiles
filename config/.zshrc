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
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    dotenv
    pip
    docker
    # history-substring-search # just press ^R is enough
    # zsh-interactive-cd # I have to use enhancd instead
    )

# Load the oh-my-zsh's completion system
autoload -Uz compinit && compinit

# Init oh-my-zsh
source $ZSH/oh-my-zsh.sh

# init starship
eval "$(starship init zsh)"

# init enhancd
# temporarily disable enhancd
# source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/enhancd/init.sh

# source ~/.bash_aliases if it exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
