# Installation
## Install Node
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node
```
## Install Plug in manager:
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Use .vimrc file from this directory:
```
mv ~/.vimrc ~/.vimrc_backup
cp vimrc ~/.vimrc
```

# Usage

If on windows to copy to clipboard select using C-v or whatever and then do y. Paste as normal for windows.

C-y  - use selected autocomplete
C-n  - cycle through next suggestions, press enter to select one
C-p  - cycle through previous suggestions, press enter to select one





