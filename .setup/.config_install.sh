# Install my git config setup
TYPE="$1"
# Basic is the default type
if [ -z $TYPE ]
then
    TYPE=BASIC
fi
# Check for the possible types
if [[ ! $TYPE =~ (BASIC|CMDLINE|GUI) ]]
then
  echo 'Inputs must be either BASIC, CMDLINE, GUI or empty (defaults to basic)'
  exit 1
fi

## Basic install
# Install git
echo 'Installing config'
sudo apt update
sudo apt install git -y
# Clone this repo as a bare repo
git clone --bare https://github.com/JasonJooste/config "$HOME/.cfg"
# Checkout files with home as the working tree directory
git --git-dir="$HOME/.cfg" --work-tree="$HOME" checkout -f
# Add the aliases and functions in .bashrc and .bash_aliases
. "$HOME/.bashrc"
# Install the basic command line functions
find "$HOME/.setup/basic" -name '*.sh' -exec bash {} ';'
## Now install cmdline utils
if [ $TYPE != "BASIC" ]
then
  echo 'Installing cmdline utilities'
  find "$HOME/.setup/cmdline" -name '*.sh' -exec bash {} ';'
else
  exit 0
fi
# Finally the GUI snap installs
echo 'Install GUI utilities'
find "$HOME/.setup/gui" -name '*.sh' -exec bash {} ';'
# The "other" dir should be installed manually
