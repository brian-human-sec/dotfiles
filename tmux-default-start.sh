#!/bin/sh

tmux -2 new-session -d -s Main
tmux rename-window -t Main irssi
tmux new-window -t Main -n mutt
tmux new-window -t Main -n newsboat
tmux new-window -t Main -n monitor
tmux new-window -t Main -n finance_app

# tmux split-window -t Main:0 -v -p 78
# tmux split-window -t Main:0.1 -v -p 10
# tmux split-window -t Main:0.2 -h -p 40

tmux send-keys -t Main:1 "irssi" Enter

# tmux send-keys -t Main:0.0 "while true; do sleep 3; screen sleep 1 nmtui; done" Enter
# tmux send-keys -t Main:0.1 "while true; do sleep 1; screen sleep 1; /home/coke/.xmonad/waitcon.sh 9; done" Enter
# tmux send-keys -t Main:0.2 "while true; do sleep 1; /home/coke/.xmonad/waitcon.sh 10; done" Enter
# tmux send-keys -t Main:0.3 "while true; do sleep 1; /home/coke/.xmonad/whomonitor.sh; done" Enter

tmux split-window -t Main:2 -v -p 90
tmux send-keys -t Main:2 "mutt" Enter
# tmux send-keys -t Main:1.0 "whoami" Enter
# tmux send-keys -t Main:1.1 "pwd" Enter

tmux split-window -t Main:3 -h -p 90
tmux send-keys -t Main:3 "newsboat" Enter

tmux split-window -t Main:4 -h
tmux split-window -t Main:4 -v
tmux split-window -t Main:4 -v
tmux send-keys -t Main:4.1 "htop" Enter

tmux split-window -t Main:5 -h -p 90
tmux split-window -t Main:5 -v -p 90
tmux send-keys -t Main:5.1 "cd ~/projects/raspi-finance-endpoint" Enter
tmux send-keys -t Main:5.2 "cd ~/projects/raspi-finance-react" Enter

tmux select-pane -t Main:5.1

tmux -2 attach-session -t Main

exit 0
