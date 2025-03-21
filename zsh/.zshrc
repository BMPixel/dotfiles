## Install Zinit if not already installed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zi ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zi light starship/starship
zi light bmpixel/dotfiles
zi light zsh-users/zsh-autosuggestions
zi ice wait lucid
zi light zsh-users/zsh-completions
zi ice wait lucid
zi light zdharma-continuum/fast-syntax-highlighting

# Load completions
autoload -Uz compinit && compinit
zi cdreplay -q

### Custom functions
has() { (( $+commands[$1] )) }
# Healthcheck function for zsh
healthcheck() {
    local plugins=(zoxide direnv fzf bat eza fd tmux uv rg nvim)
    for plugin in "${plugins[@]}"; do
        echo -n "    $plugin: "
        has "$plugin" && echo "✅" || echo "❌"
    done
}

### Common aliases
alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias df='df -h'
alias du='du -h'
alias sctl='systemctl'
alias jctl='journalctl'
alias ssr='sudo systemctl restart'
alias sst='sudo systemctl start'
alias sss='sudo systemctl status'
alias ssj='sudo journalctl -xeu'
alias ssp='sudo systemctl stop'
has code && alias c="code"
has cursor && alias c="cursor"
has nvim && alias vim="nvim"
has docker-compose && alias dc="docker-compose"

### Initialize plugins
has zoxide && eval "$(zoxide init zsh --cmd cd)"
has eza && alias ls='eza' && alias tree='eza --tree'
has fzf && source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
has direnv && eval "$(direnv hook zsh)"
has uv && eval "$(uv generate-shell-completion zsh)"
has uvx && eval "$(uvx --generate-shell-completion zsh)"
has vim && export EDITOR="vim" 
has nvim && export EDITOR="nvim"

### Misc
bindkey "^E" edit-command-line # Enable Ctrl+E to edit command in editor
# Function to run commands in tmux
tx() {
  if [[ -n "$TMUX" ]]; then
    return 0
  fi

  if [[ $# -eq 0 ]]; then
    tmux new -As "${PWD:t}"
  else
    local window_name="run_${1}_$RANDOM"
    tmux new-session -s "$window_name" "$*; $SHELL"
  fi
}