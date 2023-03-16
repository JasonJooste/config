# A script for installing neovim and plugins. The ~/.config/nvim/coc-settings.json and ~/.config/nvim/init.vim files are assumed to already be populated from the git config repo.
apt update
apt install neovim curl -y
# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install nodejs
bash <(curl -sL install-node.vercel.app/lts) -y
# Install plugins
nvim --headless -c 'PlugInstall --sync' -c 'qa'

