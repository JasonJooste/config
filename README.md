# My config
A repo containing my config files and a script required for getting neovim running. 
## Running setup
In order to install (as root):
```bash
# Install git
apt update
apt install git -y
# Clone this repo as a bare repo
git clone --bare https://github.com/JasonJooste/config $HOME/.cfg
# Checkout files with home as the working tree directory
git --git-dir="$HOME/.cfg" --work-tree="$HOME" checkout -f
# Add the aliases and functions in .bashrc and .bash_aliases
. "$HOME/.bashrc"
```

Either run all of the setup scripts individually or all of them at once:
```bash
# Run the setup scripts
find .setup -name '*.sh' -exec bash {} ';'
```
## Using config manager
The setup in this repo defines an alias `config` for a git repo in the `.cfg` directory with a working tree in the home directory and a `.gitignore` that ignores all files. To add a config file the add needs to be forced, e.g. `config add -f .bashrc`. All git commands are valid, just use `config` instead of `git`. 


