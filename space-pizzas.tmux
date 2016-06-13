tmux new-session -s space-pizzas -n tests -d

tmux send-keys -t space-pizzas 'cd ~/workspace/space-pizzas-client' C-m
tmux send-keys -t space-pizzas 'ember test --serve' C-m
tmux split-window -h -t space-pizzas:1
tmux send-keys -t space-pizzas 'cd ~/workspace/space-pizzas-server' C-m
tmux send-keys -t space-pizzas 'npm run test-watch' C-m
tmux split-window -h -t space-pizzas:1
tmux send-keys -t space-pizzas 'cd ~/workspace/space-pizzas-shared' C-m
tmux send-keys -t space-pizzas 'npm run test-watch' C-m
tmux select-layout -t space-pizzas:1 even-horizontal

tmux new-window -n server
tmux send-keys -t space-pizzas 'cd ~/workspace/space-pizzas-client' C-m
tmux send-keys -t space-pizzas 'ember serve' C-m
tmux split-window -h -t space-pizzas:2
tmux send-keys -t space-pizzas 'cd ~/workspace/space-pizzas-server' C-m
tmux send-keys -t space-pizzas 'npm run start-watch' C-m
tmux split-window -h -t space-pizzas:2
tmux send-keys -t space-pizzas 'cd ~/workspace/space-pizzas-shared' C-m
tmux send-keys -t space-pizzas 'npm run start' C-m
tmux select-layout -t space-pizzas:2 even-horizontal

tmux new-window -n ember
tmux send-keys -t space-pizzas 'cd ~/workspace/space-pizzas-client' C-m
tmux send-keys -t space-pizzas 'vim' C-m

tmux new-window -n node
tmux send-keys -t space-pizzas 'cd ~/workspace/space-pizzas-server' C-m
tmux send-keys -t space-pizzas 'vim' C-m

tmux new-window -n shared
tmux send-keys -t space-pizzas 'cd ~/workspace/space-pizzas-shared' C-m
tmux send-keys -t space-pizzas 'vim' C-m

tmux select-window -t space-pizzas:1

tmux attach -t space-pizzas
