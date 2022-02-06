# How to add exists device 
```
git init --bare $HOME/.config
alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'" >> $HOME/.zshrc
config remote add origin git@github.com:blacktrub/dotfiles.git
```

# How to use 
```
config status
config push
config pull
```

Original source - https://www.atlassian.com/git/tutorials/dotfiles
