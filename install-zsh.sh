#!/usr/bin/env bash
# This script will install zsh, oh-my-zsh, powerlevel10k theme, fonts, and plugins. 
# To run the script, you can use the following command: 
# >>> bash install-zsh.sh
# After running the script, you need to restart your terminal.

source slib.sh

# install oh my zsh and oh my zsh
apt-get install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install powerlevel10k them
git_clone_if_not_exists https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' $HOME/.zshrc

# install fonts
_FONTS_DIR="$HOME/.local/share/fonts/"
cp -r fonts/* "$_FONTS_DIR"
fc-cache -f -v

# install zsh fuzzy finder
apt-get install fzf
echo "# Set up fzf key bindings and fuzzy completion" >> $HOME/.zshrc

# install plugins
echo "Installing plugins..."
git_clone_if_not_exists https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
include_plugin zsh-syntax-highlighting

git_clone_if_not_exists https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
include_plugin zsh-autosuggestions

git_clone_if_not_exists https://github.com/sunlei/zsh-ssh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-ssh
include_plugin zsh-ssh

mkdir $ZSH_CUSTOM/plugins/poetry && poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry
include_plugin poetry

apt-get install autojump

include_plugin git docker sudo colored-man-pages autojump

chsh -s "$(which zsh)"

echo "Setup aliases..."
cp custom/aliases.zsh $ZSH_CUSTOM/aliases.zsh

echo "Please restart your terminal to see the changes."
