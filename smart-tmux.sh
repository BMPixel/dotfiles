#!/bin/bash
# This script is used to start a new tmux session if the current directory is not the same as the one in the tmux session
/usr/local/bin/tmux new -s0 > /dev/null 2>&1
cwd=$(/usr/local/bin/tmux display-message -p -F "#{pane_current_path}" -t0)
if [ "$cwd" != "$PWD" ]; then
    /usr/local/bin/tmux new-window -t0:
    /usr/local/bin/tmux run -t0 "cd $PWD"
fi
/usr/local/bin/tmux attach -t0 -c $PWD