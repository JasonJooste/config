# Get the deadsnakes ppa and install python 3.10
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt install -y python3.10 python3.10-venv python3-venv
# Install pipx for global installs in venvs
sudo apt install pipx
pipx ensurepath
sudo pipx ensurepath --global
# Install the latest poetry
pipx install poetry
poetry completions bash >> ~/.bash_completion
