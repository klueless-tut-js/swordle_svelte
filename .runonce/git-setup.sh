#!/bin/bash

function kl_subheading {
  echo -e "[ \033[93m$1\033[0m ]"
}

# START OF SCRIPT

kl_subheading "initializing git repository"

# git init
git remote add origin git@github.com:klueless-tut-js/swordle_svelte.git
git branch -M main

git add .
git commit -am 'first commit'
git tag v1.0.0 -a -m 'swordle_svelte initialize repository'

git push -u origin main --tags
