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

Run all of the scripts by running `.config_install.sh`. This script has three options, BASIC (default), CMDLINE and GUI:
- Basic: Basic install that will make the config work. The git config and tmux/neovim/vim. This stops errors in the bashrc. 
- Cmdline: Not much more than basic at the moment. It also adds the deadsnakes ppa and installs python3.10
- GUI: For installs with a gui (basically a new work laptop). Includes teams and slack. 

It can be simply run as:

```bash
bash <(curl https://raw.githubusercontent.com/JasonJooste/config/main/.setup/.config_install.sh)
```
for basic or give one of the other options, e.g. 
```bash
bash <(curl https://raw.githubusercontent.com/JasonJooste/config/main/.setup/.config_install.sh) GUI
```
This will download the install script and then run it to install the config. 

## Adding automatic backup
Just add the `.backup_run.bash` script to bash to make the backup run automatically (currently has bucket hardcoded into settings. Ideally, I'll set something up with local config later. 

## Using config manager
The setup in this repo defines an alias `config` for a git repo in the `.cfg` directory with a working tree in the home directory and a `.gitignore` that ignores all files. To add a config file the add needs to be forced, e.g. `config add -f .bashrc`. All git commands are valid, just use `config` instead of `git`. 


