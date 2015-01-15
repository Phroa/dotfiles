#!/usr/bin/env bash

# Create symlinks to install a fresh copy of all the dotfiles here.

success=0
skipped=0

# Formatting bits.
reset_code=$(tput sgr0)

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
cyan=$(tput setaf 6)

# Functions

skip() {
	# increment counter of skipped files
	let skipped+=1
	printf "%b%s%b already exists! %bSkipping... %b[%b%i skipped%b]\n" "${cyan}" "${HOME}/${1}" "${reset_code}" "${red}" "${reset_code}" "${red}" "${skipped}" "${reset_code}"
}

link() {
	# increment counter of successfully linked files
	let success+=1
	ln -s "${HOME}/${1}" "${HOME}/${2}"
	printf "%b%s%b linked from %b%s %b[%b%i linked%b]\n" "${cyan}" "${HOME}/${2}" "${reset_code}" "${cyan}" "${HOME}/${1}" "${reset_code}" "${reset_code}" "${green}" "${success}" "${reset_code}"
}

# One if-else for each file. `-f' used to check files' existance, `-d' for folders

if [[ -f "${HOME}/.zshrc" ]]; then
	skip ".zshrc"
else
	link "dotfiles/zsh/zshrc" ".zshrc"
fi

if [[ -f "${HOME}/.gemrc" ]]; then
	skip ".gemrc"
else
	link "dotfiles/gemrc" ".gemrc"
fi

if [[ -d "${HOME}/.vim" ]]; then
	skip ".vim"
else
	link "dotfiles/vim" ".vim"
fi

printf "%bLinked %b%i%b files/folders and skipped %b%i%b.%b\n" "${yellow}" "${green}" "${success}" "${yellow}" "${red}" "${skipped}" "${yellow}" "${reset_code}"

if [[ ${skipped} -gt 0 ]]; then
	printf "%bIf this is the first time you've ran this script, please remove the files that have been skipped.%b\n" "${red}" "${reset_code}"
	exit ${skipped}
fi
