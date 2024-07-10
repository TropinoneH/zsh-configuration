autoload -U compaudit compinit
autoload -U compaudit && compinit
for file in $HOME/.zsh/libs/*.zsh; do
  source $file
done
