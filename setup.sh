#!/usr/bin/env bash

# Soft link .dotfile
link_home_file() {
  # if $1 is already a symlink, then overwrite it.
  if [ -L ~/$1 ]; then
    rm ~/$1
    ln -s $PWD/config/$1 ~/$1
    echo "Overwrite $1"
    return
  fi
  
  # if $1 is a file, then backup it and link it.
  if [ -f ~/$1 ]; then
    bat --paging never ~/$1
    read -p "Do you want to backup your $1? [y/n]" answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        mv ~/$1 ~/$1.bak
        ln -s $PWD/config/$1 ~/$1
    else 
        echo "Does not backup your $1. link stopped."
    fi
    
    # if $1 is not a file or a soft link, then link it.
  else 
    echo "No $1 found."
    ln -s $PWD/config/$1 ~/$1
  fi
}

# Remove linked file, if there is a .bak file, recover it
unlink_home_file() {
  if [ -L ~/$1 ]; then
    rm ~/$1
    echo "Remove $1"
    if [ -f ~/$1.bak ]; then
      mv ~/$1.bak ~/$1
      echo "Recover $1 from $1.bak"
    fi
  fi
}

uninstall() {
# Unlink all files
  for file in ${dot_file_list[@]}; do
    unlink_home_file $file
  done
  # source original .bashrc or .zshrc if it exists
  if [ $SHELL = "/bin/bash" ]; then
    test -f ~/.bashrc && source ~/.bashrc
  elif [ $SHELL = "/bin/zsh" ]; then
    test -f ~/.zshrc && source ~/.zshrc
  fi
}

dot_file_list=('.bash_aliases' '.tmux.conf' '.bashrc' '.zshrc')
install() {
  # Install tmux, git, bat
  if [ -x "$(command -v apt_get)" ]; then
    echo 'Install with apt_get.'
    apt_get update
    apt_get install -y tmux git bat
  fi

  if [ -x "$(command -v yum)" ]; then
    echo 'Install with yum.'
    # tmux with newest version must be installed with this repo
    yum install -y http://galaxy4.net/repo/galaxy4-release-7-current.noarch.rpm
    yum install -y tmux git

    # Install bat
    wget -c http://repo.openfusion.net/centos7-x86_64/bat-0.7.0-1.of.el7.x86_64.rpm --no-check-certificate
    yum install -y bat-0.7.0-1.of.el7.x86_64.rpm
    rm bat-0.7.0-1.of.el7.x86_64.rpm
  fi

  # Link all files
  for file in ${dot_file_list[@]}; do
    link_home_file $file
  done

  # source .bashrc or .zshrc
  if [ $SHELL = "/bin/bash" ]; then
    source ~/.bashrc
  elif [ $SHELL = "/bin/zsh" ]; then
    source ~/.zshrc
  fi
}

# $1 can be either 'install' or 'uninstall'
if [ "$1" = "install" ]; then
  install
elif [ "$1" = "uninstall" ]; then
  uninstall
else
  echo "Usage: $0 [install|uninstall]"
fi