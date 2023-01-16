# Soft link other .dotfile
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.bash_aliases ~/.bash_aliases

# Link zshrc
if [ $SHELL = "/bin/zsh" ]; then
  ln -s $PWD/.zshrc ~/.zshrc
  . ~/.zshrc
fi

# Link bashrc
if [ $SHELL = "/bin/bash" ]; then
  ln -s $PWD/.bashrc ~/.bashrc
  . ~/.bashrc
fi

# Quit if not Linux
if [ "$(uname)" != "Linux" ]; then
  echo 'Not Linux, exit.'
  exit 0
fi

# Install tmux, git
if [ -x "$(command -v apt_get)" ]; then
  echo 'Install with apt_get.'
  apt_get update
  apt_get install -y tmux git
fi

if [ -x "$(command -v yum)" ]; then
  echo 'Install with yum.'
  yum install -y tmux git
fi
