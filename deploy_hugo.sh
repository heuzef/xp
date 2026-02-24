#!/bin/bash
# Update, generate and publish the website with Hugo
cd ~/GIT/xp
git pull
cd xp
hugo build
