#!zsh
# This script is used to install dotfile into devcontainer

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install starship
# save install script to /tmp
curl -fsSL https://starship.rs/install.sh -o /tmp/install.sh
sh /tmp/install.sh --yes

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
    mv ~/$1 ~/$1.bak
  else
    echo "No $1 found. Linked it."
  fi
  ln -s $PWD/config/$1 ~/$1
}


dot_file_list=('.bash_aliases' '.tmux.conf' '.bashrc' '.zshrc' '.gitconfig')

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
exec zsh