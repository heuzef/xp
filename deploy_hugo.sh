#!/bin/bash
# Update, generate and publish the website with Hugo
cd ~/GIT/xp
git pull
git submodule update --init --recursive
cd ~/GIT/xp/xp
hugo
