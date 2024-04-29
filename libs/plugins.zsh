# plugins and configurations
export PLUGINS=$HOME/.zsh/plugins
source $PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $PLUGINS/history/history.plugin.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
source $PLUGINS/git/git.plugin.zsh
source $PLUGINS/autojump/autojump.plugin.zsh
