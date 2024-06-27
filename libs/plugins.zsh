# plugins and configurations
export PLUGINS=$HOME/.zsh/plugins
export ZSH_CUSTOM=$HOME/.zsh/custom

source $PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh

source $PLUGINS/history/history.plugin.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

source $ZSH_CUSTOM/plugins/zsh-trashz/trashz.plugin.zsh

source $PLUGINS/git/git.plugin.zsh

source $PLUGINS/zsh-z/zsh-z.plugin.zsh
