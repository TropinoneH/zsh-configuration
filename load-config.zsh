autoload -U compinit; compinit
for file in $HOME/.zsh/libs/*.zsh; do
  source $file
done
