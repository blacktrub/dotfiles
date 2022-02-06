# How to add exists device 
```
git init --bare $HOME/.config
alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'" >> $HOME/.zshrc
```

# How to use 
```
config status
config push
config pull
```

