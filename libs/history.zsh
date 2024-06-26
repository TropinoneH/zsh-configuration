# use history in .zsh_history

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 500000 ] && HISTSIZE=500000
[ "$SAVEHIST" -lt 100000 ] && SAVEHIST=100000

setopt appendhistory
setopt extended_history
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
