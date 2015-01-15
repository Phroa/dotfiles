#!/bin/bash

# Create symlinks to install a fresh copy of all the dotfiles here.

success=0
skipped=0

function skip() {
	let skipped+=1
	echo "$HOME/$1 already exists! Skipping... [$skipped skipped]"
}

function link() {
	let success+=1
	ln -s "$HOME/$1" "$HOME/$2"
	echo "$HOME/$2 linked from $HOME/$1! [$success linked]"
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

echo "Linked $success files/folders and skipped $skipped."

if [[ $skipped -gt 0 ]]; then
	echo "If this is the first time you've ran this script, please remove the files that have been skipped."
	exit $skipped
fi
