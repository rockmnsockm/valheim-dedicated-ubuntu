#!/bin/bash

sudo useradd -m steam
sudo passwd steam
sudo usermod -aG sudo steam
sudo -u steam -s
cd /home/steam
sudo add-apt-repository multiverse
sudo apt install software-properties-common
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install lib32gcc-s1 steamcmd
