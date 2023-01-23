#!zsh
# !This file is not for use now!
# This script is used to install dotfile into devcontainer so there is no need to install oh-my-zsh and zsh

# Install with yum is hard like hell, so I just give up.
# if [ -x "$(command -v yum)" ]; then
#   echo 'Install with yum.'
#   # tmux with newest version must be installed with this repo
#   yum install -y http://galaxy4.net/repo/galaxy4-release-7-current.noarch.rpm
#   yum install -y tmux git

#   # Install bat
  # wget -c http://repo.openfusion.net/centos7-x86_64/bat-0.7.0-1.of.el7.x86_64.rpm --no-check-certificate
  # yum install -y bat-0.7.0-1.of.el7.x86_64.rpm
  # rm bat-0.7.0-1.of.el7.x86_64.rpm
# fi
DIR=$(SELF=$(dirname "$0") && bash -c "cd \"$SELF\" && pwd")


# Soft link .dotfile
link_home_file() {
  # if $1 is already a symlink, then overwrite it.
  if [ -L ~/$2 ]; then
    rm ~/$2
    ln -s $DIR/$1 ~/$2
    echo "Overwrite $2"
    return
  fi
  
  # if $1 is a file, then backup it and link it.
  if [ -f ~/$2 ]; then
    mv ~/$2 ~/$2.bak
  else
    echo "No $2 found. Linked it."
  fi
  ln -s $DIR/$1 ~/$2
}

install()
{   
  # Instal thefuck with pip if pip is installed
  if [ -x "$(command -v pip)" ]; then
    pip install thefuck
  fi

  # Install tmux, bat, fzf, zsh and ripgrep with package manager
  #  with apt-get
  if [ -x "$(command -v apt-get)" ]; then
    echo 'Install with apt-get.'
    sudo apt-get update
    sudo apt-get install -y tmux bat ripgrep fd-find zsh

    # bat is named batcat in ubuntu, so we need to link it to bat
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
    # Same thing applies to fd
    ln -s /usr/bin/fdfind ~/.local/bin/fd
  fi

  # Install with apk in alpine
  if [ -x "$(command -v apk)" ]; then
    echo 'Install with apk.'
    sudo apk update
    sudo apk add tmux bat ripgrep fd zsh
  fi

  # Install with brew in macos
  if [ -x "$(command -v brew)" ]; then
    echo 'Install with brew.'
    brew install tmux bat ripgrep fd zsh
  fi

  # Install zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  # Install zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  # Install starship
  # save install script to /tmp
  curl -fsSL https://starship.rs/install.sh -o /tmp/install.sh
  sh /tmp/install.sh --yes > /dev/null

  # Install fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all > /dev/null

  # Link all files
  link_home_file config/.zshrc .zshrc
  link_home_file config/.bash_aliases .bash_aliases
  link_home_file config/.bashrc .bashrc
  link_home_file config/.gitconfig .gitconfig
  link_home_file config/.tmux.conf .tmux.conf

  # if .config does not exist, create it
  if [ ! -d ~/.config ]; then
    mkdir ~/.config
  fi
  link_home_file config/starship.toml .config/starship.toml

  # source .bashrc or .zshrc
exec zsh
}