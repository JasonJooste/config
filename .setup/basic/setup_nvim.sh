# A script for installing neovim and plugins. The ~/.config/nvim/coc-settings.json and ~/.config/nvim/init.vim files are assumed to already be populated from the git config repo.
mkdir "$HOME/.setup/tmp"
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt install -y neovim curl make
# Install vim-plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install nodejs
curl -sL install-node.vercel.app/lts >> "$HOME/.setup/tmp/curl_install.sh"
sudo bash "$HOME/.setup/tmp/curl_install.sh" -y
# Install plugins
nvim --headless -c "PlugInstall --sync" -c qa
rm -r "$HOME/.setup/tmp"
