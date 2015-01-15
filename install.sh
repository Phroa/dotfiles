#!/bin/bash

# Create symlinks to install a fresh copy of all the dotfiles here.

success=0
skipped=0

function skip() {
	let skipped+=1
	echo -e "\e[36m$HOME/$1\e[0m already exists! \e[31mSkipping...\e[0m \e[36m[\e[0m\e[31m$skipped skipped\e[0m\e[36m]\e[0m"
}

function link() {
	let success+=1
	ln -s "$HOME/$1" "$HOME/$2"
	echo -e "\e[36m$HOME/$2\e[0m linked from \e[36m$HOME/$1\e[0m \e[36m[\e[0m\e[32m$success linked\e[0m\e[36m]\e[0m"
}

if [[ -f $HOME/.zshrc ]]; then
	skip ".zshrc"
else
	link "dotfiles/zsh/zshrc" ".zshrc"
fi

if [[ -f $HOME/.gemrc ]]; then
	skip ".gemrc"
else
	link "dotfiles/gemrc" ".gemrc"
fi

if [[ -d $HOME/.vim ]]; then
	skip ".vim"
else
	link "dotfiles/vim" ".vim"
fi

echo -e "\e[33mLinked\e[0m \e[32m$success\e[0m \e[33mfiles/folders and skipped \e[0m\e[31m$skipped\e[0m\e[33m.\e[0m"

if [[ $skipped -gt 0 ]]; then
	echo -e "\e[31mIf this is the first time you've ran this script, please remove the files that have been skipped.\e[0m"
	exit $skipped
fi
