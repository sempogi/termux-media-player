#!/data/data/com.termux/files/usr/bin/bash
#assuming you have termux already installed
#Arm64 Xiaomi Mi A3 Android 10
#Code Editor termux nano and QuickEdit+
#interpreter termux android
#Nov. 15 2020
cd $HOME
echo "installing dependencies"
echo "please allow termux to access storage"
sleep 5
termux-setup-storage
apt update && apt upgrade
#some of this dependences already installed
pkg install termux-api
pkg install x11-repo
pkg install git
pkg install curl
pkg install python
pkg install figlet
pkg install dialog
pkg install mpv
pkg install ffmpeg
#optional 
pkg install nodejs
 #use for downloading videos
pip install --upgrade youtube_dl

echo "Setting up Environment"
if [ -d ~/storage/shared/ ]; then
echo "Directory is working"
else
echo "Directory not found!!!"

fi
git clone https://github.com/sempogi/termux-media-player.git
if [ -d $HOME/termux-media-player ]; then
cd $HOME/termux-media-player
cp test.png $HOME/test.png
echo "Githud Directory Exist"
else
echo "Working directory not found..try running again"
exit
fi
cp tos.sh $PREFIX/bin/mediaplay
if [ -e $PREFIX/bin/mediaplay ]; then
chmod +x $PREFIX/bin/mediaplay
echo "Media Player Installed Successfully"
fi
if [ -d $HOME/.shortcuts ]; then
echo "Installing Shotcuts"


else
mkdir $HOME/.shortcuts
echo "Trying to creat Shortcuts"
fi
echo "mediaplay"> $HOME/.shortcuts/Mediaplayer.sh

if  [ -e  $HOME/.shortcuts/Mediaplayer.sh ]; then
chmod +x  $HOME/.shortcuts/Mediaplayer.sh
echo "Shortcut Installed"
fi
figlet " " SEM
echo "CODEX4"
echo "type '"mediaplay"' and hit enter"
#mediaplay
