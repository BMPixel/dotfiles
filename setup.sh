# Soft link other .dotfile
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.bash_aliases ~/.bash_aliases

# Install tmux, bat, git
if [ -x "$(command -v apt_get)" ]; then
  echo 'Install with apt_get.'
  apt_get update
  apt_get install -y tmux bat git
fi

if [ -x "$(command -v yum)" ]; then
  echo 'Install with yum.'
  yum install -y tmux bat git
fi
