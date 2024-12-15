# sessions
alias ta='tmux new-session -A -s'
alias td='tmux detach'
alias tk='tmux kill-session -t'
alias tl='tmux ls'
alias tmux_reorder='tmux move-window -s $1 -t $2'
alias tmux_resurrect_session="tmux-resurrect -s"

# send
function ts {
  if [[ -z "$2" ]]; then
    # if no args, send clipboard to window
    if [[ -n "$(pbpaste)" ]]; then
      tmux send-keys -t $1 "$(pbpaste)" C-m
    fi
  else
    args=${*:2}
    tmux send-keys -t $1 "$args" C-m
  fi
}

# config
alias hype='tmux new-session -A -s hype'
