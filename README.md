# valheim-ubuntu
Runs a dedicated Vaheim server in Ubuntu 20.04 LTS x86/64, amd64 focal image

# GCP Setup

Instructions for setting up the server on a GCP compute instance.

> NOTE: It might be better to create the steam user via SSH Keys when creating the instance instead of manually creating the user later

### Set up the GCP Compute Instance
- Name the instance something appropriate for GCP bot (if using GCP bot otherwise it doesn't matter)
- Use an `e2-medium (2 vCPU, 1 core, 4 GB Memory)` instance
- Set the boot disk to use `Ubuntu 20.04 LTS x86/64, amd64 focal image`
  - Change the boot disk size to 30 GB
- Add a network tag `valnet`
- Create a new SSH key with PuTTY Key Generator (Comes with [PuTTY](https://ninite.com/putty/))
  - Click `Generate` using the default options
  - Move your mouse around to generate randomness
  - Under `Key comment` enter the username you want to log in with
  - Under `Key passphrase` enter the password you want to log in with
  - **Save the public and private key somewhere safe** **IMPORTANT**
- Under `Security` > `Manage Access` > `Add Item` and paste the public key contents from PuTTY Key Generator
- Create the instance

### Connect to the new instance
- SSH into the instance using your favorite SSH client and the private key along with the username and password from earlier. You'll connect using the `External IP` listed in the `VM Instances` dashboard

### Install SteamCMD
- Now that you're connected to the new Ubuntu instance, install SteamCMD
- Add a user account for steam
  - `sudo useradd -m steam`
  - `sudo passwd steam`
  - `sudo usermod -aG sudo steam`
- Browse to the steam user's home directory
  - `sudo -u steam -s`
  - `cd /home/steam`
- Install SteamCMD:
```
sudo add-apt-repository multiverse
sudo apt install software-properties-common
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install lib32gcc-s1 steamcmd
```

### Valheim Server Setup
- Add a path environment variable for `usr/games`
  - `sudo nano ~/.bashrc`
  - Add the line: `export PATH="/usr/games:$PATH"` to the end of the file
  - Reboot the GCP instance: `sudo reboot`
- Download the server gamefiles
  - Log in as the steam user: `sudo -u steam -s`
  - Change to the steam dir: `cd /home/steam`
  - `steamcmd +login anonymous +force_install_dir /home/steam/.steam/steamapps/common/valheim +app_update 896660 validate +exit`
